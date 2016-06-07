# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# user.id = 2
User.create(username: "sarah_farese")

# user.id = 3
User.create(username: "trey_farese")

# user.id = 4
User.create(username: "declan_farese")

# question.id = 3
Question.create(user_id: 2,
                title: "What is the proper way to cook Chicken breasts?",
                description: "I wasn't sure if I should defrost the chicken first or not.  If I should cook it in a pan on the stove or in a glass dish in the oven. Or if I should use any spices or not.")

# question.id = 4
Question.create(user_id: 3,
                title: "What is the best way for me to get to Thomas Land?",
                description: "Trying to get to Thomas Land when you are only 3 yrs old can be tough.  Should I ask my parents to drive me?  Or perhaps my grandpa?  Am I too hung to try and hitch hike there?")

# question.id = 5
Question.create(user_id: 4,
                title: "How do I get my older brother to stop taking all my toys all the time?",
                description: "Because I am not even 2 yrs old yet, my older brother is a lot stronger than I am and is always taking my toys.  Is there any way I can stop his seeminly unstoppable toy confiscating abilities?")


Answer.create(question_id: 3, user_id: 4, description: "Well, considering you are my mother and I really like chicken fingers, I think that you should cut them up into long thin pieces.  Roll them in bread crumbs and cook them in the oven.")
Answer.create(question_id: 4, user_id: 1, description: "First of all, yes!  You are way too young to be hitch hiking!  My opinion might be bias because I am your father, but you should just ask myself or your mother and we'll decide if you can go or not.")
Answer.create(question_id: 5, user_id: 3, description: "This is TREY speaking!  Your older brother!  You will never stop me!  I'm too smart!  Too cunning!  And too devastagtingly handsome to ever have my toy stealing endeavors ever foiled by the likes of you!")
