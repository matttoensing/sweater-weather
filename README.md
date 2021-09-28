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
weather_key: <OpenWeather API key goes here>
```

3. A Mapquest API key can be obtained <a href="https://developer.mapquest.com/documentation/">here</a>
4. Repeat step #2 with the Mapquest API key, and name the variable `geo_key`. It should look like this:

```
geo_key: <MapQuest key goes here>
```

5. An Unsplash API key can be obtained <a href="https://unsplash.com/documentation">here</a>
6. Repeat step #2 with the Unsplash API key, and name the variable `unsplash_key`. It should look like this:

```
unsplash_key: <Unsplash key goes here>
```

## Usage

Great! Now that you have all the API keys, you are ready to run the application. I recommend using <a href="https://www.postman.com/">Postman</a> for all your API needs as a developer, however local host will do as well. From the command line, run `rails s` to start your local server. Now that the server has been fired up, you can checkout all the endpoints in postman. Use the url `http://localhost:3000` in postman to send requests to your server. A detailed list of the endpoints that are available within this application are in the table below. 


<!-- ROADMAP -->
## Endpoints

See the [open issues](https://github.com/github_username/repo_name/issues) for a list of proposed features (and known issues).


<!-- CONTACT -->
## Contact

Your Name - [@twitter_handle](https://twitter.com/twitter_handle) - email

Project Link: [https://github.com/github_username/repo_name](https://github.com/github_username/repo_name)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* []()
* []()
* []()




[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/matt-toensing/
