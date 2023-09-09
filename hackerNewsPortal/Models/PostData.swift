import Foundation

struct PostData:Decodable{
    let hits:[Post]
}

struct Post:Identifiable,Decodable{
    var id:String{
        return objectID
    }
    let objectID:String
    let title:String
    let points:Int
    let url:String?
}
