#' plot
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#'@import ggplot2
#'
#' @noRd

# this script contains all the code for creating plots/tables for the app including their aesthetics

########################### Plot Aesthetics ###########################

# see data_processing.R scipt where they are made
# then stored in sysdata.R file
# ex: pal[], line_ty, line_col,

############################### lolipop chart  ##################################

# this function creates lollipop charts that are used on the "Overview" page

lollipop_func <- function(data, year1, range1, range2, upper_lim) {

  data <- subset(data, !production_activity %in% c('All production', 'Groundfish production', 'Non-whiting groundfish', 'Other species production'))
  # range label for the graph legend
  # if year range is the same (e.g. 2020-2020 avg., then making it show just 2020)
  range_label <- if (range1 != range2) {
    paste0(range1, "-", range2, " avg.")
  } else {
    range2
  }

  # factor the year so year 1 always shows up first and same color on graph
  data$year <- factor(
    data$year,
    levels = unique(c(range_label, as.character(year1)))
  )

  # ggplot graph code
  ggplot2::ggplot(
    data = data,
    ggplot2::aes(
      x = .data[["value"]],
      y = .data[["production_activity"]],
      group = .data[["production_activity"]],
      color = factor(.data[["year"]])
    )
  ) +
    # Draw segments connecting the two years for each production_activity
    ggplot2::geom_line(
      aes(group = .data[["production_activity"]]),
      color = pal[["value2"]],
      linewidth = 1
    ) +

    # Add points for each year
    ggplot2::geom_point(size = 5) +

    ggplot2::labs(color = "Year", x = "", y = "") +

    ggplot2::scale_color_manual(
      values = stats::setNames(
        c(pal[["light_text"]], pal[["dark_text"]]),
        c(as.character(year1), range_label)
      )
    ) +

    ggplot2::scale_x_continuous(limits = c(0, upper_lim)) +

    ggplot2::theme(
      panel.background = ggplot2::element_rect(
        fill = pal[["bg_plot"]],
        color = pal[["bg_plot"]]
      ),
      plot.background = ggplot2::element_rect(
        fill = pal[["bg_plot"]],
        color = pal[["bg_plot"]]
      ),
      axis.line.x = ggplot2::element_blank(),
      axis.line.y = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_text(
        color = pal["value1"],
        size = 18,
        hjust = 1,
        margin = margin(-10, -20, -50, 0)
      ),
      axis.text.x = ggplot2::element_text(
        color = pal["value1"],
        size = 18
      ),
      axis.ticks = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_line(color = pal[["value2"]]),
      panel.grid.major.y = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),

      # legend
      legend.position = "bottom",
      legend.direction = "horizontal",
      legend.title = ggplot2::element_blank(),
      legend.text = element_text(size = 18, color = pal["value1"]),
      legend.background = element_rect(fill = pal[["bg_plot"]], color = NA),
      legend.box.background = element_rect(fill = pal[["bg_plot"]], color = NA)
    )
}


############################## Heat Map ##################################

heat_func <- function() {
ggplot2::ggplot(coverage, aes(x = as.factor(YEAR),
                           y = EDCSPID, fill = perc_edc)) +
    ggplot2::geom_tile(color = pal[["bg_plot"]]) +
  coord_fixed() +
  theme_minimal() +

  scale_fill_gradient(
    low = pal[["bg_plot"]], high = pal[["value1"]],  # reverse color direction (red = high values)
    na.value = "tan",
    labels = scales::percent
  ) +

  guides(fill = guide_colourbar(barheight = 10,
                                barwidth = .5,
                                theme = theme(legend.direction = "vertical"))) +

  theme(

    plot.title = element_text(
      hjust = 0.5,        # Center the title
      face = "bold",      # Make it bold
      size = 20,          # Optional: control font size
      color = pal[["value1"]]  # Optional: match your existing color theme
    ),
    axis.text = element_text(size = 18, color = pal["value1"]),
    axis.text.x = element_text(angle = 80, vjust = -.4, hjust = -.4),
    text = element_text(size = 18, color = pal["value1"]),
    legend.text = element_text(size = 18, color = pal["value1"]),
    panel.background = ggplot2::element_rect(
      fill = pal[["bg_plot"]],
      color = pal[["bg_plot"]]
    ),
    plot.background = ggplot2::element_rect(
      fill = pal[["bg_plot"]],
      color = pal[["bg_plot"]])) +

  labs(x = NULL, y = NULL, fill = NULL,
       title = "% of total West Coast landings by weight\ncaptured on EDC first-receiver forms")
}


############################## Line Graph ##################################

# this function creates line graphs that are used in the "Plot" tab on the "Explore the Data" page

plot_func <- function(data, lab, group, facet, line = "solid", title = NULL) {
  # return nothing if plot is Null
  validate(
    need(data, "No data available for these selected inputs"),
    need(
      nrow(data) > 0,
      "No data available for these selected inputs"
    )
  )

  # ggplot code
  ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = factor(.data[["year"]]),
      y = .data[["value"]],
      group = .data[[group]]
    )
  ) +
    geom_point(aes(color = .data[[group]]), size = 4) +
    geom_line(
      aes(
        color = .data[[group]],
        linetype = .data[[group]]
      ),
      linewidth = 0.75
    ) +
    # scale_fill_manual(values = line_col) +
    scale_color_manual(values = line_col) +
    scale_linetype_manual(values = line_ty) +
    theme_minimal() +
    labs(
      y = lab,
      x = "Year",
      title = title
    ) +
    scale_x_discrete(breaks = scales::pretty_breaks()) +
    scale_y_continuous(breaks = scales::pretty_breaks(), limits = c(0, NA)) +
    theme(
      text = element_text(size = 22, color = pal["value1"]),
      axis.text = element_text(size = 18, color = pal["value1"]),
      strip.text = element_text(size = 18, color = pal["value1"]),
      legend.text = element_text(color = pal["value1"]),
      legend.title = element_blank(),
      legend.position = "bottom", # Moves the legend to the bottom
      panel.grid.minor.y = element_blank(),
      panel.grid.major.y = element_line(linewidth = 1.2),
      panel.grid.minor.x = element_blank(),
      panel.grid.major.x = element_line(linewidth = 1.2),
      axis.line = element_line(color = "grey", linewidth = 1), # Adds borders to only x and y axes
      panel.background = ggplot2::element_rect(
        fill = pal[["bg_plot"]],
        color = pal[["bg_plot"]]
      ),
      plot.background = ggplot2::element_rect(
        fill = pal[["bg_plot"]],
        color = pal[["bg_plot"]]
      ),
      panel.spacing = unit(1, "cm", data = NULL) # facet spacing
    ) +
    # facet wrap based on the column specified to be faceted in the function
    ggplot2::facet_wrap(
      stats::as.formula(base::paste("~", facet)),
      scales = 'free_y',
      ncol = 2
    )
}

############################## Data Table render processing ##################################

# function for cleaning up data frame to be rendered under the "Table" panel of "Explore the Data" page
process_df <- function(df, cs) {
  # list of columns to remove that are not needed
  cols_to_remove <- c(
    "defl"
  )

  df |>
    # remove cols if they exist
    dplyr::select(-dplyr::any_of(cols_to_remove)) |> # remove cols if they exist
    dplyr::mutate(
      metric = ifelse(
        grepl('weight', metric) | grepl('value', metric),
        paste0('Total ', metric),
        metric
      )
    ) |>
    # round numbers
    dplyr::mutate(
      value = dplyr::case_when(
        unit == 'millions' ~ round(value * 1e6),
        unit == 'thousands' ~ round(value * 1e3),
        T ~ round(value, 2)
      ),
      .keep = 'unused'
    ) |>
    tidyr::pivot_wider(names_from = 'metric', values_from = 'value') |>
    dplyr::rename_with(
      ~ dplyr::case_when(
        . == "year" ~ "Year",
        . == "value" ~ "Value",
        . == "type" ~ "Product type",
        . == "metric" ~ "Metric",
        T ~ .
      )
    ) |>
    dplyr::mutate(
      Year = as.character(Year)) |>
    dplyr::rename(`Number of buyers` = number_of_buyers,
                  `Number of processors` = number_of_processors) |>
    dplyr::mutate(dplyr::across(
      !contains('Number'),
      function(x)
        ifelse(
          x > 100,
          formatC(x, big.mark = ',', format = 'f', digits = 0),
          formatC(x, format = 'f', digits = 2)
        )
    )) |>
    dplyr::arrange(desc(Year)) |>
    dplyr::mutate(dplyr::across(contains('value'), function(x) paste0('$', x))) |>
    dplyr::mutate(dplyr::across(contains('price'), function(x) paste0('$', x)))
}
