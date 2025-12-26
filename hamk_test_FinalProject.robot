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

TC_UI_2 Verify Search 
    Go To    https://www.hamk.fi/en/
    Sleep    3s
    # Handle cookie banner if it appears
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${COOKIE_BTN}    timeout=8s
    Run Keyword And Ignore Error    Click Button    ${COOKIE_BTN}
    Sleep    2s

    # Click the Search icon
    Wait Until Element Is Visible    xpath:(//button[contains(@class,'search-toggle')])[1]    timeout=10s
    Scroll Element Into View         xpath:(//button[contains(@class,'search-toggle')])[1]
    Click Element                    xpath:(//button[contains(@class,'search-toggle')])[1]
    Sleep    5s    

    # Type "services" into the input field
    Wait Until Element Is Visible    xpath://input[contains(@class,'search-field') or @type='search']    timeout=10s
    Input Text                       xpath://input[contains(@class,'search-field') or @type='search']    services
    Press Keys                       xpath://input[contains(@class,'search-field') or @type='search']    ENTER
    Sleep    5s

     # Store the first search result link 
    Wait Until Element Is Visible    xpath:(//div[contains(@class,'search-results')]//a)[1]    timeout=20s
    ${first_result}=                 Get Text    xpath:(//div[contains(@class,'search-results')]//a)[1]
    Log    First search result is: ${first_result}

    # Click the first search result link
    Scroll Element Into View         xpath:(//div[contains(@class,'search-results')]//a)[1]
    Click Element                    xpath:(//div[contains(@class,'search-results')]//a)[1]
    Sleep    5s

    # Verify that the opened page contains something related to stored title
    Page Should Contain              ${first_result}

TC_UI_3 Capture First Article Image
    Go To    https://www.hamk.fi/en/cooperation-and-services/experts-at-your-service/
    Wait Until Element Is Visible     xpath:(//article//img)[1]    timeout=15s
    ${element}=    Get WebElement    xpath:(//article//img)[1]
    Capture Element Screenshot        ${element}    first_picture.png
    Log    first_picture.png

TC_UI_4 Verify Lecturer Search
    # Navigate to Contact page
    Navigate To About us Page

    # Click Search experts
    Wait Until Element Is Visible    xpath://a[contains(translate(.,'SEARCH EXPERTS','search experts'),'search experts')]    timeout=10s
    Scroll Element Into View         xpath://a[contains(translate(.,'SEARCH EXPERTS','search experts'),'search experts')]
    Click Element                    xpath://a[contains(translate(.,'SEARCH EXPERTS','search experts'),'search experts')]
    Sleep    3s

    # Scroll to search box
    Execute JavaScript    window.scrollTo(0, 570)
    Sleep    2s

    # Fill lecturer name in search box
    Input Text                       xpath://input[@placeholder='Write here']    ${TEACHER_NAME}
    Sleep    5s

    # Click "More information" on the first result
    Wait Until Element Is Visible    xpath:(//a[contains(translate(.,'MORE INFORMATION','more information'),'more information')])[1]    timeout=15s
    Scroll Element Into View         xpath:(//a[contains(translate(.,'MORE INFORMATION','more information'),'more information')])[1]
    Click Element                    xpath:(//a[contains(translate(.,'MORE INFORMATION','more information'),'more information')])[1]
    Sleep    5s

    # Verify lecturer page contains lecturer name
    Page Should Contain              ${TEACHER_NAME}

TC_UI_5 Verify Lecturer Name In Header
    #Navigate to Search People Page
    Go To    https://www.hamk.fi/en/about-hamk/contact-us/people/
    Sleep    3s

    # Scroll to search box 
    Execute JavaScript    window.scrollTo(0, 570)
    Sleep    2s

    # Fill lecturer name in search box
    Input Text                       xpath://input[@placeholder='Write here']    ${TEACHER_NAME}
    Sleep    5s

    # Click "More information" on the first result
    Wait Until Element Is Visible    xpath:(//a[contains(translate(.,'MORE INFORMATION','more information'),'more information')])[1]    timeout=15s
    Scroll Element Into View         xpath:(//a[contains(translate(.,'MORE INFORMATION','more information'),'more information')])[1]
    Click Element                    xpath:(//a[contains(translate(.,'MORE INFORMATION','more information'),'more information')])[1]
    Sleep    5s

    # people page contains lecturer name
    Page Should Contain              ${TEACHER_NAME}

    # header contains lecturer name)
    Wait Until Page Contains    ${TEACHER_NAME}    timeout=15s

    ${header_text}=    Get Text    xpath://h1

    Log To Console     Header text: ${header_text}

    # Verify the heading contains lecturer name
    Should Contain     ${header_text}    ${TEACHER_NAME}

TC_UI_6 Verify Language Switch Works
    # Switching site language from English to Finnish.
    Go To    ${URL}
    Sleep    5s
    Wait Until Element Is Visible    xpath://a[contains(@lang,'fi')]    timeout=15s
    Click Element                    xpath://a[contains(@lang,'fi')]
    Sleep    4s
    # "Koulutus" = Education in Finnish for verifying page switched into Finnish
    Page Should Contain              Koulutus

TC_UI_7 Open New Student Instructions
    #Navigating to "New Student Instructions" and clicking "Start Your Studies Here"
    Go To    ${URL}
    Sleep    4s
    Wait Until Element Is Visible    xpath://a[contains(text(),'New student instructions')]    timeout=15s
    Scroll Element Into View         xpath://a[contains(text(),'New student instructions')]
    Click Element                    xpath://a[contains(text(),'New student instructions')]
    Sleep    4s
    Wait Until Page Contains         Start your studies here    timeout=15s
    Click Element                    xpath://a[contains(text(),'Start your studies here')]
    Sleep    5s
    Page Should Contain              studies

TC_UI_8 Explore Study Options - Computer Applications
    #Navigation from homepage to Search Study Options then to Computer Applications and scrolls through the page
    Go To    ${URL}
    Sleep    5s

    # Step 1: Click "Search study options"
    Wait Until Element Is Visible    xpath://a[contains(text(),'Search study options')]    timeout=25s
    Scroll Element Into View         xpath://a[contains(text(),'Search study options')]
    Click Element                    xpath://a[contains(text(),'Search study options')]
    Sleep    10s

    # Step 2: Scroll down to find the programme list
    Execute JavaScript    window.scrollBy(0, 1000)
    Sleep    3s
    Execute JavaScript    window.scrollBy(0, 1200)
    Sleep    3s

    # Step 3: Click "Computer Applications" directly
    Wait Until Element Is Visible    xpath://a[contains(.,'Computer Applications')]    timeout=25s
    Scroll Element Into View         xpath://a[contains(.,'Computer Applications')]
    Click Element                    xpath://a[contains(.,'Computer Applications')]
    Sleep    6s

    # Step 4: scroll through programme page for finding computer applications
    Execute JavaScript    window.scrollBy(0, 500)
    Sleep    2s
    Execute JavaScript    window.scrollBy(0, 800)
    Sleep    2s
    Execute JavaScript    window.scrollBy(0, 1200)
    Sleep    3s
    Page Should Contain              Computer Applications


TC_UI_9 Find Scholarship Finnish Skills Requirements

    Go To    ${URL}
    Sleep    3s
    Run Keyword And Ignore Error    Click Button    ${COOKIE_BTN}
    Sleep    2s

    # Step 1: Click "Come to study" button 
    Wait Until Element Is Visible    xpath://button[contains(translate(.,'COME TO STUDY','come to study'),'come to study')]    timeout=15s
    Click Element                    xpath://button[contains(translate(.,'COME TO STUDY','come to study'),'come to study')]
    Sleep    3s

    # Step 2: Click "Scholarships and tuition fees" 
    Wait Until Element Is Visible    xpath://a[contains(translate(.,'TUITION FEES AND SCHOLARSHIPS','tuition fees and scholarships'),'tuition fees and scholarships')]    timeout=15s
    Click Element                    xpath://a[contains(translate(.,'TUITION FEES AND SCHOLARSHIPS','tuition fees and scholarships'),'tuition fees and scholarships')]
    Sleep    3s

    # Step 3: Scroll to Scholarship section 
    Execute JavaScript    window.scrollBy(0, 2600)
    Sleep    2s
    Wait Until Element Is Visible    xpath://button[contains(translate(.,'SCHOLARSHIP BASED FOR THE FINNISH SKILLS: BACHELOR STUDENTS','scholarship based for the finnish skills: bachelor students'),'scholarship based for the finnish skills: bachelor students')]    timeout=20s
    Scroll Element Into View         xpath://button[contains(translate(.,'SCHOLARSHIP BASED FOR THE FINNISH SKILLS: BACHELOR STUDENTS','scholarship based for the finnish skills: bachelor students'),'scholarship based for the finnish skills: bachelor students')]
    Click Element                    xpath://button[contains(translate(.,'SCHOLARSHIP BASED FOR THE FINNISH SKILLS: BACHELOR STUDENTS','scholarship based for the finnish skills: bachelor students'),'scholarship based for the finnish skills: bachelor students')]
    Sleep    4s

TC_UI_10 Run a video
    Go To    ${URL}
    Sleep    3s
    Run Keyword And Ignore Error    Click Button    ${COOKIE_BTN}
    Sleep    2s

    # Step 1: Click main "Research" navigation button
    Wait Until Element Is Visible    xpath://button[contains(translate(.,'Research','research'),'research')]    timeout=10s
    Scroll Element Into View         xpath://button[contains(translate(.,'Research','research'),'research')]
    Click Element                    xpath://button[contains(translate(.,'Research','research'),'research')]
    Sleep    2s

    # Step 2: Click the "Research" button
    Wait Until Element Is Visible    xpath://a[contains(translate(.,'Research','research'),'research') and contains(@href,'research')]    timeout=10s
    Scroll Element Into View         xpath://a[contains(translate(.,'Research','research'),'research') and contains(@href,'research')]
    Click Element                    xpath://a[contains(translate(.,'Research','research'),'research') and contains(@href,'research')]
    Sleep    3s

    # Step 3: Scroll down the Research page to find video
    Execute JavaScript    window.scrollBy(0, 800)
    Sleep    2s
    Execute JavaScript    window.scrollBy(0, 400)
    Sleep    2s

    # Step 4: Try finding for first YouTube embedded video
    Wait Until Element Is Visible    xpath://iframe[contains(@src,'youtube') or contains(@src,'youtu.be')]    timeout=15s
    Scroll Element Into View         xpath://iframe[contains(@src,'youtube') or contains(@src,'youtu.be')]
    Sleep    3s
   
    # Click on the YouTube video to play it
    Click Element                    xpath://iframe[contains(@src,'youtube') or contains(@src,'youtu.be')]
    Sleep    5s
    Log    YouTube video should now be playing.
