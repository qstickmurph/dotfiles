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
    t({ "", "** Notes"}),
  }),
  s("standup", {
    t({
      "*** Standup",
      "*Yesterday:*",
      "- ",
      "",
      "*Today:*",
      "- ",
      "",
      "*Needs/Blocks:*",
      "- None"
    })
  }),
  s("planning", {
    t({ "*** Planning"}),
    t({ "", "- Total: "}), i(1, "30"),
    t({ "", "- Todo: "}), i(2, "0"),
    t({ "", "- In-flight: "}), i(3, "0"),
    t({ "", "- New: "}), i(4, "0"),
  }),
}
