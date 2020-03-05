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
subtask1_1.task = task1
subtask1_2.task = task1


task2 = Task.create(title: "Shopping")
subtask2_1 = Subtask.create(title: "Shopping")
subtask2_1.task = task2

task3 = Task.create(title: "Laundry")
subtask3_1 = Subtask.create(title: "Load washer")
subtask3_2 = Subtask.create(title: "Load dryer")
subtask3_3 = Subtask.create(title: "Put away laundry")
subtask3_1.task = task3
subtask3_2.task = task3
subtask3_3.task = task3

task4 = Task.create(title: "Cat Care")
subtask4_1 = Subtask.create(title: "Feed Cat")
subtask4_2 = Subtask.create(title: "Clean Litter Box")
subtask4_1.task = task4
subtask4_2.task = task4

task5 = Task.create(title: "Mop")
subtask5_1 = Subtask.create(title: "Mop")
subtask5_1.task = task5

task6 = Task.create(title: "Trash")
subtask6_1 = Subtask.create(title: "Take Out Trash")
subtask6_2 = Subtask.create(title: "Weekly Trash Day")
subtask6_1.task = task6
subtask6_2.task = task6




#CREATE USER SUBTASK ASSIGNMENTS
usertask1 = UserTask.create()
usertask2 = UserTask.create()
usertask3 = UserTask.create()
