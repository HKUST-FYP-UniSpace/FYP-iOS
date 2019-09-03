<p align="center">
<img width="100" height="100" src="https://github.com/HKUST-FYP-UniSpace/FYP-iOS/blob/master/UniSpace/Assets.xcassets/Fake_icon.imageset/UniSpace%20logo.png">
</p>

# FYP-iOS

> Commission-free mobile platform with algorithm-based suggestions

**UniSpace**, is particularly designed for university students. It is a commission-free mobile platform to help students find off-campus accommodations without going through real estate agents. It provides choices and suggestions for the students to select both their preferred locations and roommates for the rental and trade unwanted furniture and daily necessities to achieve environmentally friendly.

The initiative of this project is to provide university students with a more convenient way to form rental-related deals in a bid to unload their housing burden. The ultimate vision is to create a one-stop shop for the university community to communicate regarding their accommodation needs and quickly access solutions of to their needs.



## Requirements

- iOS 11.0+
- Xcode 10.1



## Key Features

- Upload rental information (House owners)
- Search and filter system (Tenants)
- Roommate matching system (Tenants)
- Trading system (House owners and tenants)
- Live chat room (All users)



## User Interface Design

### Principles

Following Apple’s human interface guidelines enables our application to be consistent with other apps in iOS. Our UI design principle is concise, consistent and clear. Throughout the whole application, unnecessary UI elements are removed to reduce distraction from our users. The view hierarchy is reduced to be as flat as possible to keep the app simple.

Similar UI elements are recurring in the whole application in order to reduce users' learning cost. By mimicking common UI elements from other apps, the user experience would be intuitive.

Colour usage is aesthetically-pleasing yet not overdone. It allows the app to be straightforward, as the theme colour indicates which elements are pressable. By embracing the current iOS design principle, title font size choice is bolder, which help users differentiate between sections.

Below are some selected user interface, which illiterates our design principle. More can be found in [screenshot folder](https://github.com/HKUST-FYP-UniSpace/FYP-iOS/blob/master/screentshots/).



### Apartment

Since it is the main feature of our project, the UI design is crucial to attracting users staying in our application. With that in mind, the UI of the homepage can be divided into three sections, search bar, suggestions and saved apartments. The search bar is pinned on top so that users can search for an apartment right away, as searching is the most important function among the three. Suggestions come next which is based on users’ past behaviour and preferences. It is implemented as a horizontal scrolling view so that the suggestions are revealed to users one by one, as the element of unknown and surprises intrigued users to swipe for more. The saved section down below shows the four most recent added apartments information. It encourages users to go back to it, and hence increased the chance that they found a matching team.

Apartment Home Page             | Apartment Filter Page 
:-------------------------:|:-------------------------:
![house landing page](https://github.com/HKUST-FYP-UniSpace/FYP-iOS/blob/master/screentshots/01-house-01-landing-01.PNG)  | ![house search filter](https://github.com/HKUST-FYP-UniSpace/FYP-iOS/blob/master/screentshots/01-house-06-house%20search%20filter-01.PNG) 

|                    Apartment Detail Page                     |                Apartment Detail Page (Cont.)                 |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![house detail](https://github.com/HKUST-FYP-UniSpace/FYP-iOS/blob/master/screentshots/01-house-02-house%20detail-01.PNG) | ![house detail cont.](https://github.com/HKUST-FYP-UniSpace/FYP-iOS/blob/master/screentshots/01-house-02-house%20detail-03.PNG) |



### Trade

The landing page for Trade tab would be the page users use most frequently after they rent an apartment, hence we have put extra effort into its design. Although the design is similar to the apartment landing page, the difference is that it consists of more sections and more visible trade items. This is due to users sometimes have no idea what you want until they see it, unlike searching for an apartment. Therefore by introducing more trade items to them, they might aspire. Their selling items are also shown on the page. Horizontal scrolling view is used to clearly divide this section with others to reduce confusion.

|                      Trade Landing Page                      |                  Trade Landing Page (Cont.)                  |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![house landing page](https://github.com/HKUST-FYP-UniSpace/FYP-iOS/blob/master/screentshots/02-trade-01-landing-01.PNG) | ![house search filter](https://github.com/HKUST-FYP-UniSpace/FYP-iOS/blob/master/screentshots/02-trade-01-landing-03.PNG) |



### Messages

There are five types of messages, messages between tenant and house owner, messages within the team, messages for trading, messages to join a team and messages to the system admin. A selected colour is used to differentiate the different type of chats, while there still is a label to indicate the type of chats. The bubble next to it is the number of unread messages. It is added to alert the user when a new message is received.

We also have a calendar for users to mark down important events. The calendar shows in a monthly view, while there is a “swap” button to change the displaying month. The section underneath shows events on the selected day.

|                     Message Landing Page                     |                    Calendar Landing Page                     |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![house landing page](https://github.com/HKUST-FYP-UniSpace/FYP-iOS/blob/master/screentshots/04-message-01-message-01.PNG) | ![house search filter](https://github.com/HKUST-FYP-UniSpace/FYP-iOS/blob/master/screentshots/04-message-02-calendar-01.PNG) |



## Implementation

### Connect to the REST API

All of our data requests would go through a data extraction class. It would direct the request to either API calls or local database decided by the functionality. This implementation allows the data request part in view controllers stays the same. It also allows the application to simulate server response by directing the HTTP request to local testing classes. We heavily rely on this method when developing new functions, which give us real-time feedback and speed up the development cycle.



### Build the UI

After the design process was done, the UI elements are implemented with Swift to produce native iOS code. The Storyboard is not used because developers have to resolve git merge conflict every time after updating the design. In a sizable project, it would be too time consuming and inefficient. Instead, all view elements like text field, button, image view and separator are coded to be scalable. They are then grouped in different combination to form a cell and finally, different cells are grouped to be a view. The advantage of this method is it significantly reduced the code footprint plus to code becomes more modular and readable.



### Security

In the official documentation, it provides two ways to save preference. Storing data in Keychain is considered as safe, while User Defaults as unsafe. This is due to the fact that everything stored in Keychain is encrypted, but data stored in User Defaults are only saved as an unencrypted property list. Therefore, important information like username and password is stored in Keychain, while less important data is stored in User Defaults.



### User Authorization

To ensure the user is authorized properly, a few layers of protection is designed. First, compartmentalization is enforced. By making sure the login and register views are on a different view stack of the main application, there is no bug user can exploit to bypass the authorization process. Second, a request retrier has been implemented. Every time the application receives a 401 HTTP unauthorized response, which may due to session expired or without session token, the retrier kicks in and try to login again behind the scene. If it is successful, the token would be updated and the user would not notice; but if it is unsuccessful, the user would be redirected to the login page instantly. The retrier has a retry queue to avoid a race condition. Once one of the retry requests is successful, all request on the queue would be resent and update the view.



### Haptic Feedback

Haptic feedback is implemented to provide an immersive experience for users. By generating subtle vibrations on certain activities, it encourages users to interact with the applications and offers a more pleasant user experience. In our user interface design, pressing buttons and presenting new view controllers on current view stacks would trigger haptic feedback; however, pushing new view controllers on current navigation controllers would not as these actions are acted on the same level of the view stacks.



### Logger

The problem with debugging a distributed application is tracking an error. User reports are usually missing critical information to recreate the error. The response from the developer, therefore, would be delayed. By developing an in-app logger, the developer would have a better clue on the problem the user was encountered.



### Diff Algorithm

We use IGListKit library developed by Instagram to manage the nested collection view in most of the views. One advantage comes with using this library is that a diff algorithm is used to manage data in the view. The algorithm calculates the difference between the old data and the new data retrieved from the server, then add or remove the corresponding cells. By updating data in the view without re-rendering all of the views, the application response time is improved and less computing is needed.