# Ruby-selenium

Ruby-selenium
A set of selenium scripts, used as a tool to monitor Thomas Cook sites booking journey by L1 support specialists. It's designed to handle exceptional situations during tests on the go (e.g. do some manual steps to skip one element and proceed with the rest of the script). It aims at speeding up site checks by the human operator instead of full automation using checks for some elements to be present on the page like Selenium tests usually do. Windows shell wrappers are used to launch tests to ease the use by non-technical users. Scripts itself ca be used on linux too. It requires wrapper changes to any linux shell or launching as pure ruby.

Tets reqire the following software to be installed:

- Ruby
- Selenium-Webdriver ruby gem
- Firefox browser
