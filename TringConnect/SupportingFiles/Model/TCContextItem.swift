//
//  TCContextItem.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import Foundation

extension Array {
    
    mutating func appendSafely(_ newElement: Element?) {
        guard let element = newElement else {
            return
        }
        
        self.append(element)
    }
}


struct TCContextItem: Decodable {
    private enum CodingKeys: String, CodingKey {
        case version
        case context
        case data
    }
    
    var version: String?
    var context: String?
    var homeData = [TCHomeItem]()
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        version = try? container.decode(String.self, forKey: .version)
        context = try? container.decode(String.self, forKey: .context)
        homeData = TCContextItem.parseContextItems(container, .data)
    }

    static func parseContextItems<Key: CodingKey>(_ container: KeyedDecodingContainer<Key>, _ key: Key) -> [TCHomeItem] {
        var contextItems = [TCHomeItem]()
        var family: NBCHomeItemType?
        guard var nestedUnKeyedContainer = try? container.nestedUnkeyedContainer(forKey: key) else {
            return contextItems
        }
        var tempContainer = nestedUnKeyedContainer
        
        while !nestedUnKeyedContainer.isAtEnd {
            let typeContainer = try? nestedUnKeyedContainer.nestedContainer(keyedBy: TCItemDiscriminator.self)
            
            do {
                family = try typeContainer?.decode(NBCHomeItemType.self, forKey: NBCHomeItemType.discriminator)
            } catch {
                print("Failed to receive the kind")
            }
            
            switch family {
            case .highlight:
                contextItems.appendSafely(try? tempContainer.decode(TCHighlightItem.self))
            case .post:
                contextItems.appendSafely(try? tempContainer.decode(TCStoryItem.self))
            case .course:
                contextItems.appendSafely(try? tempContainer.decode(TCCourseItem.self))
            default:
                _ = try? tempContainer.decode(TCUnknownKind.self)
                print("Unknown kind")
            }
        }
        
        return contextItems
    }
}

enum TCItemDiscriminator: String, CodingKey {
    case kind
}

protocol TCHomeItem: Decodable {
    var kind: String? { get }
}

struct TCUnknownKind: Decodable {
    private enum CodingKeys: String, CodingKey {
        case kind
    }
    var kind: String?
}

struct TCStoryItem: TCHomeItem {
    private enum CodingKeys: String, CodingKey {
        case kind
        case storyType
        case username
        case userDP
        case userDesignation
        case storySummary
        case storyAttachments
        case hashTags
        case timestamp
        case likesAndComments
    }

    var kind: String?
    var storyType: String?
    var username: String?
    var userDP: String?
    var userDesignation: String?
    var storySummary: String?
    var storyAttachments: TCAttachmentItem?
    var hashTags: String?
    var timestamp: String?
    var likesAndComments: TCLikesAndComments?
}

struct TCAttachmentItem: Decodable {
    private enum CodingKeys: String, CodingKey {
        case storyImages
        case promotions
    }

    var storyImages: [String?]?
    var promotions: TCPromotiontItem?
}

struct TCPromotiontItem: Decodable {
    private enum CodingKeys: String, CodingKey {
        case promotionsTitle
        case promotionsSubtitle
        case promotionsDP
    }

    var promotionsTitle: [String?]?
    var promotionsSubtitle: String?
    var promotionsDP: String?
}

struct TCLikesAndComments: Decodable {
    private enum CodingKeys: String, CodingKey {
        case likesCount
        case commentsCount
        case recentLikes
    }

    var likesCount: Int?
    var commentsCount: Int?
    var recentLikes: String?
}

struct TCHighlightItem: TCHomeItem {
    private enum CodingKeys: String, CodingKey {
        case kind
        case highlightList
    }

    var kind: String?
    var highlightList: [TCHighlight?]?
}

struct TCHighlight: Decodable {
    private enum CodingKeys: String, CodingKey {
        case username
        case userDP
    }

    var username: String?
    var userDP: String?
}

struct TCCourseItem: TCHomeItem {
    private enum CodingKeys: String, CodingKey {
        case kind
        case courses
        case timestamp
        case likesAndComments
    }

    var kind: String?
    var courses:[TCCourse?]?
    var timestamp: String?
    var likesAndComments: TCLikesAndComments?
}

struct TCCourse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case courseDescription
        case courseDP
    }

    var courseDescription: String?
    var courseDP: String?
}

enum NBCHomeItemType: String, Decodable {
    case highlight
    case post
    case course

    static var discriminator: TCItemDiscriminator = .kind
}
