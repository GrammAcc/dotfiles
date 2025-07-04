M = {}

M.index = function(array, value)
  for i, v in ipairs(array) do
    if v == value then
      return i
    end
  end
  return nil
end


-- Adapted from: http://lua-users.org/wiki/SplitJoin
M.split = function(str, separator, limit)
  assert(separator ~= '')
  assert(limit == nil or limit >= 1)

  local results = {}

  if str:len() > 0 then
    limit = limit or -1

    local split_idx, sub_idx = 1, 1
    local first_idx, last_idx = str:find(separator, sub_idx, true)
    while first_idx and limit ~= 0 do
      results[split_idx] = str:sub(sub_idx, first_idx - 1)
      split_idx = split_idx + 1
      sub_idx = last_idx + 1
      first_idx, last_idx = str:find(separator, sub_idx, true)
      limit = limit - 1
    end
    results[split_idx] = str:sub(sub_idx)
  end

  return results
end


M.swap = function(arr, idx1, idx2)
  if idx1 <= 0 or idx2 <= 0 or idx1 > #arr or idx2 > #arr then
    -- Index is out of range
    return arr
  end

  arr[idx1], arr[idx2] = arr[idx2], arr[idx1]
  return arr
end

return M
