//
//  ContentView.swift
//  App-movilidad
//
//  Created by iOS Lab on 29/04/23.
//

import SwiftUI

struct vista1: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @State var showLogin = false
    @State var showSignUp = false
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack{
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("main-banners"))
                    .frame(width: 393, height: 130)
                Spacer()
                Rectangle()
                    .fill(Color("main-banners"))
                    .frame(width: 393, height: 100)
                    
            }.ignoresSafeArea()
            VStack(alignment: .center){
                if showLogin {
                    IniciarSesion().environment(\.managedObjectContext,managedObjContext)
                }
                if showSignUp{
                    SignUp().environment(\.managedObjectContext,managedObjContext)
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
    @Environment(\.managedObjectContext) var managedObjContext
    @State var username=""
    @State var password=""
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            
            VStack{
                RoundedRectangle(cornerRadius: 15)
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
                    if let resp = DataControllerDB().loadUserByEmailPassword(email: username, password: password, context: managedObjContext){
                        print("Login Ok")
                    }
                }) {
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

struct SignUp: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @State var nombre=""
    @State var edad=""
    @State var genero=""
    @State var correo=""
    @State var telefono=""
    @State var tipoVehiculo="Auto"
    @State var delegacion=""
    @State var password=""
    @State var aceptaTerminos=false
    
    let tiposVehiculo = ["Auto", "Moto", "Scooter", "Bicicleta", "Caminando"]
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            
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
                    
                    Section(header: Text("Términos y condiciones")) {
                        Toggle(isOn: $aceptaTerminos) {
                            Text("Acepto los términos y condiciones")
                        }
                    }
                }
                .padding()
                
                Button(action: {
                    // Acción para registrar al usuario
                    var edad_int = 0
                    if let value = Int32(edad){
                        edad_int = Int(value)
                    }
                    
                    var t_car = false
                    var t_motorcycle = false
                    var t_scooter = false
                    var t_bicycle = false
                    var t_walking = false

                    switch tipoVehiculo {
                    case "Auto":
                        t_car = true
                    case "Moto":
                        t_motorcycle = true
                    case "Scooter":
                        t_scooter = true
                    case "Bicicleta":
                        t_bicycle = true
                    case "Caminando":
                        t_walking = true
                    default:
                        t_car = false
                        t_motorcycle = false
                        t_scooter = false
                        t_bicycle = false
                        t_walking = false
                    }

                    
                    if let resp = DataControllerDB().addUser(name: nombre, age: Int32(edad_int), gender: genero, email: correo, cell_phone: telefono, t_car: t_car, t_motorcycle: t_motorcycle, t_scooter: t_scooter, t_bicycle: t_bicycle, t_walking: t_walking, preferred_location: delegacion, password: password, context: managedObjContext){
                        print("Usuario Registrado")
                    }
                    
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





struct vista1_Previews: PreviewProvider {
    static var previews: some View {
        vista1()
    }
}
