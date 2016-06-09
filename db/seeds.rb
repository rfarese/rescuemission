User.create(provider: 'twitter', uid: "123456", name: "Bobby Farese", token: "12345", secret: "bobbysecret", profile_image: "http://avatars.jurko.net/uploads/avatar_21517.jpg")
User.create(provider: 'twitter', uid: "654321", name: "Sarah Farese", token: "54321", secret: "sarahsecret", profile_image: "http://img1.jurko.net/avatar_5914.png")
User.create(provider: 'twitter', uid: "165243", name: "Trey Farese", token: "15432", secret: "treysecret", profile_image: "http://img1.jurko.net/Godfather-Avatar2.gif")
User.create(provider: 'twitter', uid: "342561", name: "Declan Farese", token: "23451", secret: "declansecret", profile_image: "http://img1.jurko.net/avatar_8755.jpg")

Question.create(user_id: 6,
                title: "What is the proper way to cook Chicken breasts?",
                description: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")
Question.create(user_id: 7,
                title: "What is the best way for me to get to Thomas Land?",
                description: "Trying to get to Thomas Land when you are only 3 yrs old can be tough.  Should I ask my parents to drive me?  Or perhaps my grandpa?  Am I too hung to try and hitch hike there?")
Question.create(user_id: 8,
                title: "How do I get my older brother to stop taking all my toys all the time?",
                description: "Because I am not even 2 yrs old yet, my older brother is a lot stronger than I am and is always taking my toys.  Is there any way I can stop his seeminly unstoppable toy confiscating abilities?")


Answer.create(question_id: 7, user_id: 8, description: "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven.")
Answer.create(question_id: 8, user_id: 5, description: "First of all, yes!  You are way too young to be hitch hiking!  My opinion might be bias because I am your father, but you should just ask myself or your mother and we'll decide if you can go or not.")
Answer.create(question_id: 9, user_id: 7, description: "This is TREY speaking!  Your older brother!  You will never stop me!  I'm too smart!  Too cunning!  And too devastagtingly handsome to ever have my toy stealing endeavors ever foiled by the likes of you!")
