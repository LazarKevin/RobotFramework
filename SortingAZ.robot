*** Settings ***
Library    Selenium2Library
Library   Collections
Library    String
Resource   loginKeywords.robot


*** Test Cases ***
Sort products from Z to A
    Login with standard user
    Click Element    class:product_sort_container
    Click Element    //*[@id="header_container"]/div[2]/div/span/select/option[2]
    ${product_names}=    Get all products
    Verify Z to A sorting    ${product_names}
    Sleep    2s
    Close Browser

Sort products from A to Z
    Login with standard user
    Click Element    class:product_sort_container
    Click Element    //*[@id="header_container"]/div[2]/div/span/select/option[1]
    ${product_names}=    Get all products
    Verify A to Z sorting    ${product_names}
    Sleep    2s
    Close Browser


Sort products from low to high price
    Login with standard user
    Click Element    class:product_sort_container
    Click Element    //*[@id="header_container"]/div[2]/div/span/select/option[3]
    ${product_prices}=    Get all products prices
    Verify low to high prices    ${product_prices}
    Sleep    2s
    Close Browser

Sort products from high to low price
    Login with standard user
    Click Element    class:product_sort_container
    Click Element    //*[@id="header_container"]/div[2]/div/span/select/option[4]
    ${product_prices}=    Get all products prices
    Verify high to low prices    ${product_prices}
    Sleep    2s
    Close Browser


*** Keywords ***
Get all products
    @{products} =    Create List
    @{products_name}=    Get WebElements    class:inventory_item_name
    FOR    ${item}    IN    @{products_name}
        ${name}=    Get Text    ${item}
        Append To List    ${products}    ${name} 
    END
    RETURN    @{products}


    
Verify Z to A sorting
    [Arguments]    ${product_names} 
    ${lenght}=    Get Length    ${product_names}
    FOR    ${index}    IN RANGE    0    ${lenght}-1
        ${current_product}=    Get From List    ${product_names}    ${index}
        ${next_product}=    Get From List    ${product_names}    ${index+1}
        Should Be True    '${current_product}' >= '${next_product}'    Products are not sorted from Z to A

    END

Verify A to Z sorting
    [Arguments]    ${product_names} 
    ${lenght}=    Get Length    ${product_names}
    FOR    ${index}    IN RANGE    0    ${lenght}-1
        ${current_product}=    Get From List    ${product_names}    ${index}
        ${next_product}=    Get From List    ${product_names}    ${index+1}
        Should Be True    '${current_product}' <= '${next_product}'    Products are not sorted from A to Z ${current_product} > ${next_product}

    END
    




Get all products prices
    ${products_prices}=    Create List
    @{products_price}=    Get WebElements    class:inventory_item_price
    FOR    ${i}    IN    @{products_price}
        ${name}=    Get Text    ${i}
        ${price}=    Remove String    ${name}    $
        Append To List    ${products_prices}    ${name}        
    END
    RETURN    ${products_prices}


Verify low to high prices
    [Arguments]    @{product_prices}
    ${lenght}=    Get Length    ${product_prices}
    FOR    ${i}    IN RANGE    0    ${lenght}-1
        ${current}=    Get From List    ${product_prices}    ${i}
        ${next}=    Get From List    ${product_prices}    ${i+1}
        Should Be True    ${current} < ${next}    Products are not sorted from low to high
        
    END
    
Verify high to low prices
    [Arguments]    @{product_prices}
    ${lenght}=    Get Length    ${product_prices}
    FOR    ${i}    IN RANGE    0    ${lenght}-1
        ${current}=    Get From List    ${product_prices}    ${i}
        ${next}=    Get From List    ${product_prices}    ${i+1}
        Should Be True    ${current} > ${next}    Products are not sorted from low to high
        
    END