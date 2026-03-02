*** Settings ***
Library   Selenium2Library
Library  Collections

*** Keywords ***
Login with standard user
   Open Browser    https://www.saucedemo.com/    Firefox
   Input Text    id:user-name    standard_user
   Input Password   id:password    secret_sauce
   Click Button    id:login-button