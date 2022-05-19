//
//  ContentView.swift
//  Auth without storyboard
//
//  Created by Азамат Кемал on 13.05.2022.
//

import SwiftUI
import Firebase

struct AuthView: View {
    
    // Определяем состояние для смены View()
    @State private var isAuth = true
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    // Состояние для показа TabView
    @State private var isTabViewShow = false
    
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        
        VStack(
            
            spacing: 20
            
        ) {
            Text(isAuth ? "Авторизация" : "Регистрация")
                .padding(isAuth ? 16 : 20)
                .padding(.horizontal, 30)
                .font(.title2.bold())
                .background(Color("blackWhite"))
                .cornerRadius(isAuth ? 30 : 60)
            
            VStack {
                TextField("Введите email", text: $email)
                    .padding()
                    .background(Color("blackWhite"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                SecureField("Введите пароль", text: $password)
                    .padding()
                    .background(Color("blackWhite"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                if (!isAuth) {
                    SecureField("Повторите пароль", text: $confirmPassword)
                        .padding()
                        .background(Color("blackWhite"))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                    
                }
                
                Button {
                    
                    if (isAuth) {
                        print("Авторизация пользователя через Firebase")
                        
                        AuthService.shared.signIn(email: self.email,
                                                  password: self.password) { result in
                            switch result {
                                
                            case .success(_):
                                isTabViewShow.toggle() // показ
                            case .failure(let error):
                                alertMessage = "Ошибка авторизации: \(error.localizedDescription)"
                                isShowAlert.toggle() //показываем alert
                            }
                        }
                
                    } else {
                        print("Регистрация пользователя")
                        
                        // проверка пароля
                        
                        guard password == confirmPassword else {
                            self.alertMessage = "Пароли не совпадают"
                            self.isShowAlert.toggle()
                            return
                        }
                        
                        
                        
                        AuthService.shared.signUp(
                            email: self.email,
                            password: self.password) { result in
                                switch result {
                                    
                                case .success(let user):
                                    alertMessage = "Вы зарегистрировались с email \(user.email!)"
                                    
                                    //Меняем для состояния title форм
                                    self.email = ""
                                    self.password = ""
                                    self.confirmPassword = ""
                                    self.isAuth.toggle()
                                    self.isShowAlert.toggle() //покажем alert
                                    
                                case .failure(let error):
                                    alertMessage = "Ошибка регистрацииёё\(error.localizedDescription)"
                                    self.isShowAlert.toggle() //покажем alert
                                }
                            }
                        
                        
                    
                    }
                } label: {
                    Text(isAuth ? "Войти" : "Создать аккаунт")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [Color("yellow"), Color("orange")], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(.black)
                    
                }
                
                //меняем isAuth
                Button {
                    // переключение на противоположное состояние (false -> true)
                    isAuth.toggle()
                } label: {
                    Text(isAuth ? "Ещё не с нами?" : "Уже есть аккаунт")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(.black)
                    
                }
            }
            .padding()
            .padding(.top, 20)
            .background(Color("blackWhite"))
            .cornerRadius(30)
            .padding(isAuth ? 30 : 15)
            .alert(alertMessage,
                   isPresented: $isShowAlert) {
                Button { } label: {
                    Text("OK")
                }
            }
            
            
            
            // типо что после нажатия
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("pic1")
                    .ignoresSafeArea()
                    .blur(radius: isAuth ? 0 : 6)
                        )
                .animation(Animation.easeInOut(duration: 0.3), value: isAuth)
        // как вариант перехода
//                .sheet(isPresented: $isTabViewShow, content: {
//                    let mainTabBarViewModel = MainTabBarViewModel(
//                        user: AuthService.shared.currentUser!)
//
//                    MainTabBar(viewModel: mainTabBarViewModel)
//                })
                .fullScreenCover(isPresented: $isTabViewShow) {
                    
                    let mainTabBarViewModel = MainTabBarViewModel(
                        user: AuthService.shared.currentUser!)
                    
                    MainTabBar(viewModel: mainTabBarViewModel)
                } // показ экрана
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
