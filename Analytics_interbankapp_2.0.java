// Pedido 1: Remover Mobile Services (Limpieza de código)

// Modificar dependencias:

(-) implementation 'com.adobe.marketing.mobile:mobileservices:1.+'

// Modificar inicializaicón:

(-) import com.adobe.marketing.mobile.MobileServices;
...
public class IBKApplication extends MceApplication {
  ...
  @Override
  public void on Create(){
    super.onCreate();
    MobileCore.setLogLevel(LoggingMode.DEBUG); //??
    ...
    try {
      (-) MobileServices.registerExtension();
    }
  }
}

// Pedido 2: Actualizar Griffon/Assurance

// Modificar dependencias:

(-) implementation 'com.adobe.marketing.mobile:griffon:1.+'
(+) implementation 'com.adobe.marketing.mobile:assurance:1.+'

// Modificar inicializaicón:

(-) import com.adobe.marketing.mobile.Griffon;
(+) import com.adobe.marketing.mobile.Assurance;
...
public class IBKApplication extends MceApplication {
  ...
  @Override
  public void on Create(){
    super.onCreate();
    MobileCore.setLogLevel(LoggingMode.DEBUG); //??
    ...
    try {
      (+) Assurance.registerExtension();
      (-) Griffon.registerExtension();
    }
  }
}

// Pedido 3: Actualizar identity (sincronización de identidad)

// Modificar dependencias:

(+) implementation 'com.adobe.marketing.mobile:edgeidentity:1.+'

// Modificar inicializaicón:

(+) import com.adobe.marketing.mobile.AdobeCallback; //?????????????
(+) import com.adobe.marketing.mobile.edge.identity.Identity;
...
public class IBKApplication extends MceApplication {
  ...
  @Override
  public void on Create(){
    super.onCreate();
    MobileCore.setLogLevel(LoggingMode.DEBUG); //??
    ...
    try {
      (+) com.adobe.marketing.mobile.edge.identity.Identity.registerExtension();
      (+) com.adobe.marketing.mobile.Identity.registerExtension();
      (-) Identity.registerExtension();
    }
  }
}

// Modificar tag login:

Identity.syncIdentifier("digital_id",
                        digital_id,// Exmaple: 01-34234...234
                        VisitorID.AuthenticationState.AUTHENTICATED);

