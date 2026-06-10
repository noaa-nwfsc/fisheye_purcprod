prep_data_fun <- function(date_stamp) {
    #NOTE: Run this to load data
    # Need to update the date of the folder to retrieve data from

    # this script processes the raw data stored in the G Drive
    # and then reprocesses it into R/sysdata.rda

    # - overview (overview page data)
    # - met_prac, met_reg, met_size (metric tab data)
    # - prod_prac, prod_reg, prod_size (product type tab)
    # - specs_prod, specs_reg, specs_size (species data)
    # - gdp_defl (GDP deflator value data)
    # - coverage (EDC coverage rate data)
    # - clean_purcprod (All purchase production app data)

    # Folder where outputs from fisheyedataprep is saved
    dir_base <- file.path(
        "G:",
        "Shared drives",
        "NMFS NWC FRAM EDC CE (contains MSA Confidential Data)",
        "FISHEyE",
        "data",
        "PurchaseProduction"
    )

    # load the new data into workspace so that it can be converted into sysdata.rda
    load(
        file.path(
            dir_base,
            date_stamp,
            "purcprod_data.RData"
        )
    )
    ########################### Plot aesthetics #################################

    # color pallete
    pal <- c(
        light_text = "#0085CA",
        dark_text = "#003087",
        value1 = "#005E5E",
        value2 = "#C2D9E3",
        value3 = "#5EB6D9",
        value4 = "#90DFE3",
        bg_plot = "#E9F3F6"
    )

    # line colors
    line_col <- c(
        # species colors
        "All production" = "black",
        "Groundfish production" = "#4B0055",
        "Pacific whiting" = "#411A66",
        "Non-whiting groundfish" = "#313685",
        "Sablefish" = "#1F518F",
        "Rockfish" = "#006C8E",
        "Dover sole" = "#008785",
        "Petrale sole" = "#009E6B",
        "Thornyheads" = "#3BAF45",
        "Other groundfish species" = "#5D9E00",
        "Other species production" = "#4B0055",
        "Crab" = "#411A66",
        "Shrimp" = "#313685",
        "Salmon" = "#1F518F",
        "Tuna" = "#006C8E",
        "Coastal pelagics" = "#008785",
        "Other shellfish" = "#009E6B",
        "Other species" = "#5A6B73",

        # state colors
        "California" = "#4B0055",
        "Washington and Oregon" = "#006C8E",

        # processor size colors
        "Small/Medium" = "#4B0055",
        "Large" = "#006C8E",

        # product type colors
        "All product types" = "#4B0055",
        "Fresh" = "#2B3C8E",
        "Frozen" = "#006C8E",
        "Other" = "#009E6B",
        "Surimi" = "#5D9E00",
        "Unprocessed" = "#8DB600"
    )

    # line type
    line_ty <- c(
        # states
        "California" = 'solid',
        "Washington and Oregon" = 'solid',

        # processor size
        "Small/Medium" = 'solid',
        "Large" = 'solid',

        # species
        "All production" = "solid",
        "Groundfish production" = 'solid',
        "Pacific whiting" = 'solid',
        "Non-whiting groundfish" = 'solid',
        "Sablefish" = 'solid',
        "Rockfish" = 'solid',
        "Dover sole" = 'solid',
        "Petrale sole" = 'solid',
        "Thornyheads" = 'solid',
        "Other groundfish species" = 'solid',

        # other species
        "Other species production" = 'dashed',
        "Crab" = 'dashed',
        "Shrimp" = 'dashed',
        "Salmon" = 'dashed',
        "Tuna" = 'dashed',
        "Coastal pelagics" = 'dashed',
        "Other shellfish" = 'dashed',
        "Other species" = 'dashed',

        # product type
        "All product types" = "solid",
        "Fresh" = "solid",
        "Frozen" = "solid",
        "Other" = "solid",
        "Unprocessed" = "solid",
        "Surimi" = "solid"
    )

    ####################### writing to R/sysdata.rda file (internal data) ###########################

    # this function writes the desired data frames that are used in the app into the 'data' folder
    usethis::use_data(
        ########### GDP deflator vals
        gdp_defl,
        ########### for "Summary" tab on the Explore the Data page
        met_prac,
        met_reg,
        met_size,
        ###########  for "By Product Type" tab on the Explore the Data page
        prod_prac,
        prod_reg,
        prod_size,
        ###########  for "By Species" tab on the Explore the Data page
        specs_prod,
        specs_reg,
        specs_size,

        ###########  for "Overview" page
        overview,
        coverage,
        order,

        ###########  plot aesthetics
        pal,
        line_ty,
        line_col,
        ###########
        overwrite = TRUE,
        internal = TRUE # this parameter makes it so that the user of the app does not have access to the data itself. Just usign these data to make the plots. Not so the user can wrangle it themselves
    )
}
