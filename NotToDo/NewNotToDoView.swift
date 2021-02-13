//
//  NewNotToDoView.swift
//  NotToDo
//
//  Created by Bogdan on 2/13/21.
//

import SwiftUI

struct NewNotToDoView: View {
    @State private var newNotToDo = "new not todo..."
    
    var body: some View {
        VStack {
            Text("Enter a new Not ToDo!")
                .font(.system(size: 30, weight: .heavy))
            TextEditor(text: $newNotToDo)
                .foregroundColor(Color(.systemGray))
            Spacer()
            Button(action: {
                saveNotToDo()
                
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
    }
}

struct NewNotToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NewNotToDoView()
    }
}
