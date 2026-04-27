# ============================================================================
# Chart 4: Information Architecture Gap Risk Heat Map
#
# Part of: Hill Country Health System — Information Architecture Gap Analysis
# Course:  HM435 Senior Professional Practice Experience, Fisher College
# Author:  Andrew Crocker
# Date:    2026
#
# Description:
#   Heat map showing illustrative gap risk scores for each site/data-type
#   combination across Hill Country Health System. Risk scores (0–100)
#   represent the estimated probability and severity of data gap failures
#   at each intersection, based on the gap analysis framework described
#   in the presentation.
#
# IMPORTANT: This is an ILLUSTRATIVE scoring matrix. Scores are modeled
#   from the fictional Hill Country Health System scenario. They are not
#   empirically derived. In a real deployment, these scores would be
#   generated from actual interface inventory data, coder query logs,
#   and denial remittance analysis conducted during the gap analysis.
#
# Sites assessed:
#   - Fredericksburg Rural Health Clinic
#   - Marble Falls Rural Health Clinic
#   - Comfort Rural Health Clinic
#   - Hill Country SNF & Rehabilitation
#   - Physician Practice Group
#
# Data types assessed:
#   - Clinical Summaries
#   - Lab Results
#   - Medication Reconciliation
#   - Problem List
#   - Public Health Reporting
#
# Scoring rationale:
#   Rural health clinics: high clinical summary and public health risk
#     due to limited interface infrastructure and mixed-vendor environment
#   SNF: high med reconciliation and lab risk due to transfer workflow
#     gaps — MDS data does not populate Fisher Medical Center on transfer
#   Physician Practice Group: high problem list risk — separate ambulatory
#     EHR with no inbound interface to Fisher Medical Center; HCC capture
#     is structurally incomplete on every inpatient admission
#
# Output: output/chart4_heatmap.png
# ============================================================================

library(ggplot2)

# ── Color palette ─────────────────────────────────────────────────────────────
navy   <- "#1B2A4A"
gold   <- "#C8922A"
red    <- "#C0392B"
offwht <- "#F4F6F8"

# ── Base theme ────────────────────────────────────────────────────────────────
base_theme <- theme_minimal(base_family = "sans") +
  theme(
    plot.background  = element_rect(fill = offwht, color = NA),
    panel.background = element_rect(fill = offwht, color = NA),
    axis.text.x      = element_text(size = 10, color = navy),
    axis.text.y      = element_text(size = 10, color = navy),
    plot.title       = element_text(color = navy,  size = 14, face = "bold", hjust = 0),
    plot.subtitle    = element_text(color = "#4A5568", size = 10, hjust = 0,
                                    margin = margin(b = 10)),
    panel.grid       = element_blank(),
    legend.position  = "right",
    legend.background = element_rect(fill = offwht, color = NA),
    plot.margin      = margin(16, 20, 12, 16)
  )

# ── Site and data type labels ─────────────────────────────────────────────────
sites <- c(
  "Fredericksburg\nRHC",
  "Marble Falls\nRHC",
  "Comfort\nRHC",
  "Hill Country\nSNF",
  "Physician\nPractice Group"
)

data_types <- c(
  "Clinical\nSummaries",
  "Lab\nResults",
  "Med\nReconciliation",
  "Problem\nList",
  "Public Health\nReporting"
)

# ── Risk score matrix ─────────────────────────────────────────────────────────
# Rows = sites (in order above), Columns = data types (in order above)
# Scores 0–100: higher = higher gap risk
risk_matrix <- matrix(c(
  85, 70, 60, 75, 80,   # Fredericksburg RHC
  90, 65, 55, 80, 70,   # Marble Falls RHC
  75, 60, 70, 65, 85,   # Comfort RHC
  50, 80, 90, 55, 40,   # Hill Country SNF
  70, 45, 60, 90, 55    # Physician Practice Group
), nrow = 5, byrow = TRUE)

# ── Reshape to long format for ggplot ─────────────────────────────────────────
heat_df <- data.frame(
  site      = rep(sites,      each  = length(data_types)),
  data_type = rep(data_types, times = length(sites)),
  risk      = as.vector(t(risk_matrix))
)

# Sites display top-to-bottom on y axis (reverse factor levels)
heat_df$site      <- factor(heat_df$site,      levels = rev(sites))
heat_df$data_type <- factor(heat_df$data_type, levels = data_types)

# Cell labels and adaptive text color
heat_df$label    <- paste0(heat_df$risk, "%")
heat_df$text_col <- ifelse(heat_df$risk > 72, "white", navy)

# ── Plot ──────────────────────────────────────────────────────────────────────
p <- ggplot(heat_df, aes(x = data_type, y = site, fill = risk)) +
  geom_tile(color = offwht, linewidth = 1.2) +
  geom_text(aes(label = label, color = text_col),
            size = 3.6, fontface = "bold") +
  # Diverging scale: light blue (low) → gold (mid) → red (high)
  scale_fill_gradient2(
    low      = "#B8E0E8",
    mid      = gold,
    high     = red,
    midpoint = 65,
    limits   = c(30, 95),
    name     = "Gap Risk\nScore"
  ) +
  scale_color_identity() +
  labs(
    title    = "Information Architecture Gap Risk by Site and Data Type",
    subtitle = paste0("Illustrative risk scoring | darker = higher gap risk | ",
                      "based on interface inventory and coder query analysis"),
    x        = NULL,
    y        = NULL
  ) +
  base_theme

# ── Save ──────────────────────────────────────────────────────────────────────
dir.create("output", showWarnings = FALSE)
ggsave("output/chart4_heatmap.png", p,
       width = 8, height = 4.2, dpi = 200, bg = offwht)
cat("Saved: output/chart4_heatmap.png\n")
