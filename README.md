# [Weather and Forecast](https://elaborate-florina-mckinley-aviation-f369229d.koyeb.app/)

# Introduction
This is a simple application that shows the current weather and forecast for a given address.
Data is fetched from the OpenWeatherMap API and the NOAA API.

# Development
1. [Generate API key with OpenWeatherMap](#generate-api-key-with-openweathermap)
1. [Clone this repository and navigate to the project directory](#clone-this-repository-and-navigate-to-the-project-directory)
1. [Set up environment variables](#set-up-environment-variables)
1. [Install dependencies](#install-dependencies)
1. [Create databases](#create-databases)
1. [Run the development server](#run-the-development-server)

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
Edit the `.env` file and add your OpenWeatherMap API key.
There are other environment variables that can be set but they are optional.

### Install dependencies
```
bundle i
```

### Create databases
Although the application does not currently use a database, some features are pending that will require one.
```
rails db:setup
```

### Run the development server
```
rails s
```

You can now visit the application at:

http://localhost:3000

### Testing
To run tests as you develop, you can run the following command:
```
rails spec
```

System specs are not run by default.
To run system specs, you can run the following command:
```
rails spec:system
```

Tests and other tools like rubocop are run on CI with each commit.
There is a custom rake task provided to run all checks that are run on CI:
```
rails test:ci
```

# Deployment
The app is deployed here:

https://elaborate-florina-mckinley-aviation-f369229d.koyeb.app/

# Architecture Considerations
## RSpec for testing
Behavior driven development is used to ensure that the application behaves as expected.

## Testing conventions
Primarily, this application is tested with [system](spec/system), [request](spec/requests), [model](spec/models) and [generic](spec/lib) specs.

## VCR for caching API responses
Remember to [filter sensitive data](spec/support/vcr.rb) from the VCR cassettes before committing them to the repository.

## CI
https://github.com/mckinley/weather/actions/workflows/ci.yml

## Services
Use the Services::Hub class for all service requirements.
It handles caching and is aware of the various APIs that can be used to fetch data.
Although it is possible to use other Services directly, it is recommended that all clients use the Hub class instead.
Service methods are organized by the API they use.
Hub methods are organized by concerns that clients may have.
This separation hides API specific details from clients.

## Models
At some point, the application may need to store data in a database.
Currently, the models directory is used to store simple data structures.

## UI
The UI is extremely minimal.

## APIs
### OpenWeatherMap
https://openweathermap.org/api

This API was used to fetch the current weather data.
When implementing the forecast feature, it was discovered that the API does not provide free access to forecast data.

### NOAA
https://www.weather.gov/documentation/services-web-api

The National Oceanic and Atmospheric Administration provides a free API that can be used to fetch forecast data.
It does not, however, provide geolocation data.
OpenWeatherMap is used to fetch geolocation data when using the NOAA API.

## URLs
It is strongly preferable that URLs are resource based.
However, the weather and forecast URLs don't fit nicely in a resource oriented paradigm.

## Caching
Caching is critical to the performance of the application.
The application currently uses memory caching, but this should be replaced with a more robust caching solution like Redis.

## Product
There were many assumptions made during the development of this application.
Ideally there would be opportunity to have several conversations with Product to clarify requirements.
The specifications provided are located [here](docs/Apple%20-%20Ruby%20Coding%20Assessment.pages).

## Review
To view all changes made after the initial generation of the Rails app (`rails new`), this github comparison can be used:

https://github.com/mckinley/weather/compare/8da1c07...main

Clicking on "Files changed" will reveal all changes made to the application since it was generated.

## Screenshots
![Current Weather](docs/Screenshot%202024-09-26%20at%202.01.57 PM.png)
![Forecast](docs/Screenshot%202024-09-26%20at%202.02.33 PM.png)
