#Group Member: 
#Muntasir Islam
#Md Maruf


*** Settings ***
Library           SeleniumLibrary
Suite Setup       Setup Browser
Suite Teardown    Close Browser
Test Teardown     Sleep    2s

*** Variables ***
${URL}            https://www.hamk.fi/en/
${BROWSER}        chrome
${TEACHER_NAME}   Esa Huiskonen
${COOKIE_BTN}     xpath://button[contains(.,'Allow all cookies')]

*** Keywords ***
Setup Browser
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Handle Cookies
    Wait Until Page Contains Element    xpath://header

Handle Cookies
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${COOKIE_BTN}    timeout=10s
    Run Keyword And Ignore Error    Click Button    ${COOKIE_BTN}
    Sleep    1s

Navigate To About us Page
    # Navigate to About Us Page
    Wait Until Element Is Visible    xpath://button[contains(translate(.,'ABOUT US','about us'),'about us')]    timeout=8s
    Click Element                    xpath://button[contains(translate(.,'ABOUT US','about us'),'about us')]
    Sleep    3s
    # Wait for dropdown to appear and click Contact us
    Wait Until Element Is Visible    xpath://a[contains(translate(.,'CONTACT US','contact us'),'contact us')]    timeout=10s
    Scroll Element Into View         xpath://a[contains(translate(.,'CONTACT US','contact us'),'contact us')]
    Click Element                    xpath://a[contains(translate(.,'CONTACT US','contact us'),'contact us')]
    Sleep    3s

Scroll To Bottom
    #Smoothly scrolls down the page.
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    3s

*** Test Cases ***
TC_UI_1 Verify Latest News Articles

    Go To    https://www.hamk.fi/en/
    Sleep    3s

    # Handle cookie banner if it appears
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${COOKIE_BTN}    timeout=10s
    Run Keyword And Ignore Error    Click Button    ${COOKIE_BTN}
    Sleep    1s

    # Scroll down until Latest News section is visible  
    Execute JavaScript    window.scrollTo(0, 650)
    Sleep    2s

    # Wait for Latest news heading to appear
    Wait Until Page Contains    Latest news    timeout=10s

    # Scroll again to ensure news items are loaded
    Scroll Element Into View     xpath://h2[contains(translate(.,'LATEST','latest'),'latest news')]
    Sleep    3s

    # Click Info category
    Wait Until Element Is Visible    xpath://button[contains(translate(.,'INFO','info'),'info')]    timeout=15s
    Click Element                    xpath://button[contains(translate(.,'INFO','info'),'info')]
    Sleep    5s

    Wait Until Element Is Visible    xpath:(//a[contains(@class,'news-card__link')])[1]    timeout=15s
    Scroll Element Into View         xpath:(//a[contains(@class,'news-card__link')])[1]
    Click Element                    xpath:(//a[contains(@class,'news-card__link')])[1]
    Page Should Contain              Info
    Sleep    3s
    Go Back

    # Click News category
    Wait Until Element Is Visible    xpath://button[contains(translate(.,'NEWS','news'),'news')]    timeout=15s
    Click Element                    xpath://button[contains(translate(.,'NEWS','news'),'news')]
    Sleep    5s

    Wait Until Element Is Visible    xpath:(//a[contains(@class,'news-card__link')])[1]    timeout=15s
    Scroll Element Into View         xpath:(//a[contains(@class,'news-card__link')])[1]
    Click Element                    xpath:(//a[contains(@class,'news-card__link')])[1]
    Page Should Contain              News
    Sleep    3s
    Go Back


    # Click Press Releases category
    Wait Until Element Is Visible    xpath://button[contains(translate(.,'PRESS','press'),'press')]    timeout=15s
    Click Element                    xpath://button[contains(translate(.,'PRESS','press'),'press')]
    Sleep    5s

    Wait Until Element Is Visible    xpath:(//a[contains(@class,'news-card__link')])[1]    timeout=15s
    Scroll Element Into View         xpath:(//a[contains(@class,'news-card__link')])[1]
    Click Element                    xpath:(//a[contains(@class,'news-card__link')])[1]
    Page Should Contain              Press releases
    Sleep    3s
    Go Back

    # Click Stories category
    Wait Until Element Is Visible    xpath://button[contains(translate(.,'STORIES','stories'),'stories')]    timeout=15s
    Click Element                    xpath://button[contains(translate(.,'STORIES','stories'),'stories')]
    Sleep    5s

    Wait Until Element Is Visible    xpath:(//a[contains(@class,'news-card__link')])[1]    timeout=15s
    Scroll Element Into View         xpath:(//a[contains(@class,'news-card__link')])[1]
    Click Element                    xpath:(//a[contains(@class,'news-card__link')])[1]
    Page Should Contain              Stories
    Sleep    3s
    Go Back

    # click Student Voice category
    Wait Until Element Is Visible    xpath://button[contains(translate(.,'VOICE','voice'),'voice')]    timeout=15s
    Click Element                    xpath://button[contains(translate(.,'VOICE','voice'),'voice')]
    Sleep    5s

    Wait Until Element Is Visible    xpath:(//a[contains(@class,'news-card__link')])[1]    timeout=15s
    Scroll Element Into View         xpath:(//a[contains(@class,'news-card__link')])[1]
    Click Element                    xpath:(//a[contains(@class,'news-card__link')])[1]
    Page Should Contain              Student voice
    Sleep    3s
    Go Back