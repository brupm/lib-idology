You must have a valid IDology account to test or use this API library.

### ID Verification via IDology

Assuming you have a local proxy setup to the development server - and the development server's IP is authorized to access the IDology API - here is a curl command to test whether or not the API is working correctly. In this example, the socks v5 proxy is using 'ssh -D localhost:1080' to setup a temporary proxy between the development machine and the development server. Note that the username / password must be correct.

This curl command will perform a search for 'Mickey Mouse' - a valid test record in the IDology system

curl -v --socks http://127.0.0.1:1080 -d username=test -d password=test -d firstName=mickey -d lastName=mouse -d address='15 MIDLAND AVE APT' -d city=paramus -d state=NJ -d zip=07652 https://web.idologylive.com/api/idiq.svc


### Configuration

The lib directory must contain a file called 'config.yml' using the following format:

### IDology API username and password

username: your_api_username
password: your_api_password

It is recommended that you symlink this file to the directory after deploy for security reasons. This file is also required for development mode - just fill with dummy data.

### Tests

1. gem install jewler
2. gem install rspec 1.3.1 and rspec rails 1.3.3

To run the rspec tests, simply type 'rake' - these tests do not hit the API directly, they use fixtures.
