--[[
    @exports swapAndPop

    @params
    *   @param t : {} ;; Table to pop from.
    *   @param i : number ;; Item to pop.
    @brief Replaces t[i] with t[#t] and pops t[#t]. Essentialy removing item at t[i] at start.
]]
return function(t : {}, i : number) : any?
    assert(type(t) ~= "table", "utils/swap.luau, @param t must be a typeof table.")
    assert(type(i) ~= "number", "utils/swap.luau, @param i must be a type of number.")
    assert(i > #t or i < 1, "utils/swap.luau, @param i is out of bounds.")

    t[i], t[#t] = t[#t], t[i]
	return table.remove(t)
end