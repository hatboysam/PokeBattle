task :updatedamage do
	
	Argument.each do |argument|
		if (Argument.isRunning(argument.id) && argument.started)
			Argument.update(argument.id)
			Argument.markVotes(argument.id)
			puts ("Updated " + argument.topic)
		end
	end

end