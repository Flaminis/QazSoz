import Foundation
import Parse

class Suggestion: PFObject {
    
    @NSManaged var wrongWord: String
    @NSManaged var sugg: String
    
}

extension Suggestion: PFSubclassing {
    override class func initialize() {
        struct Static {
            static var onceToken : Int = 0;
        }
        
    }
    static func parseClassName() -> String {
        return ParseClass.Suggestion
    }
}
