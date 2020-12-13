time, ids = File.read('./data.txt').split

time = time.to_i
ids = ids.split(',')

bus_ids = ids.select{|id|id != 'x'}.map(&:to_i)

times = bus_ids.map{|id| (time..time+id).find{|actual_time| actual_time % id == 0 }}

bus_index = times.rindex(times.min)
p (times[bus_index] - time) * bus_ids[bus_index]
