;; extends
(
    (comment) @htmlComment
    (#eq? @htmlComment "/*html*/")
    .
    (template_string (string_fragment) @injection.content)
    (#set! injection.language "html")
)
