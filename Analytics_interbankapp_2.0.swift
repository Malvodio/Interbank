// Pedido 1: Remover Mobile Services (Limpieza de código)

// Modificar dependencias:

(-) pod 'ACPMobileServices', '1.1.1'

// Modificar inicialización:

(-) import ACPMobileServices
...
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool{
        MobileCore.setLogLevel(.debug)
        let appState = application.applicationState
        ...
        let extensions = [
        (+) AEPEdgeIdentity.Identity.self,
        (+) AEPIdentity.Identity.self,
        ] 
        MobileCore.registerExtensions(extensions, {
            MobileCore.configureWith(appId: *Insertar aquí Key/ID del ambiente*) //  Ejemplo: MobileCore.configureWith(appId: "df637a308f4c/a155ef8dfddd/launch-d41f0f650c6a")
            if appState != .background {
                MobileCore.lifecycleStart(additionalContextData: ["contextDataKey": "contextDataVal"])
            }
        })
        ...
        return true
    }
}

// Pedido 2: Actualizar Griffon/Assurance

// Modificar dependencias:

(-) pod 'ACPGriffon', '1.2.1'
(+) pod 'AEPAssurance', '~> 3.0'

// Modificar dependencias y llamado de librerías: 

(-) pod 'ACPAnalytics', '2.5.3'
(+) pod 'AEPAnalytics', '~> 3.0'

// Modificar inicialización:

...

// Pedido 3: Actualizar identity (sincronización de identidad)

// Modificar dependencias:

(+) pod 'AEPEdgeIdentity', '~> 1.0'
(+) pod 'AEPIdentity', '~> 3.0'

// Modificar inicialización:

...

// Pedido 4: Actualizar otras librerias

// Modificar dependencias:

(+) use_frameworks!


(-) pod 'ACPUserProfile', '2.2.0'
(-) pod 'ACPCore', '2.9.5'
(+) pod 'AEPUserProfile', '~> 3.0'
(+) pod 'AEPCore', '~> 3.0'
(+) pod 'AEPSignal', '~>3.0'
(+) pod 'AEPLifecycle', '~>3.0'

// Modificar inicialización:

...

