
# Product Vision

## Vision Statement

For the gaming community, Game Share is a game review mobile app where you can read other people's opinions and share your own about the most popular games

## Features

### Main Features

 - ### Feature 1  
    **Profile page**: Users will be able to see each other's profiles, where they can find their username, icon, bio, genre preferences and their reviews.   
 - ### Feature 2   
    **Register/Login Page**: There will be a page where users can register or login to the app. Users will be able to recover their password and check a checkbox so that their session is remembered. That way they can they'll be logged in without re-entering their credentials when re-entering the app
 - ### Feature 3   
    **Home page**: Here the user will be able to find the most recent games, most popular ones and some games organized by genres. Each section will have a button names "See all" in order to see all the games of the sectiong in the search page.
 - ### Feature 4  
    **Navigation bar**: There will be a navigation bar where the user can go to the home page, access the search bar, go to the register/login page or go to their profile page (if they're already logged in). 
 - ### Feature 5  
    **Game page**: The game page will be a page where the users can read a game's information, rating and reviews that the users have written.
 - ### Feature 6  
    **User reviews**: Logged in users will be able to write reviews in the game page, giving a rating to the game in question. They will also be able to submit a review without any text, to edit a review and delete a review. Each user will be able to write one and only one review in each game. 
 - ### Feature 7
    **Like/Dislike a review**: Logged in users will be able to like and dislike a review and see the current likes and dislikes in a review.
 - ### Feature 8  
    **Search bar**: Users will be able to search for games with full text search, filters (like genre and rating) and a way to order the results.
 - ### Feature 9  
    **White/Dark Mode**: We will give the user the option to use dark mode (white mode is used by default). The user will be able to switch between the two modes with a button on the main
 - ### Feature 10  
    **Edit user profile**: Logged in users should be able to edit their username, icon and bio of their profile.
 - ### Feature 11  
    **Filter/Order game reviews**: Any user will be able to filter and order the reviews in a game's page.
    

## Assumptions and dependencies

### Assumptions 

- **Internet** - Our app will require the user to have internet access in order to access all the RAWG API's information and to synchronize the Firebase's realtime database.

### Dependencies

- **RAWG: Video Game database API** - Our app will use the RAWG API to retrieve information about video games. We will use this API for some tasks like retrieving all games, games from certain genres and games returned from a search query. In addition to that, we will be using the API to retrieve the information about any game.

- **FireBase** - Our app will use the **Authentication** and **Realtime Database** plugins from the Firebase service. We will use them to store some information like reviews, game's ratings and user information and to manage user authentication in our app.