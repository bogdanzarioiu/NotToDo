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
                        .font(.system(size: 20, weight: .heavy))
                    List {
                        ForEach(notTodos, id: \.self) { notToDo in
                           Text(notToDo)
                        }
                        .onDelete(perform: deleteNotToDo(indexSet:))
                        
                        
                        
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
                            Text("+")
                                .padding()
                                .foregroundColor(.white)
                                .font(.system(size: 40, weight: .medium))
                                .background(Color(.systemGreen))
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        })
                    }.padding()
                }
            }
        }.sheet(isPresented: $showNewNotToDo, content: {
            NewNotToDoView()
        })
    }
    
    func deleteNotToDo(indexSet: IndexSet) {
        print("item deleted at: \(indexSet)")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
