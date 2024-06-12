// Coddoc

iif(
    matches_regex(
        trim(
            upper(
                iif(
                    contains_key("xdm._interbank.user\.identities\.digitalid")
                    ,${xdm._interbank.user\.identities\.digitalid}
                    ,${xdm._interbank.app\.user\.digitalid}
                )                    
            )
        ),"^([0])([0-9])([-])([A-Fa-f0-9]{64}$)"
    )
    ,upper(
        substr(
            trim(
                iif(
                    contains_key("xdm._interbank.user\.identities\.digitalid")
                    ,${xdm._interbank.user\.identities\.digitalid}
                    ,${xdm._interbank.app\.user\.digitalid}
                ) 
            )
            ,3
            ,64
        )
    )
    ,nullify
)

// Codunicocli

iif(
    matches_regex(
        iif(
            contains_key("xdm._interbank.user\.identities\.codunicocli")
            ,${xdm._interbank.user\.identities\.codunicocli}
            ,${xdm._interbank.app\.user\.customerid}
        )        
        ,"^[0-9]{10}$"
    )
    ,iif(
        contains_key("xdm._interbank.user\.identities\.codunicocli")
        ,${xdm._interbank.user\.identities\.codunicocli}
        ,${xdm._interbank.app\.user\.customerid}
    )
    ,nullify
)

// Logged Event

iif(
    ${xdm._interbank.user\.islogged} == "true" || ${xdm._interbank.user\.islogged} == true || ${xdm._interbank.app\.session\.status}=="LoggedIn"
    ,"S"
    ,iif(
        ${xdm._interbank.user\.islogged} == "false" || ${xdm._interbank.user\.islogged} == false
        ,"N"
        ,"SV"
    )
)

// Event Type

iif(
    ${xdm.eventType} == "buttonclick"
    ,"web.webinteraction.linkClicks"
    ,iif(${xdm.eventType} == "pageload"
        ,"web.webpagedetails.pageViews"
        ,${xdm.eventType}
    )
)

// Application  Version

iif(
    ${xdm.application.version} == null
    ,"SV"
    ,${xdm.application.version}
)

// OS Version

iif(
    ${xdm.environment.browserDetails.userAgent} == null
    ,"SV"
    ,ua_os_version(${xdm.environment.browserDetails.userAgent})
)

// Device Type

iif(
    ${xdm.environment.browserDetails.userAgent} == null
    ,"SV"
    ,ua_device_class(${xdm.environment.browserDetails.userAgent})
)

// Application Name

iif(
    ${xdm._interbank.event\.application} == null
    ,"Interbank App: Mobile SDK"
    ,${xdm._interbank.event\.application}
)

// Product Purchase Begin

iif(
    ${xdm._interbank.event\.buyflow\.ispurchasebegin} == "true" || ${xdm._interbank.event\.buyflow\.ispurchasebegin} == true || ${xdm._interbank.event\.code} == "product.begin"
    ,"S"
    ,"N"
)

// Product Purchase

iif(
    ${xdm._interbank.event\.buyflow\.ispurchase} == "true" || ${xdm._interbank.event\.buyflow\.ispurchase} == true || ${xdm._interbank.event\.code} == "product.purchase"
    ,"S"
    ,"N"
)

// Product Offer

iif(
    ${xdm._interbank.event\.buyflow\.isoffer} == "true" || ${xdm._interbank.event\.buyflow\.isoffer} == true || ${xdm._interbank.event\.code} == "product.offer"
    ,"S"
    ,"N"
)

// Product View

iif(
    ${xdm._interbank.event\.buyflow\.isview} == "true" || ${xdm._interbank.event\.buyflow\.isview} == true || ${xdm._interbank.event\.code} == "product.view"
    ,"S"
    ,"N"
)

//Product List

iif(
    ${xdm._interbank.event\.products\.list} == null
    ,"SV"
    ,${xdm._interbank.event\.products\.list}
)

//Product Name

iif(
    ${xdm._interbank.app\.account\.name} == null
    ,"SV"
    ,${xdm._interbank.app\.account\.name}
)

//Product Type

iif(
    ${xdm._interbank.app\.account\.type} == null
    ,"SV"
    ,${xdm._interbank.app\.account\.type}
)

//Parameters

"SV"

//Reference Code

iif(
    ${xdm._interbank.event\.referencecode} == null
    ,"SV"
    ,${xdm._interbank.event\.referencecode}
)

//Entry Code

iif(
    contains_key("xdm._interbank.event\.entrycode")
    ,${xdm._interbank.event\.entrycode}
    ,iif(
        contains_key("xdm._interbank.app\.campaign\.internal")
        ,${xdm._interbank.app\.campaign\.internal}
        ,"SV"
    )    
)

//Domain

iif(
    ${xdm.application.id} == null
    ,"SV"
    ,${xdm.application.id}
)

//Visit Type

"SV"

//Authentication Factor

iif(
    contains_key("xdm._interbank.event\.authenticationfactor")
    ,${xdm._interbank.event\.authenticationfactor}
    ,iif(
        contains_key("xdm._interbank.app\.login\.mode")
        ,${xdm._interbank.app\.login\.mode}
        ,"SV"
    )    
)

//subsection

iif(
    contains_key("xdm._interbank.event\.subsection")
    ,${xdm._interbank.event\.subsection}
    ,iif(
        contains_key("xdm._interbank.app\.screen\.subcategory")
        ,${xdm._interbank.app\.screen\.subcategory}
        ,"SV"
    )    
)

//Section

iif(
    contains_key("xdm._interbank.event\.section")
    ,${xdm._interbank.event\.section}
    ,iif(
        contains_key("xdm._interbank.app\.screen\.category")
        ,${xdm._interbank.app\.screen\.category}
        ,"SV"
    )    
)

//Event Name

iif(
    contains_key("xdm._interbank.event\.name")    
    ,${xdm._interbank.event\.name}
    ,"SV"
)

//Event Code

iif(
    contains_key("xdm._interbank.event\.code")
    ,${xdm._interbank.event\.code}
    ,iif(
        contains_key("xdm._interbank.app\.action\.name")
        ,${xdm._interbank.app\.action\.name}
        ,iif(
            contains_key("xdm._interbank.app\.funnel\.step")
            ,${xdm._interbank.app\.funnel\.step}
            ,"SV"
        )    
    )   
)

//OS

iif(
    ${xdm.environment.browserDetails.userAgent} == null
    ,"SV"
    ,ua_os_name(${xdm.environment.browserDetails.userAgent})
)

//Login Event

iif(
    ${xdm._interbank.app\.action\.name} =="action.access.login" || ${xdm._interbank.event\.code} == "login.success"
    ,"S"
    ,"N"
)

//Login Remind Data Flag

iif(
    ${xdm._interbank.app\.login\.option} == "RecordarDatos:activado" || ${xdm._interbank.event\.login\.isdatareminded} == true || ${xdm._interbank.event\.login\.isdatareminded} == "true"
    ,"S"
    ,"N"
)

//Timestamp

xdm.timestamp

//ID

xdm._id

//Tipdoc

substr(
    trim(
        iif(
            contains_key("xdm._interbank.user\.identities\.digitalid")
            ,${xdm._interbank.user\.identities\.digitalid}
            ,${xdm._interbank.app\.user\.digitalid}
        )
    )
    ,1
    ,1
)

//Ecid

xdm.identityMap.ECID[0].id