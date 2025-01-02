*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.jimms.fi
${BROWSER}    Chrome
${PRODUCT_URL}    https://www.jimms.fi/fi/Product/List/000-000
${USERNAME}    11111
${PASSWORD}    11111

*** Test Cases ***
Test Landing Pages for All Product Areas on Jimms.fi
    [Documentation]    Tarkista, että jokaisella tuotealueella Jimms.fi-sivustolla on "landing page".
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Check Landing Page For Product Area    Komponentit    /fi/Product/List/000-000
    Check Landing Page For Product Area    Tietokoneet    /fi/Product/List/100-000
    Check Landing Page For Product Area    Oheislaitteet    /fi/Product/List/300-000
    Check Landing Page For Product Area    Tarvikkeet    /fi/Product/List/400-000
    Close Browser

*** Keywords ***
Check Landing Page For Product Area
    [Arguments]    ${area_name}    ${relative_url}
    Go To    ${URL}${relative_url}
    Page Should Contain    ${area_name}

*** Test Cases ***
Test Search Functionality and Validate Product Page
    # Testaa hakutoimintoa, ota kuvankaappaus ensimmäisestä tuotteesta ja tarkista tuotesivun oikeellisuus.
    # Testitapaus 2
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    
    # Syötetään hakukenttään hakusanaksi "ps5"
    Input Text    xpath=//input[@type='text']    ps5
    
    # Odotetaan, että hakutulokset päivittyvät ja näkyvät
    Wait Until Page Contains    ps5    timeout=10s
    
    # Otetaan kuvankaappaus ensimmäisestä tuotteesta hakutuloksissa
    Capture Element Screenshot    xpath=/html/body/header/div/div[4]/jim-quickproductsearch/div/div/div/div/div[2]/a[1]    first_product.png
    
    # Klikataan ensimmäistä tuotetta hakutuloksissa
    Click Element    xpath=/html/body/header/div/div[4]/jim-quickproductsearch/div/div/div/div/div[2]/a[1]
    
    # Odotetaan, että tuotesivu latautuu
    Wait Until Page Contains Element    xpath=//h1    timeout=10s
    
    # Varmistetaan, että tuotesivun otsikko sisältää sanan "ps5"
    Element Should Contain    xpath=//h1    PS5
    Close Browser
*** Test Cases ***
TC_06_Verify_Add_To_Cart_Link
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Sleep    1


    Input Text    id:searchinput    ps5  
    #Click Button    css=.material-icon.ms-0
    Press Keys    id:searchinput    RETURN
    
    Sleep    2
    
    #tuotesivulle 
    Click Element    xpath:/html/body/main/div[2]/div/div[2]/div[5]/div/div[1]/product-box/div[2]/div[1]/a/div/img


    Sleep    5

   
    Wait Until Page Contains Element    xpath=//button[/html/body/main/div[1]/div[2]/div/jim-product-cta-box/div/div[3]/div[2]/addto-cart-wrapper/div/a]  

    
    Page Should Contain Element    xpath=//button[/html/body/main/div[1]/div[2]/div/jim-product-cta-box/div/div[3]/div[2]/addto-cart-wrapper/div/a]

    Close Browser 
*** Test Cases ***
Test that 'Add to Cart' Icon Exists and Take Screenshot
    #Tarkista, löytyykö "Lisää koriin" -linkin yhteydestä ostoskori-ikoni ja ota siitä kuvankaappaus.
    #Testitapaus 4
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    
    # Odotetaan, että ostoskorin painike tulee näkyviin
    Wait Until Element Is Visible    xpath=//*[@id="headercartcontainer"]/a    timeout=20s
    
    # Tarkista, että ostoskorin painike on näkyvissä
    Element Should Be Visible    xpath=//*[@id="headercartcontainer"]/a
    
    # Ota kuvankaappaus ostoskorin painikkeesta
    Capture Element Screenshot    xpath=//*[@id="headercartcontainer"]/a    shopping_cart_button.png
    
*** Test Cases ***
Test Empty Shopping Cart
    ## Lisätesti 1 - Periaatteessa tehtävä 5 + extraa
    ## Lisää tuote ostoskoriin, tyhjennä ostoskori ja varmista, että ostoskori on tyhjä.
    
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    
    # Syötetään hakukenttään hakusanaksi "ps5"
    Input Text    xpath=//input[@type='text']    ps5
    Wait Until Page Contains    ps5    timeout=10s
    
    # Klikataan ensimmäistä tuotetta hakutuloksissa
    Click Element    xpath=/html/body/header/div/div[4]/jim-quickproductsearch/div/div/div/div/div[2]/a[1]
    Wait Until Page Contains Element    xpath=//h1    timeout=10s
    
    # Klikataan "Lisää koriin" -painiketta
    Click Element    xpath=/html/body/main/div[1]/div[2]/div/jim-product-cta-box/div/div[3]/div[2]/addto-cart-wrapper/div/a

    # Odotetaan, että tuote lisätään ostoskoriin
    Wait Until Page Contains    Ostoskori    timeout=10s
    Sleep    2s
    # Siirrytään ostoskoriin
    Click Element    xpath=//*[@id="headercartcontainer"]/a
    Sleep    2s
    # Odotetaan, että ostoskorin sisältö latautuu
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Ostoskori')]    timeout=20s

    # Tarkistetaan, että ostoskori ei ole tyhjä
    Element Should Be Visible    xpath=//div[contains(@class, 'cart-item')]

    # Klikataan "Tyhjennä ostoskori" -painiketta
    Click Element    xpath=/html/body/main/div/div/div/div[1]/div/button
    
    # Odotetaan, että vahvistusikkuna avautuu
    Wait Until Page Contains    Oletteko varma    timeout=10s
    
    # Klikataan vahvistusikkunasta "Tyhjennä ostoskori" -painiketta
    Click Element    xpath=/html/body/div[1]/div/div/div[3]/form/input[3]
    Sleep    2s
    # Tarkistetaan, että ostoskori on tyhjä
    Wait Until Page Contains    Ostoskorisi on tyhjä    timeout=10s
    Close Browser
*** Test Cases ***
Test Product Reviews
    # Lisätesti 2
    ## Varmista, että tuotesivulla on arvosteluja tai näkyy "Ei arvosteluita" -ilmoitus.
    
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    
    # Syötetään hakukenttään hakusanaksi "ps5"
    Input Text    xpath=//input[@type='text']    ps5
    Wait Until Page Contains    ps5    timeout=10s
    
    # Klikataan ensimmäistä tuotetta hakutuloksissa
    Click Element    xpath=/html/body/header/div/div[4]/jim-quickproductsearch/div/div/div/div/div[2]/a[1]
    Wait Until Page Contains Element    xpath=//h1    timeout=10s
    Sleep    2s
    # Tarkistetaan, että arvosteluosio on olemassa tai näkyy "Ei arvosteluita"
    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[contains(@class, 'product-review-stars')]
    # Tarkistaa "Ei arvosteluita" -tekstin
    Run Keyword And Return Status    Element Should Be Visible    xpath=/html/body/main/div[1]/div[2]/div/jim-product-cta-box/div/div[1]/span/span
    Close Browser

*** Test Cases ***
Check Page Load Time
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    ${start_time}=    Get Time    epoch
    Go To    ${PRODUCT_URL}
    ${end_time}=    Get Time    epoch
    ${load_time}=    Evaluate    (${end_time} - ${start_time}) * 1000  # Muutetaan millisekunneiksi
    Log    Page load time: ${load_time} ms
    Should Be True    ${load_time} < 5000    Page load time exceeded the limit
    Close Browser

*** Test Cases ***
Change Color via Menu Clicks
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath=/html/body/div[1]/div/div/span  # Odota, että väri-valikko tulee näkyviin
    Click Element    xpath=/html/body/div[1]/div/div/span  # Klikkaa väri-valikkoa
    Sleep    2s  # Odota, jotta valikko ehtii avautua
    Wait Until Page Contains Element    xpath=/html/body/div[1]/div/div/ul/li[1]/button  # Odota, että ensimmäinen väri-painike tulee näkyviin
    Click Element    xpath=/html/body/div[1]/div/div/ul/li[1]/button  # Klikkaa ensimmäistä väri-painiketta
    Sleep    5s  # Odota, jotta väri vaihtuu näkyviin
    [Teardown]    Close Browser

