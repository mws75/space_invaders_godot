extends Timer
signal BossTime

var decrease_amount = 0.5
var minimum_time = 0.5
var decrease_interval = 3 # seconds
var frames_per_decrease_interval = 60 * decrease_interval # assuming 60 FPS
var frame_count = 0
var max_loops = 3
var current_loops = 0 
# Called every physics frame. 'delta' is the elapsed time since the previous physics frame.
func _physics_process(delta):
	frame_count += 1
	if current_loops == max_loops: 
		BossTime.emit()
	if frame_count >= frames_per_decrease_interval:
		print("spon time decreased")
		frame_count = 0
		if self.wait_time > minimum_time:
			self.wait_time -= decrease_amount
			if self.wait_time < minimum_time:
				self.wait_time = minimum_time
		else: 
			print("hit min spon time")
			current_loops += 1
			self.wait_time = 3
			print("set wait_time back to: ", 3)
			

# This function will be called every time the Timer times out
func _on_Timer_timeout():
	pass # Add your code here
