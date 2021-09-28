[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/github_username/repo_name">
    <img src="https://user-images.githubusercontent.com/80132364/135163947-9703fd2d-2fdf-4c21-81ad-99816102ceac.png" alt="Logo" width="120" height="120">
  </a>

  <h3 align="center">Sweater Weather</h3>

  <p align="center">
    A Road Trip App For Your Travel Needs
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#gem-setup-and-api-keys">Gem Setup and API Keys</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#endpoints">Endpoints</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

![Screen Shot 2021-09-28 at 2 00 03 PM](https://user-images.githubusercontent.com/80132364/135164860-b13d559f-dd3f-4592-ac50-1dc660ec1a9d.png)


This is an API application built with Ruby on Rails. It is designed to expose weather data for a location, show an image for a given location, handle user registration as well as login, and show road trip information. Road trip information includes travel time between an origin and destination, and weather at estimated time of arrival. Five different <a href="#endpoints">endpoints</a> are included in this application.


### Built With

* Ruby 2.7.2
* Ruby on Rails 5.2.6

### Gems Used

* <a href="https://github.com/bcrypt-ruby/bcrypt-ruby">bcrypt</a>
* <a href="https://github.com/thoughtbot/factory_bot_rails">factory bot rails</a>
* <a href="https://github.com/faker-ruby/faker">faker</a>
* <a href="https://github.com/lostisland/faraday">faraday</a>
* <a href="https://github.com/Netflix/fast_jsonapi">fast json api</a>
* <a href="https://github.com/laserlemon/figaro">figaro</a>

### Gems Used For Testing
* <a href="https://github.com/rspec/rspec-rails">RSpec for Rails</a>
* <a href="https://github.com/bblimke/webmock#rspec">webmock</a>
* <a href="https://github.com/vcr/vcr">vcr</a>

## Getting Started

### Prerequisites

* Ruby 2.7.2
* Ruby on Rails 5.2.6
* API keys from Unsplash, Mapquest, and OpenWeather. Instructions on obtaining and using API keys locally with this application can be found below. 
* <a href="https://www.postgresql.org/download/">Postgresql</a>

### Installation
Clone down this repo

```
git clone git@github.com:matttoensing/sweater-weather.git
```

Move into sweater weather directory
```
cd sweater-weather
```

Install any missing gems

```
bundle install
```

Setup your local database with Postgresql. 
```
rails db:create
rails db:migrate
```

### Gem Setup and API Keys
First, install figaro on your repo. To do this, run:
```
bundle exec figaro install
```

This will install a .yml file in the config directory called `appication.yml`. This file is where API keys are used within the application as ENV variables. API keys stored in this file will not be pushed up if storing your repo on GitHub. 

1. You can obtain a open weather API key <a href="https://openweathermap.org/api">here</a>
2. Once a weather API key has been obtained, copy paste it into the `config/application.yml` with a local variable called `weather_key` as follows:

```
weather_key: <OpenWeather key goes here>
```

3. A Mapquest API key can be obtained <a href="https://developer.mapquest.com/documentation/">here</a>
4. Repeat step #2 with the Mapquest API key, and name the variable `geo_key`. It should look like this:

```
geo_key: <MapQuest key goes here>
```

5. An Unsplash API key can be obtained <a href="https://unsplash.com/documentation">here</a>. Please review the Unsplash guidelines for crediting photos <a href="https://help.unsplash.com/en/articles/2511245-unsplash-api-guidelines">here</a>
6. Repeat step #2 with the Unsplash API key, and name the variable `unsplash_key`. It should look like this:

```
unsplash_key: <Unsplash key goes here>
```

## Usage

Great! Now that you have all the API keys, you are ready to run the application. I recommend using <a href="https://www.postman.com/">Postman</a> for all your API needs as a developer, however local host will do as well. From the command line, run `rails s` to start your local server. Now that the server has been fired up, you can checkout all the endpoints in postman. Use the url `http://localhost:3000` in postman to send requests to your server. A detailed list of the endpoints that are available within this application are in the table below. 


<!-- ROADMAP -->
## Endpoints

HTTP Verb | Endpoint              | Description                              | Link
----------|-----------------------|------------------------------------------|---------------------------
GET       | `/api/v1/forecast` | Get the forecast for a location | [Link](#get-forecast)
GET       | `/api/v1/backgrounds`       | Find a background for a location | [Link](#backgrounds)
POST      | `/api/v1/users` | Create a new user in the system | [Link](#create-a-user)
POST      | `/api/v1/sessions` | Login a User | [Link](#create-a-new-session)
POST      | `/api/v1/roadtrip` | Request Road Trip information | [Link](#roadtrip)

---

### Get Forecast

Returns a Forecast for a given location. This endpoint must include a location through params. 

```
GET /api/v1/forecast?location={location}
```

OR 

```
GET /api/v1/forecast?location={location}?units=metric
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`location`  | String | Path | Required | Location of a City or Destination
`units`     | String | Path | Optional | See notes below

Notes: 
Units is an optional parameter. The default response will be in imperial units. To return metric values, include metric with the key units in params

### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021-09-28 13:31:36 -0700",
                "conditions": "clear sky",
                "temperature": 89.9,
                "humidity": 36,
                "feels_like": 89.3,
                "uvi": 5.43,
                "visibility": 10000,
                "sunrise": "2021-09-28 06:29:56 -0700",
                "sunset": "2021-09-28 18:25:47 -0700"
            },
            "daily_weather": [
                {
                    "date": "2021-09-29",
                    "sunrise": "2021-09-29 06:30:40 -0700",
                    "sunset": "2021-09-29 18:24:22 -0700",
                    "max_temp": 86.7,
                    "min_temp": 72.3,
                    "conditions": "overcast clouds",
                    "icon": "http://openweathermap.org/img/w/04d.png"
                },
                { ... }
            ],
            "hourly_weather": [
                {
                    "time": "14:00:00",
                    "temperature": 89.9,
                    "conditions": "clear sky",
                    "icon": "http://openweathermap.org/img/w/01d.png"
                },
                { ... }
            ]
        }
    }
}
```

---

### Backgrounds

Returns a Background image from Unsplash for a given location. This endpoint must include a location through params. 

```
GET /api/v1/backgrounds?location={location}
```

### Parameters

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`location`  | String | Path | Required | Location of a City or Destination


### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "location": "boulder, co",
            "image_url": "https://images.unsplash.com/photo-example",
            "description": "exmaple photo description",
            "credit": {
                "photographer": "Example User",
                "author_profile_url": "https://api.unsplash.com/users/example",
                "author_url": "http://example.com",
                "source": "unsplash.com"
            }
        }
    }
}
```
---

### Create a User

This will endpoint create a new user in the database. The information must be sent through the body of the request to be successful. Upon creation of a new user, an API key will be generated for the user to be used for the [Road Trip](#roadtrip) endpoint.

```
POST /api/v1/users
```

Example of request body:
```
{
  "email": "example@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

### Body

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`email`  | String | Body | Required | Users Email
`password`  | String | Body | Required | Users Password
`password_confirmation`  | String | Body | Required | Users Password for Authentication


### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "email": "example@example.com",
            "api_key": "gUayV8OvgSUGAQc8n4FnvQ"
        }
    }
}
```
---

### Create a New Session

This will endpoint login a user if the password is authenticated. The user must already exist in the database to successfully login. 

```
POST /api/v1/sessions
```

Example of request body:
```
{
  "email": "example@example.com",
  "password": "password",
}
```

### Body

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`email`  | String | Body | Required | Users Email
`password`  | String | Body | Required | Users Password


### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "email": "example@example.com",
            "api_key": "gUayV8OvgSUGAQc8n4FnvQ"
        }
    }
}
```
---

### Roadtrip

This endpoint will generate travel time between an origin location and a destination in the response body. It will also determine the weather at the estimated time of arrival for the destination.  

```
POST /api/v1/roadtrip
```

Example of request body:
```
{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "gUayV8OvgSUGAQc8n4FnvQ"
}
```

### Body

Name        | Data Type | In    | Required/Optional    | Description
------------|---------|-------|----------------------|------------
`origin`  | String | Body | Required | An origin location
`destination`  | String | Body | Required | A destination location
`api_key`  | String | Body | Required | An API key for a specific user registered with the application


### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver, CO",
            "end_city": "Pueblo, CO",
            "travel_time": "1 Hours, 44 Minutes",
            "weather_at_eta": {
                "temperature": 79.1,
                "conditions": "few clouds"
            }
        }
    }
}
```
---


## Contact

Matt Toensing - [@instagram](https://www.instagram.com/matt_rtoensing/) - [Email](mailto:matthew.toensing@gmail.com) - [GitHub](https://github.com/matttoensing) - [LinkedIn ](https://linkedin.com/in/matt-toensing/)

Project Link: [https://github.com/matttoensing/sweater-weather](https://github.com/matttoensing/sweater-weather)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* Turing School of Software and Design
* Unsplash API
* Mapquest API
* OpenWeather API


[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/matt-toensing/
