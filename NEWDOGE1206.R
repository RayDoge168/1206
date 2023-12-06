DOGE
URL = "https://reg.ntuh.gov.tw/EmgInfoBoard/NTUHEmgInfo.aspx"

txt = scan(URL, what = "character", encoding = "UTF-8", quiet = TRUE)

head(txt, 15)
txt_new = paste(txt, sep = "", collapse = " ")
TITLE.pos = gregexpr("<title>.*</title>", txt_new)
start.TITLE.pos = TITLE.pos[[1]][1]
end.TITLE.pos = start.TITLE.pos + attr(TITLE.pos[[1]], "match.length")[1] - 1

TITLE.word = substr(txt_new, start.TITLE.pos, end.TITLE.pos)

TITLE.word

TITLE.word = gsub("<title>", "", TITLE.word)
TITLE.word = gsub("</title>", "", TITLE.word)
TITLE.word

start.pos = gregexpr("<tr>", txt_new)
end.pos = gregexpr("</tr>", txt_new)

i = 1
sub.start.pos = start.pos[[1]][i]
sub.end.pos = end.pos[[1]][i] + attr(end.pos[[1]], "match.length")[i] - 1

sub_txt = substr(txt_new, sub.start.pos, sub.end.pos)
sub_txt

NTU_info = function () {
  
  result = data.frame(item = c('单本腹计', '单禘计', '单皘计', '单ICU计', '单崩计'),
                      info = NA,
                      stringsAsFactors = FALSE)
  
  URL = "https://reg.ntuh.gov.tw/EmgInfoBoard/NTUHEmgInfo.aspx"
  
  txt = scan(URL, what = "character", encoding = "UTF-8", quiet = TRUE)
  txt_new = paste(txt, sep = "", collapse = " ")
  
  start.pos = gregexpr("<tr>", txt_new)
  end.pos = gregexpr("</tr>", txt_new)
  
  for (i in 1:5) {
    
    sub.start.pos = start.pos[[1]][i]
    sub.end.pos = end.pos[[1]][i] + attr(end.pos[[1]], "match.length")[i] - 1
    
    sub_txt = substr(txt_new, sub.start.pos, sub.end.pos)
    sub_txt = gsub('单.*', '', sub_txt)
    sub_txt = gsub('</?tr>', '', sub_txt)
    sub_txt = gsub('</?td>', '', sub_txt)
    result[i,'info'] = gsub(' ', '', sub_txt)
    
  }
  
  result
  
}

NTU_info()


library(rvest)

URL = "https://reg.ntuh.gov.tw/EmgInfoBoard/NTUHEmgInfo.aspx"

website = read_html(URL)

needed_txt = website %>% html_nodes("tr") %>% html_text()
needed_txt

URL = "https://www.ptt.cc/bbs/AllTogether/index3245.html"
website = read_html(URL)

needed_html = website %>% html_nodes("a")
needed_html

needed_txt = needed_html %>% html_text()
needed_txt

intrested_pos = grep("[紉]", needed_txt, fixed = TRUE)
needed_txt[intrested_pos]

needed_link = needed_html[intrested_pos] %>% html_attr("href")

