import SwiftUI
import MapKit

struct ItemsList_ItemView: View {
    var item: DataItem
    
    var body: some View {
        let initialPosition: MapCameraPosition = .region(
            MKCoordinateRegion(
                center: item.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
            )
        )
        
        VStack(alignment: .leading) {
            Map(initialPosition: initialPosition) {
                Marker(
                    item.name,
                    systemImage: "cross.fill",
                    coordinate: item.coordinates
                )
                .tint(getCategoryColor(item.category))
            }
            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .cornerRadius(10)
            .aspectRatio(2, contentMode: .fit)
            .padding(.bottom, 5)
            
            Text(item.name)
                .font(.headline)
            
            if let keywords = item.keywords {
                if !keywords.isEmpty {
                    HStack {
                        ForEach(keywords, id: \.self) { keyword in
                            PillView(value: getKeywordLabel(keyword))
                        }
                    }
                    .padding(.bottom)
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(item.address.street)
                    Text(item.address.district)
                }
                
                Spacer()
                
                if let distance = item.distance {
                    if distance > 0 {
                        PillView(
                            value: "\(String(format: "%.1f", distance)) km",
                            variant: .gray
                        )
                    }
                }
            }
            
            if let note = item.address.note {
                Text("(\(note))")
                    .opacity(0.6)
            }
            
            HStack() {
                Spacer()
                
                NavigateButton(name: item.name, coordinates: item.coordinates)
                    .buttonStyle(.bordered)
                
                CallButton(phoneNumbers: item.contact.phoneNumbers)
                    .buttonStyle(.bordered)
                
                if (item.contact.url != nil) || (item.contact.emailAddress != nil) {
                    Menu(content: {
                        WebButton(url: item.contact.url)
                            .buttonStyle(.bordered)
                        
                        MailButton(emailAddress: item.contact.emailAddress)
                            .buttonStyle(.bordered)
                    }, label: {
                        Button {} label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .frame(width: 14, height: 3)
                                .padding(.vertical, 8)
                        }
                        .buttonStyle(.bordered)
                    })
                }
            }
            
            Spacer()
        }
    }
}

struct NavigateButton: View {
    let name: DataItem.NameType;
    let coordinates: DataItem.CoordinatesType;
    
    var body: some View {
        Button("Navigate") {
            let destination = MKMapItem(
                placemark: MKPlacemark(coordinate: coordinates)
            )
            
            destination.name = name
            
            MKMapItem.openMaps(
                with: [destination],
                launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            )
        }
    }
}

struct WebButton: View {
    let url: DataItem.ContactType.UrlType
    
    var body: some View {
        if let checkedUrl = url {
            Button("Website") {
                UIApplication.shared.open(URL(string: checkedUrl)!)
            }
        }
    }
}

struct MailButton: View {
    let emailAddress: String?
    
    var body: some View {
        if let emailAddress = emailAddress {
            Button("E-mail") {
                UIApplication.shared.open(URL(string: "mailto://\(emailAddress)")!)
            }
        }
    }
}

struct CallButton: View {
    let phoneNumbers: DataItem.ContactType.PhoneNumbersType
    
    var body: some View {
        if phoneNumbers.count == 1 {
            Button("Call") {
                UIApplication.shared.open(URL(string: "tel://\(formatPhoneNumber(phoneNumbers[0]))")!)
            }
        } else if phoneNumbers.count > 1 {
            Menu {
                ForEach(phoneNumbers, id: \.self) { phoneNumber in
                    Button(formatPhoneNumber(phoneNumber)) {
                        UIApplication.shared.open(URL(string: "tel://\(formatPhoneNumber(phoneNumber))")!)
                    }
                }
            } label: {
                Text("Call")
            }
        }
    }
}

struct ItemsList_ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsList_ItemView(item: mockedItems.first!)
    }
}
