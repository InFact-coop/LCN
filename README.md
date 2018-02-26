# LCN

See our app [here](https://lawcentres.herokuapp.com/) :eyes:

## The Workshop :hammer:

After the work done with LCN in the [CAST fellowship design sprint](./DesignSprint.md), we'd decided to run a subsequent workshop. For the new people joining our development team, this was a chance to familiarise ourselves with the problem space, as well as to refine it. Our main goal was to take the lessons learnt from the first sprint and, through a series of design thinking exercises, challenge our assumptions about the problem we were trying to solve and help us to visualise it in different ways. At the end of this process, we sat down with Nimrod and honed down the prototype scope into something easy-to-use, and that hopefully solves the challenge at hand:

## The Challenge :checkered_flag:

LCN has trouble collecting data from each Law Centre as they all provide it in slightly different forms and with slightly different definitions. LCN has also found it has trouble providing real life stories of the effect that the work being done in Law Centres is having on people's lives. The challenge is to provide a platform which will allow Law Centres to quickly, and cohesively share quantitative data with LCN. The platform will also allow lawyers, case workers, receptionists and managers to share their stories with LCN.

This data will allow LCN to speak out quickly and with better authority about the issues arising at Law Centre's across the country. It will also allow Law Centre's to share insights and trends with each other and to see if their individual experience is similar to that of other Law Centres.




## Our Solution :bowtie:

**LCN Feedback Platform**

> Simple, quick, data collection with instant feedback on what others think

**The aims of the solution**

* Allow Law Centre workers to input specific quantitative data, such as how many people they have seen that week, so that LCN can get consistent data from all Law Centres in the network
* Allow users to quickly and easily share stories, trends they have spotted or annoyances that they have had with LCN and other Law Centres
* Let users see the stories that others from different Law Centres have shared and allow them to reply to or like those stories
* Store the quantitative data and the stories that Law Centre workers have shared in a way that is easily accessible to LCN. This will allow LCN to share it externally or to see if there are trends across the country that might require further investigation

### Process :clipboard:

**Prototype**

We created static designs using an online tool called Figma. This allowed us to map the rough user journey and provide us with a chance to have rapid feedback on the designs prior to building the product with code.

Below are the designs we created _*(note: the final designs have changed since these)*_

> The user comes onto the app and is asked to log on. This will be a requirement when the product goes live due to the sensitive nature of the data

<img width="410" alt="screen shot 2017-12-12 at 9 33 46 pm" src="https://user-images.githubusercontent.com/12462448/36585058-335d982e-1874-11e8-8629-89f4b0732fb3.png">

> The Law Centre worker is then asked to fill in information about their week, this will mostly be numerical questions, such as how many people they have seen. They can select whether they are a lawyer/case worker, in management, or a receptionist. Based on their answer to this question they will be asked different questions tailored to their experiences at work

<img width="410" alt="screen shot 2017-12-12 at 9 34 22 pm" src="https://user-images.githubusercontent.com/12462448/36585060-38176fac-1874-11e8-9384-371d771344c2.png">

> Once the Law Centre worker has filled out the quantitative data about their week, they will get some feedback about how their data is being used and how it relates to the larger context of Law Centre's across the country. They will then be able to choose whether they want to continue to share some of their stories or to log out.

<img width="410" alt="screen shot 2017-12-12 at 9 35 47 pm" src="https://user-images.githubusercontent.com/12462448/36585062-3b0561ce-1874-11e8-8fe5-eaf0cf3451ec.png">

> If they continue the Law Centre worker will be able to share a story about their week. This could be a success they have had, something that has annoyed them or a trend they have spotted. In this section they could also ask questions from the Law Centre

<img width="410" alt="screen shot 2017-12-12 at 9 36 18 pm" src="https://user-images.githubusercontent.com/12462448/36585078-47f68c96-1874-11e8-8576-f274eab833c6.png">

> Again they will be able to log out at this stage or go on to see stories from others at different Law Centres

<img width="410" alt="screen shot 2017-12-12 at 9 36 42 pm" src="https://user-images.githubusercontent.com/12462448/36585082-4e155530-1874-11e8-8704-778e668cedb7.png">

> Here they will be able to read through the stories from other Law Centres. These will be grouped by categories and the latest will be displayed first

<img width="410" alt="screen shot 2017-12-12 at 9 36 55 pm" src="https://user-images.githubusercontent.com/12462448/36585091-54d2510c-1874-11e8-9003-41ea005359b0.png">

> The Law centre worker will be able to reply to any stories that they find interesting

<img width="410" alt="screen shot 2017-12-12 at 9 37 31 pm" src="https://user-images.githubusercontent.com/12462448/36585109-671bc12c-1874-11e8-9eab-98895b75edf2.png">

> Their reply will then be shown at the top of the news feed

<img width="410" alt="screen shot 2017-12-12 at 9 37 44 pm" src="https://user-images.githubusercontent.com/12462448/36585113-6bca59d6-1874-11e8-8eec-7ef220981789.png">

## Further Development :wrench:

### User Testing :two_women_holding_hands::two_women_holding_hands:

User testing allows you to get feedback from your primary users to check that the product being built fits their needs. This is **very** important to build a successful product.

**The three key points for testing are:**

* Have a script which has tasks for them to complete. **[here](https://github.com/InFact-coop/LCN/blob/master/UserTesting.md)** is an example of a script which you can use and modify
* Ask for people to give you a commentary of what they are doing, but don't respond to them
* Document their response

**Additional recommendations for _*your*_ user testing:**

* Ask user to complete the flow and explain what they are thinking throughout the process
  * Make **_lots_** of notes. It is good to have someone guiding the user and someone note taking so nothing is missed!
  * Try and gather if the user understands the purpose of the app and if the interactions are intuitive
  * Try to understand further if the types, quantity and copy of the questions is appropriate for the audience.
  * Does the user feel like this can help make a difference?
* Users may comment on aesthetics **but** unless the same comments are brought up several times these comments are **_usually_** not important. The focus should be on the users interactions and understanding of the product.

Here are some **useful resources** to look at when completing your user testing sessions:

* [Google's Guerrilla Testing Advice](https://www.youtube.com/watch?v=0YL0xoSmyZI&feature=youtu.be)
* [Script Guidance and Template](https://github.com/foundersandcoders/master-reference/blob/master/coursebook/weeks-10-12/user-testing.md#1-planning)
* [Steve Krug user testing script](https://sensible.com/downloads/test-script.pdf)

### Next Sprints :runner:

If this design is move forward for further build sprints it is important to concentrate on key features that both **_solve the initial problem and implement feedback from user testing_**.

Our current recommendations for further sprints would be:

* Implement feedback from user testing
* Implement login functionality
* Extend 'reply-to' comments functionality
* To make the product more mobile friendly
* Improve accessibility - product is currently not useable for people with hearing or visual impairments

> This would be formally decided following the user testing during a sprint planning meeting :+1:
