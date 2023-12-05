*** Settings ***
Library  SeleniumLibrary
Library  ./AppLibrary.py

*** Variables ***
${SERVER}  localhost:5173
${DELAY}  0.1 seconds
${HOME_URL}  http://${SERVER}/index.html


*** Keywords ***
Open And Configure Browser
    ${options}  Evaluate  sys.modules['selenium.webdriver'].FirefoxOptions()  sys
    #Kommentoi alempi rivi niin testit näkyvät ruudulla 
    Call Method  ${options}  add_argument  --headless
    Open Browser  browser=firefox  options=${options}
    Set Selenium Speed  ${DELAY}



Main Page Should Be Open
    Title Should Be  Vite + React


Go To Main Page
    Go To  ${HOME_URL}



Set Title
    [Arguments]  ${title}
    Input Text  title  ${title}

Set Author
    [Arguments]  ${author}
    Input Text  author  ${author}

Set Number
    [Arguments]  ${number}
    Input Text  number  ${number}

Set Pages
    [Arguments]  ${pages}
    Input Text  pages  ${pages}

Set Journal
    [Arguments]  ${journal}
    Input Text  journal  ${journal}

Set Year
    [Arguments]  ${year}
    Input Text  year  ${year}

Set Publisher
    [Arguments]  ${year}
    Input Text  publisher  ${year}

Set Adress
    [Arguments]  ${year}
    Input Text  adress  ${year}

Set Howpublished
    [Arguments]  ${year}
    Input Text  howpubluihsed  ${year}

Set Month
    [Arguments]  ${year}
    Input Text  Month  ${year}

Set School
    [Arguments]  ${school}
    Input Text  School  ${school}

Set Citekey
    [Arguments]  ${citekey}
    Input Text  citekey  ${citekey}

Set Year Filter
    [Arguments]  ${min}  ${max}
    Input Text  small_year  ${min}
    Input Text  large_year  ${max}

Set Title Filter
    [Arguments]  ${title}
    Click Element  filter-select-button-1
    Sleep  1
    Click Element  title-filter
    Input Text  filter_word  ${title}
    Click Element  add_filter

Set Author Filter
    [Arguments]  ${author}
    Click Element  filter-select-button-1
    Sleep  1
    Click Element  auth-filter
    Input Text  filter_word  ${author}
    Click Element  add_filter

Set All Filter
    [Arguments]  ${author}
    Click Element  filter-select-button-1
    Sleep  1
    Click Element  all-filter
    Input Text  filter_word  ${author}
    Click Element  add_filter

Clear Filtering
    Click Element  reset_button

Submit Reference
    Click Button  Submit Reference


Select Article
    Wait Until Element Is Visible    name:type
    Select From List By Value       name:type     article

Select Book
    Wait Until Element Is Visible    name:type
    Select From List By Value       name:type     Book

Select Booklet
    Wait Until Element Is Visible    name:type
    Select From List By Value       name:type     Booklet

Select MasterThesis
    Wait Until Element Is Visible    name:type
    Select From List By Value       name:type     MasterThesis

Add Premade Article
    Select Article
    Set Citekey  22
    Set Title  Book of rhymes 2
    Set Author  Eminem
    Set Journal  Jonne
    Set Year  70
    #Set Number  3
    #Set Pages  1-99
    Submit Reference

Add Another Premade Article
    Select Article
    Set Citekey  23
    Set Title  Book of rhymes 3
    Set Author  Eminem
    Set Journal  Jonne
    Set Year  71
    #Set Number  3
    #Set Pages  1-99
    Submit Reference



Empty The table
#when delete is fixed to update instantly change for loop to use 1 instead of row num
    Wait Until Element Is Visible    id:entrylist
    ${rows}=    Get Element Count    //table[@id="entrylist"]/tbody/tr
    FOR    ${row_num}    IN RANGE    1    ${rows+1}
        ${button}=    Get WebElement   //table[@id="entrylist"]/tbody/tr[1]/th[5]/button  
        Click Element  ${button}
    END
    Sleep  1
    Go To Main Page

Delete One Row
    Wait Until Element Is Visible    id:entrylist
    ${button}=    Get WebElement   //table[@id="entrylist"]/tbody/tr[1]/th[5]/button  
    Click Element  ${button}

    
Check Table Row
    [Arguments]  ${selected_row}  ${expected_value}
    @{cells}=    Get WebElements    //table[@id="entrylist"]/tbody/tr[${selected_row}]
    ${data}=    Create List
    FOR    ${cell}    IN    @{cells}
        Sleep    1s
        Wait Until Element Is Visible    ${cell}
        ${text}=    Get Element Attribute    ${cell}    innerText
        ${data}=    Evaluate    [cell.text for cell in $cells]
        Log    ${cell} contains text: ${text}
    END
    Log    row ${selected_row} data: ${data}
    Should Be Equal As Strings  ${data}   ${expected_value}

Row Count Should Be
    [Arguments]  ${expected_value}
    ${rows}=    Get Element Count    //table[@id="entrylist"]/tbody/tr
    Should Be Equal As Strings  ${rows}   ${expected_value}

Table Should Be Empty
    Row Count Should Be  0

Add Article By Values
    [Arguments]  ${citekey}  ${title}  ${author}  ${year}  ${journal}
    Select Article
    Set Citekey  ${citekey}
    Set Title  ${title}
    Set Author  ${author}
    Set Year  ${year}
    Set Journal  ${journal}
    Set Year  ${year}
    Submit Reference

Mass Add Articles
    Add Article By Values  AP_news1  No. 8 Alabama knocks off No. 1 Georgia 27-24 for SEC title. Both teams await postseason fate  PAUL NEWBERRY  2023  Associated Press

    Add Article By Values  source_me  apples are not real  meikä  2023   imagination  

    Add Article By Values  AP_news2  No. 5 Texas Upsets No. 2 Oklahoma 35-31 in Big 12 Championship. Playoff picture unfolds.  JESSICA ANDERSON  2021  Associated Press

    Add Article By Values  AP_news3  Tom Brady Leads Tampa Bay Buccaneers to Super Bowl Victory. Historic win for the Buccaneers.  MICHELLE WILLIAMS  2022  Associated Press

    Add Article By Values  AP_news4  Serena Williams Makes a Triumphant Return to Tennis with Grand Slam Victory. Fans celebrate her comeback.  RYAN CARTER  2021  Associated Press

    Add Article By Values  AP_news5  Breakthrough in Medical Research: Promising Treatment for Common Cold Discovered. Potential global impact.  EMMA MARTIN  2020  Associated Press

    Add Article By Values  AP_news6  NASA Announces Successful Launch of Next-Generation Space Telescope. Astronomers eager for new discoveries.  JASON ADAMS  2023  Associated Press

Filter By Year
    [Arguments]  ${minvalue}  ${maxvalue}
    Set Year Filter  ${minvalue}  ${maxvalue}

Filter By Title
    [Arguments]  ${value}
    Set Title Filter  ${value}

Filter By Author
    [Arguments]  ${value}
    Set Author Filter  ${value}