//
//  ContentView.swift
//  NotToDo
//
//  Created by Bogdan on 2/13/21.
//

import Amplify
import Combine
import SwiftUI


struct ContentView: View {
    //@State private var notTodos = Array(0..<20).map { _ in UUID().uuidString }
    @State private var notTodos = [NotToDo]()
    @State private var showNewNotToDo = false
    @State var observer: AnyCancellable?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Enter here the things not to do!")
                        .padding()
                        .font(.system(size: 20, weight: .heavy))
                    List {
                        ForEach(notTodos) { notToDo in
                            Text(notToDo.body)
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
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color(.systemGreen))
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                                .overlay(
//                                    Circle()
//                                        .stroke(Color.green)
//
//                                )
                        })
                    }.padding()
                }
            }
        }
        .onAppear {
            getNotToDos()
            observeNotToDos()
        }
        .sheet(isPresented: $showNewNotToDo, content: {
            NewNotToDoView()
        })
    }
    
    //load the data from the device when the app launches
    private func getNotToDos() {
        Amplify.DataStore.query(NotToDo.self) { result in
            switch result {
            case .success(let notToDos):
                print("successfully got the data.")
                self.notTodos = notToDos
            case .failure(let error):
                print("error while getting the Not ToDos: \(error)")
            }
            
        }
        
    }
    //observe changes in data and react accordingly
    private func observeNotToDos() {
     observer = Amplify.DataStore.publisher(for: NotToDo.self).sink { completion in
            switch completion {
            //TODO: - Implement error handling
            case .failure(let error):
                print(error)
            case .finished:
                print("Finished.")
                
            }
        } receiveValue: { change in
            guard let notTODO = try? change.decodeModel(as: NotToDo.self) else { return }
            switch change.mutationType {
            case "create":
                self.notTodos.append(notTODO)
            case "delete":
                if let index = self.notTodos.firstIndex(of: notTODO) {
                    self.notTodos.remove(at: index)
                }
            default:
                break
            }
        }

        
    }
    private func deleteNotToDo(indexSet: IndexSet) {
        print("item deleted at: \(indexSet)")
        
        var latestNotTODOs = notTodos
        latestNotTODOs.remove(atOffsets: indexSet)
        guard let nTODO = Set(latestNotTODOs).symmetricDifference(notTodos).first else { return }
        
        //delete the data
        Amplify.DataStore.delete(nTODO) { result in
            switch result {
            case .success:
                print("Deleted.")
            case .failure(let error):
                print("Couldn't delete data from DataStore: \(error)")
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
