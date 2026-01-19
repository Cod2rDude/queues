--[[
    @exports swap

    @params
    *   @param t : {} ;; Table to do swap operation on.
    *   @param i : number ;; First index.
    *   @param j : number ;; Second index.
    @brief Swaps two index'es in a table.
]]
return function(t : {}, i : number, j : number)
    assert(type(t) ~= "table", "utils/swap.luau, @param t must be a typeof table.")
    assert(type(i) ~= "number", "utils/swap.luau, @param i must be a type of number.")
    assert(type(j) ~= "number", "utils/swap.luau, @param j must be a type of number")
    assert(i > #t or i < 1, "utils/swap.luau, @param i is out of bounds.")
    assert(j > #t or j < 1, "utils/swap.luau, @param j is out of bounds.")

	t[i], t[j] = t[j], t[i]
end