//
//  ContentView.swift
//  App-movilidad
//
//  Created by iOS Lab on 29/04/23.
//

import SwiftUI
import MapKit


struct vista1: View {
    @Environment(\.managedObjectContext) var managedObjContext
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
                    
                    .transition(.opacity)
                    .opacity(showSignUp ? 0 : 1)
                }
            
            
        }
    }
}

struct IniciarSesion: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @State var username=""
    @State var password=""
    @State var showMenu=false
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            
            if showMenu {
                Menu1().environment(\.managedObjectContext,managedObjContext)
            }else{
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
                    TextField("Usuario", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textCase(.lowercase)
                        .padding()
                    
                    SecureField("Contraseña", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    
                    Button(action: {
                        if let resp = DataControllerDB().loadUserByEmailPassword(email: username, password: password, context: managedObjContext){
                          
                            showMenu = true
                        }
                        
                    })  {
                        Text("Iniciar sesión")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(width: 200, height: 50)
                            .background(Color("main-buttons"))
                            .cornerRadius(10)
                    } .transition(.opacity)
                        .opacity(showMenu ? 0 : 1)
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
    @State var showLogin = false
    
    let tiposVehiculo = ["Auto", "Moto", "Scooter", "Bicicleta", "Caminando"]
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            
            if showLogin {
                IniciarSesion().environment(\.managedObjectContext,managedObjContext)
                
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
                            showLogin = true
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
}


struct Menu1: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @State var showLogin = false
    @State var showMenu5 = false

    
    var body: some View {
        ZStack{Color.white
                .ignoresSafeArea()
            if showLogin{
                IniciarSesion().environment(\.managedObjectContext,managedObjContext)
            }
            
            if showMenu5{
                Menu5()
            }else {
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
                
                Text("MENU")
                    .font(.system(size:32))
                
                    .padding()
                
            
                HStack{
                    ZStack{
                        Rectangle()
                            .ignoresSafeArea()
                            .foregroundColor(Color(.gray))
                            .frame(width: 170, height: 150)
                            .cornerRadius(20)
                        Image("\("j")").resizable()
                            .frame(width: 150 , height: 120)
                    }
                    ZStack{
                        Rectangle()
                            .ignoresSafeArea()
                            .foregroundColor(Color(.gray))
                            .frame(width: 170, height: 150)
                            .cornerRadius(20)
                        Image("\("cdmx")").resizable()
                            .frame(width: 150 , height: 120)
                    }}
                HStack{
                    ZStack{
                        Rectangle()
                            .ignoresSafeArea()
                            .foregroundColor(Color(.gray))
                            .frame(width: 170, height: 150)
                            .cornerRadius(20)
                        Image("\("x")").resizable()
                        .frame(width: 150 , height: 120)}
                    
                    ZStack{
                        Rectangle()
                            .ignoresSafeArea()
                            .foregroundColor(Color(.gray))
                            .frame(width: 170, height: 150)
                            .cornerRadius(20)
                        Image("\("mapa")").resizable()
                        .frame(width: 140 , height: 110)}
                    
                }
                Button("O") {
                    withAnimation {
                        showMenu5 = true
                    }
                }
                .foregroundColor(.black)
                .frame(width: 150,height: 50)
                .background(Color("main-buttons").opacity(0.6))
                .clipShape(Capsule())
                Spacer()
                }
                
            }
        }
    }
}

struct Menu2: View {
    @Environment(\.managedObjectContext) var managedObjContext
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
                Text("a")
            
            }
        }
    }
}

struct Menu3: View {
    @Environment(\.managedObjectContext) var managedObjContext
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
                Text("a")
               
            }
        }
    }
}

struct Menu4: View {
    @Environment(\.managedObjectContext) var managedObjContext
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
                Text("a")
               
            }
        }
    }
}

struct Menu5: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @State var showLogin = false
    @State var showMenu1 = false

    var body: some View {
        ZStack{Color.white
                .ignoresSafeArea()
            if showMenu1{
                Menu1()
            }else {
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
                    MapView()
                        .edgesIgnoringSafeArea(.all)
                    VStack(){
                        Button("O") {
                            withAnimation {
                                showMenu1 = true
                            }
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .frame(width: 150,height: 50)
                        .background(Color("main-buttons").opacity(0.6))
                        .clipShape(Capsule())
                    
                    }
                }
            }
        }
    }
}

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 19.460_620, longitude: -99.064_520)
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 50, longitudinalMeters: 50)
        uiView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Some Title"
        uiView.addAnnotation(annotation)
        
        uiView.showsUserLocation = true
    }
}

struct vista1_Previews: PreviewProvider {
    static var previews: some View {
        vista1()
    }
}
