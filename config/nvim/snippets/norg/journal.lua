return {
  s("journal", {
    f(function()
      local filename = vim.fn.expand("%")
      local year, month, day = filename:match("(%d%d%d%d)-(%d%d)-(%d%d).norg")
      local timestamp

      if year == nil or month == nil or day == nil then
       timestamp = nil
      else
       timestamp = os.time({
        year = year,
        month = month,
        day = day
       })
      end

      local suffix = "th"
      if day == "1" or day == "21" or day == "31" then suffix = "st"
      elseif day == "2" or day == "22" then suffix = "nd"
      elseif day == "3" or day == "23" then suffix = "rd"
      end


      return os.date("* %A, %b %d" .. suffix .. ", %Y", timestamp)
     end),
     t({ "", "** {:$/todo:}[TODO]", "** Notes", "  - "}),
    }),
   }
