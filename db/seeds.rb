user1 = User.create(username: "Mom")
user2 = User.create(username: "Dad")
user3 = User.create(username: "Son")
user4 = User.create(username: "Daughter")

task1 = Task.create(title: "Dishes")
task2 = Task.create(title: "Shopping")
task3 = Task.create(title: "Laundry")


subtask1_1 = Subtask.create(title: "Load Dishwasher")
subtask1_2 = Subtask.create(title: "Unload Dishwasher")

subtask3_1 = Subtask.create(title: "Load washer")
subtask3_2 = Subtask.create(title: "Load dryer")
subtask3_3 = Subtask.create(title: "Put away laundry")
