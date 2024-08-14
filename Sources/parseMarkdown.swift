func parseMarkdown(_ markdown: String) -> String {
    var html = ""

    let lines = markdown.components(separatedBy: "\n")
    var inList = false

    for line in lines {
        if inList && !line.hasPrefix("- ") && !line.hasPrefix("* ") {
            html += "</ul>"
            inList = false
        }
        if line.hasPrefix("# ") {
            html += "<h1>"
            let lline = line.replacingOccurrences(of: "# ", with: "")
            html += parseMarkdownLine(lline)
            html += "</h1>"
        } else if line.hasPrefix("## ") {
            html += "<h2>"
            let lline = line.replacingOccurrences(of: "## ", with: "")
            html += parseMarkdownLine(lline)
            html += "</h2>"
        } else if line.hasPrefix("### ") {
            html += "<h3>"
            let lline = line.replacingOccurrences(of: "### ", with: "")
            html += parseMarkdownLine(lline)
            html += "</h3>"
        } else if line.hasPrefix("#### ") {
            html += "<h4>"
            let lline = line.replacingOccurrences(of: "#### ", with: "")
            html += parseMarkdownLine(lline)
            html += "</h4>"
        } else if line.hasPrefix("##### ") {
            html += "<h5>"
            let lline = line.replacingOccurrences(of: "##### ", with: "")
            html += parseMarkdownLine(lline)
            html += "</h5>"
        } else if line.hasPrefix("###### ") {
            html += "<h6>"
            let lline = line.replacingOccurrences(of: "###### ", with: "")
            html += parseMarkdownLine(lline)
            html += "</h6>"
        } else if line.hasPrefix("* ") {
            if !inList {
                html += "<ul>"
                inList = true
            }
            html += "<li>"
            let lline = line.replacingOccurrences(of: "* ", with: "")
            html += parseMarkdownLine(lline)
            html += "</li>"
        } else if line.hasPrefix("- ") {
            if !inList {
                html += "<ul>"
                inList = true
            }
            html += "<li>"
            let lline = line.replacingOccurrences(of: "- ", with: "")
            html += parseMarkdownLine(lline)
            html += "</li>"
        }
    }
    return html

}

enum MarkdownOperator{
    case bold
    case italic
    case underline
    case strikethrough
    //case code

    var info: (md: String, tag: String) {
        switch self {
            case .bold:
                return("**", "b")
            case .italic:
                return("*", "i")
            case .underline:
                return("__", "u")
            case .strikethrough:
                return("~~", "s")
            //case .code:
            //return("`", "code")
        }
    }
}

func parseMarkdownLine(_ line: String) -> String {
    var lline = line
    let dict = [MarkdownOperator.bold: false, MarkdownOperator.italic: false, MarkdownOperator.underline: false, MarkdownOperator.strikethrough: false]
    for i in lline.indices {
        for op in MarkdownOperator.allCases {
            let (md, tag) = op.info
            if(md.count > 1) {
                if lline[i] + lline[lline.index(after: i)] == md {
                    lline.remove(at: lline.index(after: i))
                    lline.remove(at: i)
                    lline.insert(contentsOf: "<" + (dict[op] ? "/" : "") + tag + ">", at: i)
                    dict[op] = !dict[op]
                }
            } else {
                if lline[i] == md {
                    lline.remove(at: i)
                    lline.insert(contentsOf: "<" + (dict[op] ? "/" : "") + tag + ">", at: i)
                    dict[op] = !dict[op]
                }
            }
        }
    }
    
    return lline
}
