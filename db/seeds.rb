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
load_dishes.save
unload_dishes.save


shopping = Task.create(title: "Shopping")
shopping_sub = Subtask.create(title: "Shopping")
shopping_sub.task = shopping
shopping_sub.save

laundry = Task.create(title: "Laundry")
load_laundry = Subtask.create(title: "Load washer")
load_dryer = Subtask.create(title: "Load dryer")
put_away_laundry = Subtask.create(title: "Put away laundry")
load_laundry.task = laundry
load_dryer.task = laundry
put_away_laundry.task = laundry
put_away_laundry.save
load_laundry.save
load_dryer.save

cat = Task.create(title: "Cat Care")
feed_cat = Subtask.create(title: "Feed Cat")
clean_litter = Subtask.create(title: "Clean Litter Box")
feed_cat.task = cat
feed_cat.save
clean_litter.task = cat
clean_litter.save

mop = Task.create(title: "Mop")
mop_sub = Subtask.create(title: "Mop")
mop_sub.task = mop
mop_sub.save

trash = Task.create(title: "Trash")
take_out_trash = Subtask.create(title: "Take Out Trash")
trash_day = Subtask.create(title: "Weekly Trash Day")
take_out_trash.task = trash
take_out_trash.save
trash_day.task = trash
trash_day.save


#user_ids: 1:mom, 2:dad, 3:son, 4:daughter
#Mom and Son are assigned to laundry duty with mom loading and putting in dryer,
#and son and daughter putting it away
#4 separate rows in the user task table
load_laundry.user_ids = [1]
load_laundry.save

load_dryer.user_ids = [1]
load_dryer.save

put_away_laundry.user_ids = [3,4]
put_away_laundry.save


#Dad and son assigned mop
mop_sub.user_ids = [2,3]
mop_sub.save
