import CoreLocation

struct Address: Decodable {
    typealias StreetType = String
    typealias DistrictType = String
    typealias NoteType = String?
    
    let street: StreetType
    let district: DistrictType
    let note: NoteType
}

struct Contact: Decodable {
    typealias PhoneNumberType = Int
    typealias PhoneNumbersType = [PhoneNumberType]
    typealias EmailAddressType = String?
    typealias UrlType = String?
    
    let phoneNumbers: PhoneNumbersType
    let emailAddress: EmailAddressType
    let url: UrlType
}

struct DataItem: Decodable, Identifiable {
    typealias IdType = Int
    typealias CategoryType = String
    typealias NameType = String
    typealias AddressType = Address
    typealias ContactType = Contact
    typealias CoordinatesType = CLLocationCoordinate2D
    typealias KeywordType = String
    typealias KeywordsType = [KeywordType]?
    typealias DistanceType = Double?
    
    let id: IdType
    let category: CategoryType
    let name: NameType
    let address: AddressType
    let contact: ContactType
    let coordinates: CoordinatesType
    let keywords: KeywordsType
    var distance: DistanceType
}

private enum CodingKeys: String, CodingKey {
    case id
    case category
    case name
    case address
    case contact
    case coordinates
    case keywords
    case distance
}

extension CLLocationCoordinate2D: Decodable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let latitude = try container.decode(Double.self)
        let longitude = try container.decode(Double.self)
        self.init(latitude: latitude, longitude: longitude)
    }
}

extension DataItem {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do { distance = try container.decode(Double.self, forKey: .distance) }
        catch { distance = 0 }
        
        do { keywords = try container.decode([String].self, forKey: .keywords) }
        catch { keywords = [] }
        
        id = try container.decode(IdType.self, forKey: .id)
        category = try container.decode(CategoryType.self, forKey: .category)
        name = try container.decode(NameType.self, forKey: .name)
        address = try container.decode(AddressType.self, forKey: .address)
        contact = try container.decode(ContactType.self, forKey: .contact)
        coordinates = try container.decode(CoordinatesType.self, forKey: .coordinates)
    }
}

extension DataItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(category)
        hasher.combine(name)
        hasher.combine(address.street)
        hasher.combine(address.district)
        hasher.combine(address.note)
        hasher.combine(contact.phoneNumbers)
        hasher.combine(contact.emailAddress)
        hasher.combine(contact.url)
        hasher.combine(coordinates.latitude)
        hasher.combine(coordinates.longitude)
        hasher.combine(keywords)
        hasher.combine(distance)
    }
}

extension DataItem: Equatable {
    static func == (lhs: DataItem, rhs: DataItem) -> Bool {
        return
        lhs.id == rhs.id &&
        lhs.category == rhs.category &&
        lhs.name == rhs.name &&
        lhs.address.street == rhs.address.street &&
        lhs.address.district == rhs.address.district &&
        lhs.address.note == rhs.address.note &&
        lhs.contact.phoneNumbers == rhs.contact.phoneNumbers &&
        lhs.contact.emailAddress == rhs.contact.emailAddress &&
        lhs.contact.url == rhs.contact.url &&
        lhs.coordinates.latitude == rhs.coordinates.latitude &&
        lhs.coordinates.longitude == rhs.coordinates.longitude &&
        lhs.keywords == rhs.keywords &&
        lhs.distance == rhs.distance
    }
}

let mockedItems: [DataItem] = [
    DataItem(
        id: 101,
        category: "hospital",
        name: "Name 1 long name long name long name long name",
        address: Address(
            street: "Address steet",
            district: "Address district 1",
            note: "Note"
        ),
        contact: Contact(
            phoneNumbers: [123456789],
            emailAddress: "email@email.com",
            url: "https:/www.url.com/"
        ),
        coordinates: CLLocationCoordinate2D(latitude: 50.08804, longitude: 14.42076),
        keywords: ["adult-care", "child-care"],
        distance: nil
    ),
    DataItem(
        id: 102,
        category: "hospital",
        name: "Name 2",
        address: Address(
            street: "Address steet",
            district: "Address district 2",
            note: nil
        ),
        contact: Contact(
            phoneNumbers: [123456789],
            emailAddress: "email@email.com",
            url: "https:/www.url.com/"
        ),
        coordinates: CLLocationCoordinate2D(latitude: 50.08804, longitude: 14.42076 + 1),
        keywords: nil,
        distance: nil
    ),
    DataItem(
        id: 201,
        category: "pharmacy",
        name: "Name 3",
        address: Address(
            street: "Address steet",
            district: "Address district 1",
            note: nil
        ),
        contact: Contact(
            phoneNumbers: [123456789],
            emailAddress: "email@email.com",
            url: "https:/www.url.com/"
        ),
        coordinates: CLLocationCoordinate2D(latitude: 50.08804 - 1, longitude: 14.42076),
        keywords: ["stomatology"],
        distance: nil
    ),
    DataItem(
        id: 202,
        category: "pharmacy",
        name: "Name 4",
        address: Address(
            street: "Address steet",
            district: "Address district 4",
            note: "Note"
        ),
        contact: Contact(
            phoneNumbers: [123456789],
            emailAddress: "email@email.com",
            url: "https:/www.url.com/"
        ),
        coordinates: CLLocationCoordinate2D(latitude: 50.08804 - 1, longitude: 14.42076 + 1),
        keywords: nil,
        distance: nil
    ),
    DataItem(
        id: 301,
        category: "vet",
        name: "Name 5",
        address: Address(
            street: "Address steet",
            district: "Address district 2",
            note: nil
        ),
        contact: Contact(
            phoneNumbers: [123456789],
            emailAddress: "email@email.com",
            url: "https:/www.url.com/"
        ),
        coordinates: CLLocationCoordinate2D(latitude: 50.08804 - 2, longitude: 14.42076),
        keywords: nil,
        distance: nil
    ),
    DataItem(
        id: 302,
        category: "vet",
        name: "Name 6",
        address: Address(
            street: "Address steet",
            district: "Address district 6",
            note: nil
        ),
        contact: Contact(
            phoneNumbers: [123456789],
            emailAddress: "email@email.com",
            url: "https:/www.url.com/"
        ),
        coordinates: CLLocationCoordinate2D(latitude: 50.08804 - 2, longitude: 14.42076 + 1),
        keywords: nil,
        distance: nil
    )
]
