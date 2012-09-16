namespace :db do

	task :updatedamage => :environment do
		while true
			puts ("Running")
			Argument.all.each do |argument|
				if (Argument.isRunning(argument.id) && argument.started)
					Argument.update(argument.id)
					Argument.markVotes(argument.id)
					puts ("Updated " + argument.topic)
				end
			end
			sleep 20
		end
	end

end