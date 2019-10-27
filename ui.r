shinyUI(
  dashboardPage(
    dashboardHeader(title = "US Unemployment Rate"),
    dashboardSidebar(
      sidebarUserPanel(name = "By Haining Fu"),
                       # image = "Pacman",
      sidebarMenu(
        menuItem("Home",tabName = "home", icon = icon("home")),
        menuItem("Data",tabName = "data", icon = icon("database")),
        menuItem("Map",tabName = "map",icon = icon("map")),
        menuItem("Graphs", tabName = "graphs", icon = icon("chart-bar")),
        selectizeInput(inputId = "year", label = "Select Year", choice = choice))
    ),
    dashboardBody(
      tabItems(
        tabItem(tabName = "home",
                fluidRow(box(title = "US Unemployment Rate by Counties",width = 12)),
                fluidRow(box(title = "About",
                             footer = HTML("Early each month, the Bureau of Labor Statistics (BLS) of the U.S. Department of Labor announces
                                            the total number of employed and unemployed people in the United States for the previous month, 
                                            along with many characteristics about them. My prject will focus on the unemploymemt rate by counties
                                            in US from year 2000 to 2018."), width=12,
                             collapsible = TRUE, status = 'primary'))),
        tabItem(tabName = "data",
                fluidRow(box(DT::dataTableOutput("table"), width = 12))),
        tabItem(tabName = "map",
                fluidRow(box(title = "US counties Map")),
                leafletOutput('map'),
         
                fluidRow(box(htmlOutput("map"), width = 12)
                )),
        tabItem(tabName = "graphs",
                box(width = "100%" , height = "100%", solidHeader = FALSE, status = "primary"),
                fluidRow(column(width=5, selectizeInput('county1', label="Select county 1", choices=sort(unique(unemployment$Region_Name)))),
                         column(width=5, selectizeInput('county2', label="Select county 2", choices=sort(unique(unemployment$Region_Name))))),
                fluidRow(column(10, plotOutput("plot1"))),
        )
      )
    )
  )
)
