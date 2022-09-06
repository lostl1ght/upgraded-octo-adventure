return {
  s(
    'function',
    fmt(
      [[
      function {}({})
        {}
      end
      ]],
      { i(1), i(2), i(3) }
    )
  ),
  s(
    'for',
    fmt(
      [[
      for {} in ipairs({}) do
        {}
      end
      ]],
      { i(1, 'i'), i(2, 't'), i(3) }
    )
  ),
  s(
    'if',
    fmt(
      [[
      if {} then
        {}
      end
      ]],
      { i(1, 'e'), i(2) }
    )
  ),
  s(
    'then',
    fmt(
      [[
    then
      {}
    end
    ]],
      { i(1) }
    )
  ),
  s(
    'do',
    fmt(
      [[
    do
      {}
    end
    ]],
      { i(1) }
    )
  ),
}
