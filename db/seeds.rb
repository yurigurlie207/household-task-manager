#seed data for testing
#use commented out data to test app

#CREATE USERS
user1 = User.create(username: "Mom")
#User.create(username: "Dad")
user2 = User.create(username: "Son")
user3 = User.create(username: "Daughter")


#CREATE TASKS and SUBTASKS
Task.create(title: "Dishes")
Task.create(title: "Shopping")
Task.create(title: "Laundry")


subtask1_1 = Subtask.create(title: "Load Dishwasher")
subtask1_2 = Subtask.create(title: "Unload Dishwasher")
subtask2_1 = Subtask.create(title: "Shopping")
subtask3_1 = Subtask.create(title: "Load washer")
subtask3_2 = Subtask.create(title: "Load dryer")
subtask3_3 = Subtask.create(title: "Put away laundry")

usertask1 = UserTask.create()
