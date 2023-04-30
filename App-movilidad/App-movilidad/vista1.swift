//
//  ContentView.swift
//  App-movilidad
//
//  Created by iOS Lab on 29/04/23.
//

import SwiftUI

struct vista1: View {
    @State var showLogin = false
    @State var showSignUp = false
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack{
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color("main-banners"))
                    .frame(width: 393, height: 130)
                Spacer()
                Rectangle()
                    .fill(Color("main-banners"))
                    .frame(width: 393, height: 100)
                    
            }.ignoresSafeArea()
            VStack(alignment: .center){
                if showLogin {
                    IniciarSesion()
                }
                if showSignUp{
                    SignUp()
                }else {
                    VStack(alignment: .center, spacing: 20) {
                        Spacer()
                        Image("logo")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                            .foregroundColor(.black)
                            .padding()
                        Button("Iniciar sesión") {
                            withAnimation {
                                showLogin = true
                            }
                        }
                        .foregroundColor(.black)
                        .frame(width: 150,height: 50)
                        .background(Color("main-buttons").opacity(0.6))
                        .clipShape(Capsule())
                        Button("Registrarse") {
                            withAnimation {
                                showSignUp = true
                            }
                        }
                        .foregroundColor(.black)
                        .frame(width: 150,height: 50)
                        .background(Color("main-buttons").opacity(0.6))
                        .clipShape(Capsule())
                        Spacer()
                    }
                    .transition(.opacity)
                    .opacity(showLogin ? 0 : 1)
                }
            }
            
        }
    }
}

struct IniciarSesion: View {
    @State var username=""
    @State var password=""
    @State var showMenu=false
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            
            if showMenu {
                Menu1()
            }else{
                VStack{
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color("main-banners"))
                        .frame(width: 393, height: 130)
                    
                    Spacer()
                    
                }.ignoresSafeArea()
                
                VStack(alignment: .center){
                    TextField("Usuario", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    SecureField("Contraseña", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    
                    Button(action: {
                        showMenu = true
                    })  {
                        Text("Iniciar sesión")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(width: 200, height: 50)
                            .background(Color("main-buttons"))
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct SignUp: View {
    @State var nombre=""
    @State var edad=""
    @State var genero=""
    @State var correo=""
    @State var telefono=""
    @State var tipoVehiculo="Auto"
    @State var delegacion=""
    @State var password=""
    @State var aceptaTerminos=false
    @State var showLogin = false
    
    let tiposVehiculo = ["Auto", "Moto", "Scooter", "Bicicleta", "Caminando"]
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            
            if showLogin {
                IniciarSesion()
            }else{
                VStack(alignment: .center) {
                    Form {
                        Section(header: Text("Datos personales")) {
                            TextField("Nombre", text: $nombre)
                            TextField("Edad", text: $edad)
                            TextField("Género", text: $genero)
                        }
                        
                        Section(header: Text("Contacto")) {
                            TextField("Correo electrónico", text: $correo)
                            TextField("Teléfono", text: $telefono)
                            TextField("Delegación", text: $delegacion)
                        }
                        
                        Section(header: Text("Transporte")) {
                            Picker(selection: $tipoVehiculo, label: Text("Tipo de vehículo")) {
                                ForEach(tiposVehiculo, id: \.self) { tipo in
                                    Text(tipo)
                                }
                            }
                        }
                        
                        Section(header: Text("Contraseña")) {
                            SecureField("Contraseña", text: $password)
                        }
                        
                        Section(header: Text("Términos y condiciones"))
                        {
                            Toggle(isOn: $aceptaTerminos) {
                                Text("Acepto los términos y condiciones")
                            }
                            Text("Aceptas que los datos ingresados sean solo usados para el funcionamiento de la pltaforma, sin fines lucrativos")
                                .font(.system(size:12))
                        }
                    }
                    .padding()
                    
                    Button(action: {
                        showLogin = true
                    }) {
                        Text("Registrarse")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(width: 200, height: 50)
                            .background(Color("main-buttons"))
                            .cornerRadius(10)
                    }
                    .padding()
                    
                }
                
            }
        }
    }
}


struct Menu1: View {
    var body: some View {
        ZStack{Color.white
                .ignoresSafeArea()
            VStack{
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color("main-banners"))
                    .frame(width: 393, height: 130)
                Spacer()
                Rectangle()
                    .fill(Color("main-banners"))
                    .frame(width: 393, height: 100)
                    
            }.ignoresSafeArea()
            
            VStack(){
                Image("logo")
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .frame(width: 85.0, height: 85.0)
               
            }
        }
    }
}



struct vista1_Previews: PreviewProvider {
    static var previews: some View {
        vista1()
    }
}
