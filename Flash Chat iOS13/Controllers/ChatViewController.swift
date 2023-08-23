import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseCoreInternal
import FirebaseAppCheckInterop

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore()
    
    var messages : [Message] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        navigationItem.hidesBackButton=true
        navigationItem.title = "Chats"
        loadMessages()
    }
    func loadMessages(){
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
            self.messages=[]
            if let e = error{
                print("Not able to load messages!", e)
            }
            else{
                if let data = querySnapshot?.documents{
                    for d in data{
                        if let sender = d.data()[K.FStore.senderField] as? String, let message = d.data()[K.FStore.bodyField] as? String{
                            self.messages.append(Message(body: message, sender: sender))
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                        
                    }
                }
            }
        }
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let sender = Auth.auth().currentUser?.email,let messageBody = messageTextfield.text{
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField:sender, K.FStore.bodyField:messageBody, K.FStore.dateField:Date().timeIntervalSince1970]) { error in
                if let e = error{
                    print("Data was not saved due to error", e.localizedDescription)
                }
                else{
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let m = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = m.body
        if m.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.backgroundColor=UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = .white
        }
        else{
            cell.leftImageView.isHidden=false
            cell.rightImageView.isHidden=true
            cell.backgroundColor=UIColor(named: K.BrandColors.purple)
            cell.label.textColor = .white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
}
