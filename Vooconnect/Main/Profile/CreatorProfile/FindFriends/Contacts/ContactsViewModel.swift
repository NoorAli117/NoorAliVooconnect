//
//  ContactsViewModel.swift
//  Vooconnect
//
//  Created by Online Developer on 27/03/2023.
//

import Foundation
import ContactsUI

class ContactsViewModel: ObservableObject{
    
    /// Phone Contacts List
    @Published var contacts: [CNContact] = []
    /// Users List By Phone Contacts
    @Published var friendsList: [UserDetail] = []
    
    init(){
        getContacts()
    }
    
    
    /// Get name by CNContact
    /// - Parameter contact: Phone Contact
    /// - Returns: will return name
    func getName(contact: CNContact) -> String{
        return contact.givenName
    }
    
    /// Get phone number by CNContact
    /// - Parameter contact: Phone Contact
    /// - Returns: will return phone number
    func getPhoneNumber(contact: CNContact) -> String{
        return contact.phoneNumbers.first?.value.stringValue ?? ""
    }
    
    /// Get all phone numbers from Contacts Array
    /// - Returns: will return the array of string of phone numbers
    func getAllContactsPhoneNo() -> [String]{
        var phoneNumbers: [String] = []
        for contact in contacts {
            phoneNumbers.append(getPhoneNumber(contact: contact))
        }
        return phoneNumbers
    }
    
    /// Get Image by Contact
    /// - Parameter contact: CNContact
    /// - Returns: will return the contact image
    func getImage(contact: CNContact) -> UIImage {
        guard let imageData = contact.thumbnailImageData else { return UIImage(named: "profileicon")!}
        return UIImage(data: imageData) ?? UIImage(named: "profileicon")!
    }
    
    /// Get Phone Contacts
    func getContacts() {
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactThumbnailImageDataKey] as [Any]
        
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                print("Error fetching containers")
            }
        }
        contacts = results
        findUsersByPhoneNumbers()
    }
    
    /// Find Users By Phone Numbers
    func findUsersByPhoneNumbers(){
        let params: [String: Any] = [
            "phones": getAllContactsPhoneNo()
        ]
        NetworkManager.makeEndpointCall(fromEndpoint: .findUsersByPhone, withDataType: GetUsersModel.self, parameters: params) { [weak self] result in
            switch result {
            case .success(let model):
                logger.error("Successfully Get Users By Phone Numbers", category: .profile)
                self?.friendsList = model.users ?? []
            case .failure(let error):
                logger.error("Error Getting Users By Phone Numbers: \(error.localizedDescription)", category: .profile)
            }
        }
    }
}
