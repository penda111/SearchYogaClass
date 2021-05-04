*** Settings ***
Documentation     Given there are serveral classes existed.
...               *Class List*
...               * Date \ \ \ \Name \ \ \ \Level \ \ \ \ \Medium*
...               1. 0205 \ \ \ David \ \ \ Beginner \ \ \ English
...               2. 0305 \ \ \ David \ \ \ Intermediate \ English
...               3. 0205 \ \ \ May \ \ \ \ Beginner \ \ \ Cantonese
...               4. 0305 \ \ \ May \ \ \ \ Intermediate \ Cantonese
...               5. 0405 \ \ \ Amy \ \ \ \ Advanced \ \ \ Mandarin
...               6. 0405 \ \ \ Amy \ \ \ \ Intermediate \ Cantonese
...               7. 0405 \ \ \ Eric \ \ \ \ Beginner \ \ \Cantonese
...               8. 0405 \ \ \ Eric \ \ \ \ Advanced \ \ \Cantonese
Test Template     The search result of ${DATERANGE} ${NAME} ${LEVEL} ${MEDIUM} should be

*** Test Cases ***    DATERANGE       NAME        LEVEL       MEDIUM
date range            ${DATERANGE}    ${EMPTY}    ${EMPTY}    ${EMPTY}

name                  ${EMPTY}        ${NAME}     ${EMPTY}    ${EMPTY}

level                 ${EMPTY}        ${EMPTY}    ${LEVEL}    ${EMPTY}

medium                ${EMPTY}        ${EMPTY}    ${EMPTY}    ${MEDIUM}

date range and name
                      ${DATERANGE}    ${NAME}     ${EMPTY}    ${EMPTY}

date range and level
                      ${DATERANGE}    ${EMPTY}    ${LEVEL}    ${EMPTY}

date range and medium
                      ${DATERANGE}    ${EMPTY}    ${EMPTY}    ${MEDIUM}

name and level        ${EMPTY}        ${NAME}     ${LEVEL}    ${EMPTY}

name and medium       ${EMPTY}        ${NAME}     ${EMPTY}    ${MEDIUM}

level and medium      ${EMPTY}        ${EMPTY}    ${LEVEL}    ${MEDIUM}

date range, name, and level
                      ${DATERANGE}    ${NAME}     ${LEVEL}    ${EMPTY}

date range, level, and medium
                      ${DATERANGE}    ${EMPTY}    ${LEVEL}    ${MEDIUM}

name, level, and medium
                      ${EMPTY}        ${NAME}     ${LEVEL}    ${MEDIUM}

date range, name, level, and medium
                      ${DATERANGE}    ${NAME}     ${LEVEL}    ${MEDIUM}

*** Keywords ***
Search the existed classes by date range, name of teacher, level of difficulty, and medium of instruction
    [Arguments]    ${DateRange=0205}    ${Name=David}    ${Level=Beginner}    ${Medium=English}
    Given the classes of specific ${DateRange} ${Name}    ${Level}    ${Medium} are existed
    When user selects ${DateRange} ${Level}    ${Medium} and input    ${Name}
    And clicks search
    Then result of class No.1 should be returned and shown

Search the non-existed classes by date range, name of teacher, level of difficulty, and medium of instruction
    [Arguments]    ${DateRange=0205}    ${Name=David}    ${Level=Advanced}    ${Medium=English}
    Given the classes of specfic ${DateRange}    ${Name}    ${Level}    ${Medium} are not existed
    When user selects ${DateRange} ${Level} ${Medium} and input ${Name}
    And clicks search
    Then no class results are returned and showed
    And No result found message should be shown

Search by DateRange with classes
    [Arguments]    ${DateRange=0205}
    Given the classes of specfic ${DateRange} are exists
    When user selects ${DateRange}
    And clicks search
    Then result of class No.1, No.3 should be returned and shown

Search by DateRange with no classes
    [Arguments]    ${DateRange=0505}
    Given the classes of specfic ${DateRange} are not exists
    When user selects ${DateRange}
    And clicks search
    Then no class results are returned and showed
    And No result found message should be shown

Search by exist teacher name
    [Arguments]    ${Name=Amy}
    Given the classes of specfic ${Name} are existed
    When user input ${Name}
    And clicks search
    Then result of class No.5 and No.6 should be returned and shown

Search by non-exist teacher name
    [Arguments]    ${Name=Ben}
    Given the classes of specfic ${Name} are not existed
    When user input ${Name}
    And clicks search
    Then no class results are returned and showed
    And No result found message should be shown

Search by level of difficulty
    [Arguments]    ${Level=Intermeidate}
    Given the classes of specfic ${Level} are existed
    When user selects ${Level}
    And clicks search
    Then result of class No.2, No.4, and No.6 should be returned and shown

Search by medium of instruction
    [Arguments]    ${Medium=Cantonese}
    Given the classes of specfic ${Medium} are existed
    When user selects ${Medium}
    And clicks search
    Then result of class No.3, No.4, No.6, No.7, and No.8 should be returned and shown
