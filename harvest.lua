function wait()
    --Anytime in seconds you want
    sleep(15)
end
 
--Harvests potato in front of it then drops all the potatos in selected slot except 1.
function dig()
    turtle.dig()
    turtle.suck()
    turtle.place()
    for i = 1,turtle.getItemCount() - 1, 1 do
        turtle.dropDown()
    end
end

--Checks if potato is planted, if so checks if its ready for harvesting
function inspect()
    local booleanValue, potatoInfo = turtle.inspect()
 
    if (not booleanValue) then
        for i = 1, 16, 1 do
            turtle.select(i)
            turtle.getItemDetail(i)
            print(turtle.getItemDetail(i))
            if(turtle.getItemDetail(i) ~= nil) then
                if (turtle.getItemDetail(i).name == "minecraft:potato") then
                    turtle.place()
                    break
                end
            end
        end
        turtle.place()
    else
        if (potatoInfo.state.age == 7) then
            dig()
            next()
        else
            wait()
            inspect()
        end
    end
end
 
--Moves forward and checks next potato, if it detects a block in front of it, turns around and goes back to start
function next()
    turtle.turnLeft()
 
    if (turtle.inspect() == false) then
        turtle.forward()
        turtle.turnRight()
        inspect()
    else
        turtle.turnLeft()
        turtle.turnLeft()
 
        while (turtle.inspect() == false) do
            turtle.forward()
        end
 
        turtle.turnLeft()
        inspect()
    end
end
 
inspect()
