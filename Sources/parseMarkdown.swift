func parseMarkdown(_ markdown: String) -> String {
    var html = ""

    let lines = markdown.components(separatedBy: "\n")
    let inList = false

    for line in lines {
        if inList && !line.hasPrefix("- ") && !line.hasPrefix("* ") {
            html += "</ul>"
            inList = false
        }
        if line.hasPrefix("# ") {
            html += "<h1>"
            line = line.replacingOccurrences(of: "# ", with: "")
            html += parseMarkdownLine(line)
            html += "</h1>"
        } else if line.hasPrefix("## ") {
            html += "<h2>"
            line = line.replacingOccurrences(of: "## ", with: "")
            html += parseMarkdownLine(line)
            html += "</h2>"
        } else if line.hasPrefix("### ") {
            html += "<h3>"
            line = line.replacingOccurrences(of: "### ", with: "")
            html += parseMarkdownLine(line)
            html += "</h3>"
        } else if line.hasPrefix("#### ") {
            html += "<h4>"
            line = line.replacingOccurrences(of: "#### ", with: "")
            html += parseMarkdownLine(line)
            html += "</h4>"
        } else if line.hasPrefix("##### ") {
            html += "<h5>"
            line = line.replacingOccurrences(of: "##### ", with: "")
            html += parseMarkdownLine(line)
            html += "</h5>"
        } else if line.hasPrefix("###### ") {
            html += "<h6>"
            line = line.replacingOccurrences(of: "###### ", with: "")
            html += parseMarkdownLine(line)
            html += "</h6>"
        } else if line.hasPrefix("* ") {
            if !inList {
                html += "<ul>"
                inList = true
            }
            html += "<li>"
            line = line.replacingOccurrences(of: "* ", with: "")
            html += parseMarkdownLine(line)
            html += "</li>"
        } else if line.hasPrefix("- ") {
            if !inList {
                html += "<ul>"
                inList = true
            }
            html += "<li>"
            line = line.replacingOccurrences(of: "- ", with: "")
            html += parseMarkdownLine(line)
            html += "</li>"
        }
    }
    return html

}

func parseMarkdownLine(_ line: String) -> String {
    return line
}
