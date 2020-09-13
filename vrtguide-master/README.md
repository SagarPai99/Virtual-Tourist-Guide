# Virtual Tourist Guide

Page 14
Govt of Goa 	Virtual Tourist Guide 	Software 	DR135 	Travel and Tourism
Goa is a major tourist destination which pulls thousands of tourists every year. Goa is known for its beautiful beaches and hospitality. There are a number of monuments and landmarks depicting the cultural, history and development of Goa. Due to high inflow of domestic as well as international tourists, the manpower required to guide the tourist on these landmark is not sufficient and sometimes lack in the information that need to be given and highlighted to the tourist. Hence we propose the problem of developing a mobile application which renders information about the monument or landmark just by taking their live pictures as inputs. In other word, the application should allow the user to click a photograph and based on the picture it should display information about the monument/landmark. The application should also notify the user about such monuments/landmarks in the vicinity. The app should also allow the user to give their inputs about the object and also add to knowledge creation about the monuments/landmark. The app should also be able to keep statics about the number of users referring to the monument/landmark along with details of the users.

Android App

- [ ] Core Locations/Monuments/Landmarks/... detection
- [ ] Central Repository of Information ( Key takeaways, Text, Pictures, Reviews ) of the above
- [ ] Search this Central Repository manually as well
- [ ] Nearby suggestions ( People who visited this also visited this kind of thing )
- [ ] Review System for all of the above
- [ ] Simple Blog System? ( Is it needed after Review is already there? )
- [ ] Rating System, Upvote/Downvote System for reviews and blogs.
- [ ] Keep statistics of number of people visiting, build stats based on their reviews as well
- [ ] Apart from stats, allow users to check their history
- [ ] OAuth
- [ ] Itinerary generator

Web API

- [ ] ML Core Locations/Monuments/Landmarks/... detection API ( Use for stats building )
- [ ] Core Locations/Monuments/Landmarks/... information API for entire database ( Use for stats building )
- [ ] Nearby API based on a location
- [ ] Review, Rating, Upvote/Downvote System API
- [ ] Itinerary API? ( Based on what inputs? )
- [ ] Stats API about various aspects
- [X] Keep history in App itself ( Although backend history, stats will be built )