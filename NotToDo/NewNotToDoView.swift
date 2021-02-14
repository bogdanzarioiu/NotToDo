//
//  NewNotToDoView.swift
//  NotToDo
//
//  Created by Bogdan on 2/13/21.
//

import Amplify
import SwiftUI

struct NewNotToDoView: View {
    @State private var newNotToDo = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Enter a new Not ToDo!")
                .font(.system(size: 30, weight: .heavy))
            TextEditor(text: $newNotToDo)
                .foregroundColor(Color(.systemGray))
            Spacer()
            Button(action: {
                saveNotToDo()
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Save")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding()
                    .padding(.horizontal, 12)
                    .background(Color(.systemGreen))
                    .cornerRadius(4)
            })
        }.padding()
    }
    
    func saveNotToDo() {
        print(newNotToDo)
        let notTODO = NotToDo(body: newNotToDo)
        Amplify.DataStore.save(notTODO) { result in
            switch result {
            case .success:
                print("Saved New NotTODO")
             
            //maybe to show an alert here in case the data can't be saved
            case .failure:
                print("Error while trying to save the new NotTODO")
                
            }
        }
    }
}

struct NewNotToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NewNotToDoView()
    }
}
