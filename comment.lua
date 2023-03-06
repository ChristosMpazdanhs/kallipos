function Image(img)
  if img.classes:find('comment', 1) then
    local f = io.open("comment/" .. img.src, 'r')
    local doc = pandoc.read(f:read('*all'))
    f:close()

    local caption = pandoc.utils.stringify(doc.meta.caption) or "Epigraph has not been set"
    local student = pandoc.utils.stringify(doc.meta.student) or "Student has not been set"
    local studentid = pandoc.utils.stringify(doc.meta.studentid) or "Student ID has not been set"
    local credentials = pandoc.List({
      pandoc.Str("Student: "),
      pandoc.Emph(student),
      pandoc.Str(" ("),
      pandoc.Strong(studentid),
      pandoc.Str(")")
    })
    local tag = "> _" .. caption .. "_\n\n" .. pandoc.utils.stringify(credentials)

    local inline = pandoc.RawInline('markdown', tag)
    local span = pandoc.Span(inline)

    return span
  end
end