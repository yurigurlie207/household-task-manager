#seed data for testing
#use commented out data to test app

#CREATE USERS
mom = User.create(username: "Mom")
dad = User.create(username: "Dad")
son = User.create(username: "Son")
daughter = User.create(username: "Daughter")


#CREATE TASKS and SUBTASKS
dishes = Task.create(title: "Dishes")
load_dishes = Subtask.create(title: "Load Dishwasher")
unload_dishes = Subtask.create(title: "Unload Dishwasher")
load_dishes.task = dishes
unload_dishes.task = dishes


shopping = Task.create(title: "Shopping")
shopping_sub = Subtask.create(title: "Shopping")
shopping_sub.task = shopping

laundry = Task.create(title: "Laundry")
load_laundry = Subtask.create(title: "Load washer")
load_dryer = Subtask.create(title: "Load dryer")
put_away_laundry = Subtask.create(title: "Put away laundry")
load_laundry.task = laundry
load_dryer.task = laundry
put_away_laundry.task = laundry

cat = Task.create(title: "Cat Care")
feed_cat = Subtask.create(title: "Feed Cat")
clean_litter = Subtask.create(title: "Clean Litter Box")
feed_cat.task = cat
clean_litter.task = cat

mop = Task.create(title: "Mop")
mop_sub = Subtask.create(title: "Mop")
mop_sub.task = mop

trash = Task.create(title: "Trash")
take_out_trash = Subtask.create(title: "Take Out Trash")
trash_day = Subtask.create(title: "Weekly Trash Day")
take_out_trash.task = trash
trash_day.task = trash


#CREATE USER SUBTASK ASSIGNMENTS
usertask1 = UserTask.create()
usertask2 = UserTask.create()
usertask4 = UserTask.create()
usertask5 = UserTask.create()
usertask6 = UserTask.create()
usertask7 = UserTask.create()
usertask8 = UserTask.create()
usertask9 = UserTask.create()
usertask10 = UserTask.create()


#Mom and Son are assigned to laundry duty with mom loading and putting in dryer, and son putting it away
usertask1.user = user1
usertask1.subtask =
