# LCN User Testing Report

## Overview
We carried out a user testing session on 23/02/18 at the culmination of our first build sprint to discover how real users interact with the LCN data collector prototype, and to fully understand what the priorities should be for subsequent sprints.
We had with us at the session a mixture of Law Centre caseworkers, managers, and reception staff - comprising the lion's share of the people we are targeting our app towards. This document contains a review of the 4 tasks that each of our users carried out, a prioritised list of recommended updates and our suggested changes for any upcoming sprints.


## Tasks
For each of the 4 tasks we had specific hypotheses to test. Throughout user testing we aimed to either reject or accept our hypotheses as well as take on any additional feedback that came up from our users.

---
### Task 1

#### Task: Login and First Impressions
> "First I'd like you to imagine a colleague at your Law Centre has sent you a link to this site and told you that they think it is something that you would be interested in. Please log in and without clicking on anything tell us what you think the site does. Again, it would help us if you could think out loud as you go along."

#### Hypotheses
- [x] Users will have an accurate impression of the app's purpose from looking at the Add Stats page
- [ ] Users will understand how to log in with minimal effort or confusion

#### Findings
* The users liked the layout
* They instantly recognised LCN branding and colours, lending a sense of trustworthiness to the app
* The users were able to gain a clear understanding of what the app does as soon as they log in, without scrolling
* Most users struggled with the placeholder text on the Login view which gave them the impression that the information was already written out ("Larry Law")
* Some users felt that the introduction took up too much space, specifically on mobile view
---
### Task 2
#### Difficulty Level: Medium

#### Task: Report Stats / Quantitive Data
> Imagine it is Friday afternoon and you want to give LCN a rough estimate of the people you've seen this week. Please go ahead and do this.

> You can make up any information you don't know.

#### Hypotheses
- [x] Users will be able to identify their "role type" and "law area" (where applicable) with minimal effort
- [ ] Users will find the categories of "Role type", "Law area", "Main problems", and "Types of Agencies" relevant to them, accurate, and exhaustive
- [ ] Users will find the numerical input easy to use
- [ ] Users will find the numerical questions relevant to them
- [ ] Users will understand the purpose of reporting the information asked of them
- [x] Users will be able to complete this section quickly
- [ ] Users will understand upon submission of their stats that they have completed the core flow of the app
#### Findings
* Users suggested that this page could be further optimised by saving users' persisting information (e.g. role type) on signup
* Users felt that on the whole the questions asked of them were accurate and appropriate
* Users suggested that the "Main kinds of problems seen this week" checkboxes would benefit from proofreading and editing by domain experts of each law area - Islington Law Centre, specifically, have a more exhaustive list which they use in-house
    * "Committals" in Housing law unclear to housing caseworkers
    * Could put "ASBOs" under Housing
    * Could put "Housing benefits" under Housing
    * Could put "Discretionary Housing Payments" under Housing
    * "Welfare Benefits" should be changed to "Welfare Rights"
* One User who self-defined as Management had some possible suggestions for the data to collect in this role type:
    * How many volunteers have you had this week?  
    * Have you got any vacancies?  
    * How much sick leave this week?  
    * How many funding applications have you sent off?  
    * Have you got adequate staff to manage finances?  
    * Have you had any comms or media stories that have raised the profile of your Law Centre?
    * Are there any significant changes in local authority / is your Local Authority about to commission this month?  
    * This user **prioritised** questions under three categories :
        * Volunteer Recruitment
        * Staff Absence
        * Governance and Financial Control

* Users / Caseworkers were unclear as to the difference between "Cases" and "Clients" and felt this needed some form of clarification. One user highlighted that as they operated on a bookings/appointment system, the amount of cases they do each week remains constant.
* Some users highlighted the importance of explaining why each piece of data is useful to the centre
* Users appreciated that all branches of law came across as **equally significant** to each other - though it was felt that outside the app, there was a semi hierarchy
* Some users inputted invalid numbers (standard form, negative numbers)
* Users who got lost in the app and used the browser back button were able to send off this page twice - :bug:
* Users on mobile view were unable to continue past this stage - :bug:
---
### Task 3

#### Difficulty level: Moderate

#### Task: Record a Trend

> "Again it is Friday afternoon and you have noticed a rise in Immigration cases coming across your desk. Please add a comment recording this **trend** you have noticed."

#### Hypotheses

- [x] Users will find the categories of "Success", "Annoyance", "Trend", and "Ask Us" easy to understand
- [x] Users will identify the correct category of "Trend"
- [x] Users will be able to send off an appropriate comment with ease
- [x] Users will go back to the home page to achieve this task
- [ ] Users will understand the general purpose behind this section of the site

#### Findings
* Nearly all users understood we had asked them to record a trend
* When asked, most users found the categories of comment self-explanatory
* There was a variance in people's opinions towards this section
    * One felt more likely to write "Successes" rather than "Trends"
    * Another felt less likely to write "Successes" because they didn't want to fall into boasting (or proving the value of their work as they often had to do in funding applications)
    * One user felt dismissive of the idea of a commenting platform but would have appreciated a separate route to send off full case studies for use by LCN
* There was a general consensus amongst users that engagement in the comment platform would vary depending on many factors - for instance the outgoing-ness of the person in question.
* Users did not understand that this was an optional part of the flow
* Some users wondered whether there should be a differentiation between comments on policy (for example) and general gripes more related to daily goings on at their Law Centre
* One user suggested putting the "Trend" option before Successes and Annoyances in the list, as they felt this would be the information most useful to LCN and therefore should be the default
* This view was maybe a bit ambiguous - Some users were unsure as to how (or if at all) this related to what they had just filled in. One user thought that they were being asked to comment on the stats they had just given.
---
### Task 4
#### Difficulty level: Hard

#### Task: Browse and Reply To Comments
> "Have a browse through the comments on the app and reply to any that you find interesting"
#### Hypotheses
- [x] Users will understand the general purpose behind this section of the site
- [ ] Users will understand that this is an optional part of the flow
- [ ] Users will be able to easily reply to comments as they see fit
- [x] Users will be able to easily filter comments by their type
- [x] Users will find the interface easy-to-navigate in general

#### Findings
* At this point, users could articulate the "Big Picture Goal" of this section - that it was about forging a feeling of community amongst Law Centre employees
* Users felt that the Law Area of each person commenting should be displayed as it might be useful
* Users felt that an ability to sort and filter by Role Type and/or by Law Area would be a useful functionality, and could even replace current email threads between caseworkers working in a specific field
* Some users felt that the word "Comment" was frivolous - whereas the qualitative data that could be gained in this section could be really useful when working on a political and research level
* Some users raised the concern that what they wrote would be monitored by their employers, meaning they were less likely to be open in this context
* Though most users understood the icons we used to represent "Like" and "Send", those less familiar with mobile design patterns used by apps such as WhatsApp did not find the Arrow button intuitive
* There was some confusion around the "Ask Us" section of the app
---
## Other
* The navigation bar at the top of the screen was often overlooked when we asked people to navigate
---
## Summary and prioritisation of findings

This session has proved enlightening. It seems as though our focus needs to be on absolute simplicity and efficiency - especially for the core functionality of the app. Our users see themselves as people with an immense workload who are already inundated with paperwork and hoops to jump through.

As a result we sensed what might prove to be initial resistance to the use of new technology without making **explicit throughout the process** what use such data collection will have - for instance in the national-level policy work that LCN carries out, and how that has the potential to impacts the local, everyday work of Law Centre employers and their clients.

We have ordered the problems in order of priority, based on:
1. The number of people who mentioned the issue
2. The amount of frustration the issue caused
3. The time spent overcoming the issue

__High priority__  :red_circle:  
* Create a solid login functionality
    * This will involve sending an email from a central account containing a one-time link which takes the user to a sign up page
    * The user will put in their persisting details and receive a confirmation on completion
    * The user is taken to the login screen and is able to either log in, or to reset their password if they have forgotten it
    * The login placeholder text will contain prompts instead of examples : "Please enter name here" instead of "Larry Law"
* The questions asked of each user group will be vetted, reviewed, and modified by people with domain knowledge, and adjusted accordingly
* The numerical inputs will be adapted to disallow any invalid input
* The navigation bar should stick to the top of the screen so that its always accessible
    * The link titles should be reviewed for clarity
    * The links should be made bigger, with a colourful underline on the active page
* The statistical data asked of **Management** will be confirmed by LCN and built by us
* The app will be fully tested and optimised for mobile use
* We will not allow users to submit data until it has been checked to be valid
* We will not allow users to submit quantitive data more than once
* We will make explicit on successful submitting of the statistical data that users are able to exit the app
* Make like functionality
* Ensure one like per user per post
* Create simple Airtable interface for LCN to reply to Ask Us questions, and create document outlining how to do this

__Mid Priority__ :yellow_heart:
* We will switch around the order of Comment Types so that "Trends" comes first
* Create "Why are we collecting this data?" "?" tooltip on some questions with copy from LCN that explains why its useful
* Guide users from inputting stats to the List Comments View (instead of Add Comments)
* Add a clear way to add a new comment from the List Comments View
* The arrow button on reply should be changed to a button saying "Send" for maximum explicitness
* Create further filtering functionality of comments by Law Area
* Create further filtering functionality of comments by Role Type
* Consider a rename of "Comments"

__Low Priority__ :green_apple:
* Create sorting functionality allowing users to sort by number of likes, or most recent comments
* Develop more detailed and intricate ways of visualising the data we collect, and have a separate view for showing this
* Create a more fully-featured thread/forum functionality*

\* _this might be considered more of a long-term stretch goal_
