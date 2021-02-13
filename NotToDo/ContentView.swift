//
//  ContentView.swift
//  NotToDo
//
//  Created by Bogdan on 2/13/21.
//

import SwiftUI

struct ContentView: View {
    @State private var notTodos = Array(0..<20).map { _ in UUID().uuidString }
    @State private var showNewNotToDo = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Enter here the things not to do!")
                        .padding()
                        .font(.system(size: 20, weight: .medium))
                    List(notTodos, id: \.self) { todo in
                        Text(todo)
                        
                    }
                    .listStyle(PlainListStyle())
                        
                }
                .navigationTitle("Not To Do")
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            self.showNewNotToDo.toggle()
                            
                        }, label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(.systemPurple))
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        }).padding()
                    }
                }
            }
        }.sheet(isPresented: $showNewNotToDo, content: {
            NewNotToDoView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
