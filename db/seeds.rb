#seed data for testing
#use commented out data to test app

#CREATE USERS
user1 = User.create(username: "Mom")
#User.create(username: "Dad")
user2 = User.create(username: "Son")
user3 = User.create(username: "Daughter")


#CREATE TASKS and SUBTASKS
task1 = Task.create(title: "Dishes")
subtask1_1 = Subtask.create(title: "Load Dishwasher")
subtask1_2 = Subtask.create(title: "Unload Dishwasher")



task2 = Task.create(title: "Shopping")
subtask2_1 = Subtask.create(title: "Shopping")


task3 = Task.create(title: "Laundry")
subtask3_1 = Subtask.create(title: "Load washer")
subtask3_2 = Subtask.create(title: "Load dryer")
subtask3_3 = Subtask.create(title: "Put away laundry")



#CREATE USER SUBTASK ASSIGNMENTS
usertask1 = UserTask.create()
usertask2 = UserTask.create()
usertask3 = UserTask.create()
