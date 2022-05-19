//
//  ProfileView.swift
//  Auth without storyboard
//
//  Created by Азамат Кемал on 13.05.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @State var isAvaAlertPresented = false
    @State var isQuitAlertPresented = false
    @State var isAuthAlertPresented = false
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 16) {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(8)
                    .background(Color.gray)
                    .clipShape(Circle())
                    .onTapGesture {
                        isAvaAlertPresented.toggle()
                    }
                    .confirmationDialog("Откуда взять фотку", isPresented: $isAvaAlertPresented) {
                        Button {
                            print("Library")
                        } label: {
                            Text("Из галереи")
                        }
                        Button {
                            print("Camera")
                        } label: {
                            Text("С камеры")
                        }
                    }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Горабачёв Владос Кадырович")
                        .bold()
                    Text("mamamacriminal@mail.ru")
                }
            }
            VStack(alignment: .leading, spacing: 20) {
                Text("Уровень английского языка:")
                    .bold()
                Text("Россия, Московская область, г. Одинцово, ул. Дениса Давыдова 1")
            }
            List {
                Text("Ваши баллы буду тут:")
            }.listStyle(.plain)
            
            Button {
                isQuitAlertPresented.toggle()
            } label: {
                Text("Выйти")
                    .padding()
                    .padding(.horizontal, 20)
                    .padding(.vertical, -5)
                    .foregroundColor(Color.white)
                    .font(.custom("Avenir", size: 20))
                    .background(Color.red)
                    .cornerRadius(15)
            }.padding()
                .confirmationDialog("Действительно хотите выйти?", isPresented: $isQuitAlertPresented, titleVisibility: .visible) {
                    Button {
                        isAuthAlertPresented.toggle()
                    } label: {
                        Text("Да")
                    }
                }
            }
        .fullScreenCover(isPresented: $isAuthAlertPresented, onDismiss: nil) {
            AuthView()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
