# ============================================================================
# run_all_charts.R — Master Runner
#
# Part of: Hill Country Health System — Information Architecture Gap Analysis
# Course:  HM435 Senior Professional Practice Experience, Fisher College
# Author:  Andrew Crocker
# Date:    2026
#
# Description:
#   Sources all four chart scripts in sequence. Run this from the project
#   root directory to generate all output PNGs at once.
#
# Usage:
#   Rscript R/run_all_charts.R
#   — or —
#   source("R/run_all_charts.R")  # from within an R session
#
# Prerequisites:
#   install.packages("ggplot2")
#
# Output:
#   output/chart1_denial_trend.png
#   output/chart2_rural_urban.png
#   output/chart3_roi.png
#   output/chart4_heatmap.png
# ============================================================================

cat("==========================================================\n")
cat("Hill Country Health System — Gap Analysis Charts\n")
cat("Running all four chart scripts...\n")
cat("==========================================================\n\n")

# Verify ggplot2 is available before proceeding
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  stop("ggplot2 is required. Install it with: install.packages('ggplot2')")
}

# Create output directory if it does not exist
dir.create("output", showWarnings = FALSE)

# Source each chart script
# Each script saves its own PNG to the output/ directory

cat("--- Chart 1: Claim Denial Rate Trend ---\n")
source("R/chart1_denial_trend.R")

cat("\n--- Chart 2: Rural vs Urban Interoperability ---\n")
source("R/chart2_rural_urban.R")

cat("\n--- Chart 3: Projected Year 1 ROI Model ---\n")
source("R/chart3_roi.R")

cat("\n--- Chart 4: Gap Risk Heat Map ---\n")
source("R/chart4_heatmap.R")

cat("\n==========================================================\n")
cat("All charts generated successfully.\n")
cat("Output files are in the output/ directory.\n")
cat("==========================================================\n")
