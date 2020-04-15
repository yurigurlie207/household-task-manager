#CREATE TASKS and SUBTASKS
dishes = Task.create(title: "Dishes", complete: false)
load_dishes = Subtask.create(title: "Load Dishwasher", complete: false)
unload_dishes = Subtask.create(title: "Unload Dishwasher", complete: false)
load_dishes.task = dishes
unload_dishes.task = dishes
load_dishes.save
unload_dishes.save


shopping = Task.create(title: "Shopping", complete: false)
shopping_sub = Subtask.create(title: "Shopping", complete: false)
shopping_sub.task = shopping
shopping_sub.save

laundry = Task.create(title: "Laundry", complete: false)
load_laundry = Subtask.create(title: "Load washer", complete: false)
load_dryer = Subtask.create(title: "Load dryer", complete: false)
put_away_laundry = Subtask.create(title: "Put away laundry", complete: false)
load_laundry.task = laundry
load_dryer.task = laundry
put_away_laundry.task = laundry
put_away_laundry.save
load_laundry.save
load_dryer.save

cat = Task.create(title: "Cat Care", complete: false)
feed_cat = Subtask.create(title: "Feed Cat", complete: false)
clean_litter = Subtask.create(title: "Clean Litter Box", complete: false)
feed_cat.task = cat
feed_cat.save
clean_litter.task = cat
clean_litter.save

mop = Task.create(title: "Mop", complete: false)
mop.no_subtask = 1
mop.save
mop_sub = Subtask.create(title: "Mop", complete: false)
mop_sub.task = mop
mop_sub.save

trash = Task.create(title: "Trash", complete: false)
take_out_trash = Subtask.create(title: "Take Out Trash", complete: false)
trash_day = Subtask.create(title: "Weekly Trash Day", complete: false)
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
