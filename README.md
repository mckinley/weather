# README

## Introduction
This is a simple application that shows the current weather and forecast for a given address. Data is fetched from the OpenWeatherMap API and the NOAA API.

## Development
1. Generate API key with OpenWeatherMap
1. Clone this repository and navigate to the project directory
1. Set up environment variables
1. Install dependencies
1. Run the development server

### Generate API key with OpenWeatherMap
You will need to sign up for an account but you will not need to provide any payment information.
https://home.openweathermap.org/users/sign_up

Once you have an account, you can generate an API key.
https://home.openweathermap.org/api_keys

### Clone this repository and navigate to the project directory
Example using SSH:
```
git clone git@github.com:mckinley/weather.git
cd weather
```

### Set up environment variables
```
cp .env.example .env
```
Edit the `.env` file and add your OpenWeatherMap API key. There are other environment variables that can be set but they are optional.

### Install dependencies
```
bundle i
```

### Run the development server
```
rails s
```

You can now visit the application at http://localhost:3000

## Testing
To run tests as you develop, you can run the following command:
```
rails spec
```

System specs are not run by default. To run system specs, you can run the following command:
```
rails spec:system
```

Tests and other tools like rubocop are run on CI with each commit. There is a custom rake task provided to run all checks:
```
rails test:ci
```

## Deployment

## Architecture Considerations
### RSpec for testing
Behavior driven development is used to ensure that the application behaves as expected.

### Testing conventions
Primarily, this application is tested with system, request, model and generic specs.

### VCR for caching API responses
Remember to filter sensitive data from the VCR cassettes before committing them to the repository.

### Services
Use the Services::Hub class for all service requirements. It handles caching and is aware of the various APIs that can be used to fetch data.

## Happy coding!

