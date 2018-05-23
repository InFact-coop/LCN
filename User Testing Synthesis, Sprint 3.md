# LCN User Testing Synthesis, Sprint 3

## An onboarding screen

The first page users come to after logging in immediatey asks for personal information. As a result there was a sense from some users that we are asking for a lot of data before giving much away. To remedy this we recommend creating a designed "onboarding" screen. This will perform two functions:

* The onboarding screen will introduce how to use the app. What do we mean by a "Comment" section in the context of LCN, for example?

* The onboarding screen will also act as an incentive to users. We have noticed throughout our user testing sessions that the initial reluctance people have towards giving up the statistics we ask of them are mollified once we explain how this data gets used on a wider research and policy level. Our aim is to portray data collection and the work done in law centres as two sides of the same coin. Providing consistent numerical snapshots of law centres throughout the country allows LCN to campaign effectively for the policy changes that will make the work of any of our user base more effective, efficient, and successful. Highlighting to people that using this app is actually to their benefit should be our incentive.

## Before you Begin

* **Feedback**: It is not immediately obvious that the "Role type" buttons were clickable as they are all faded out.
  **Proposal**: We would highlight/pre-select a role type by default to demonstrate to people the functionality of these buttons.

* **Feedback**: Some managers also regularly do casework, so we might be missing a trick here.
  
  **Proposal**: Make the "Role type" buttons multi-select. Include a clarification ("You can select more than one"). Combine the questions we ask on the next page.

## AddStats

* **Feedback**: The maximum number/answer for each question could be significanty different for every question depending on each law centre.
  **Proposal**: Change question input from sliders to versions of the number input we had before, but made in the brand colours of LCN.
  ![proposed sliders](https://user-images.githubusercontent.com/22657280/40374028-1f48e314-5de0-11e8-9573-83615cc0fa9c.png)

* **Feedback**: Some users felt negative on first view of this page because they worried they would be unable to recall the exact statistical information we were asking of them.
  **Feedback**: Users often skipped the intro text and as a result missed crucial information about what we were asking of them
  **Proposal**: The intro text should be emphasized using different font weights to encourage people to actually read. We should reassure them we are asking for only **estimates** and **rough figures**.

* **Feedback**: Some instructions might benefit from further clarification.
  **Proposal**: Add more prompter text by each question, for example, "Click all that apply" underneath the checklist, to allow people with a range of technical proficiency to use the platform with ease.

* **Feedback**: It's possible that long-term users of the platform might find the unsorted checklist a bit of a pain to use
  **Proposal**: Alphabetise!

### Reception/Triage

* **Feedback**: This user felt that the term "Law Centre advice" was ambiguous, as it could refer to either internal or external law centres.
  **Feedback**: They felt that the word "referred" was inappropriate for reception/triage questions, as it suggested a more formal process.
  **Feedback**: The checklist of "Types of agencies referred to" was non-exhaustive. "Local" might refer to within-borough, or within-city.
  **Feedback**: The client also suggested "Local solicitor" as another checklist option
  **Proposal**: Double check receptionist/triage copy for points of ambiguity like this, and clarify them according to suggestions from our user base.

  **Proposal**: Add an extra numerical question: "Of those enquiries, how many people were either taken on or given an appointment by your law centre?"

### Management

* **Feedback**: For this user, the total amount of vounteers is not clearly summarised as "student", "non-student", and "lawyer". Some students are studying to be lawyers, for example, some volunteers do admin, and some might have other miscellaneous roles.
* **Feedback**: The question about "media coverage" does not fit the expected format for a numerical answer
* **Feedback**: The vacancies question could refer to trustees, but it should just refer to "staff".
  **Proposal**: Double check management copy for points of ambiguity like this, and clarify them according to suggestions from our user base.

### Lawyer/Caseworker (Employment law)

* **Feedback**: The term "client matters" could be ambiguous, as some people who work at law centres might do outreach work outside of their law centre - for example, working in employment centres for some of the week.
  **Feedback**: The word "problems" is both ambiguous and potentially leading
  **Feedback**: This user would have been happy to have narrowed down the checklist point "Discrimination" to expand on different types of discrimination.
  **Feedback**: "Constructive dismissal" might also be an appropriate point to put in
  **Proposal**: Double check all lawyer/caseworker copy for points of ambiguity like this, and clarify them according to suggestions from our user base.

### Lawyer/Caseworker (Welfare)

* **Feedback**: Could add "Carers' allowance" to checklist

## AddStats (Modal/Thank You Screen)

* **Feedback**: The wording of this section is fairly ambiguous. Most users described some confusion as to who was referred to by "we", and who was referred to by "your" (i.e. "With your help, we have seen 220 people this week").
  **Proposal**: Through conversation with you, we will rethink this page to both make it feel relevant and clear for each role type.

* **Feedback**: Though users recognised that at this point in the process we were giving them the option to bow out, there was a discussion on whether or not we want to put slightly less emphasis on this option.
  **Proposal**: We will discuss with our designer how we might tweak this aspect of the design to give people the option to log out whilst encouraging discovery of the "Comments" section.

* **Feedback**: One user felt uncomfortable that they were unable to revise their statistics if they wanted to.
  **Proposal**: Add an option to the fixed navigation bar to allow people to back and and revise their statistics. This has the added benefit of offering "Privacy by design", by giving people greater control over the data they give us.

## Comments

* **General Feedback**: Most of our users understood the potential of the comments section for creating a sense of organisational community among quite remote and disparate centres. There was a feeling that, if done right, it could replace some of the interactions that already happen naturally between members of the community.

  The proof will be in the uptake of the service. Value is only added to the user if it is used by other people. In certain use cases users could imagine the service working successfully by being an alternative avenue of traffic to already-clogged email inboxes. Alteration of this section of this site along the lines of user feedback to encourage usage is therefore crucial to the adoption of the comments section. Here are some suggestions:

* **Feedback**: With discrete categories like "Trend", "Success", "Annoyance", and "Trend", there will be inevitable edge cases. Some users felt the use of this was inflexible.
  **Proposal**: Lots of users recommended converting this system to "tags" in the LCN brand colours. Some of these could be predetermined, eg:

  * "Law", "Triage", "Management"... in one colour
  * "Annoyance", "Success, "Trend", "Ask Us"... in another colour
  * "Employment", "Immigration", "Welfare"... in another colour
  * and some could be custom, allowing more finegrained control, in another colour
    ![like so](https://user-images.githubusercontent.com/22657280/40421281-44fd3e86-5e83-11e8-9406-392bbe5b5794.png)

* **Feedback**: The term "_Ask Us_" might be a bit too generic.
  **Proposal**: Change "_Ask Us_" to "Ask LCN".

* **Feedback**: The amount that people write for each comment might vary wildly.
  **Proposal**: Set a max amount of characters for each comment.

* **Feedback**: One user found leaving the "Add comment" section without posting a bit unintuitive.
  **Proposal**: Add a "Cancel" button so that users are able to change their mind, and exit the view without submitting data
  **Stretch Goal**: Bring the Add Comments view onto the main page as an overlay that appears when a "+" button is clicked.

* **Feedback**: The Comment/"Thank you" Screen feels unnecessary
  **Proposal**: Take it out, and signal that adding the comment is successful on the List Comment page.
  **Proposal**: Incorporate the "Add Comment" view into the main page

* **Feedback**: One user, who felt a lot of his colleagues had busy lives, imagined themselves using the comments section whilst in transit, on a train or bus.
  **Proposal**: Optimise this section of the platform for mobile use

* **Feedback**: Meaningful or thought-provoking comments might get lost in the feed as it currently is
  **Proposal**: Have the option to sort comments in multiple ways:
  * Most recent comment (how we sort currently)
  * Most commented on
  * Most upvoted
    **Proposal**: Consult with the designer to implement a filtering/search functionality utilising the new "tags" mentioned above. This could massively improve the usefulness of the comments section. One user imagined being able to "search" for good cases to use with a particular judge, for example.
