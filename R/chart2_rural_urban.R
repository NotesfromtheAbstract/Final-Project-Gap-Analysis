# ============================================================================
# Chart 2: Rural vs Urban Interoperability Gap Comparison
#
# Part of: Hill Country Health System — Information Architecture Gap Analysis
# Course:  HM435 Senior Professional Practice Experience, Fisher College
# Author:  Andrew Crocker
# Date:    2026
#
# Description:
#   Grouped bar chart comparing rural and urban hospitals across four
#   interoperability measures: EHR adoption rate, routine exchange across
#   all four domains, FHIR app access, and Promoting Interoperability score.
#   Rural facilities trail urban facilities on every measure, positioning
#   Hill Country Health System — a rural, independent, multi-site system —
#   in the highest-risk category on each dimension.
#
# Data sources:
#   EHR Adoption Rate:
#     BMC Health Services Research. (2025). Lower electronic health record
#     adoption and interoperability in rural versus urban physician participants.
#     https://bmchealthservres.biomedcentral.com/articles/10.1186/s12913-024-12168-5
#     Rural: 64%, Urban: 74%
#
#   Routine Exchange (All 4 Domains):
#     ASTP/ONC. (2024). ONC Data Brief No. 72.
#     https://www.healthit.gov/data/databriefs
#     Urban: 43% achieve routine exchange; rural estimated at ~28%
#
#   FHIR App Access Enabled:
#     ASTP/ONC. (2025). ASTP Data Brief No. 78.
#     https://healthit.gov/wp-content/uploads/2025/07/2024-AHA-Public-Health-DB78_508.pdf
#     Urban: 64%; rural estimated at ~41%
#
#   PI Score (Avg):
#     BMC Health Services Research. (2025). Ibid.
#     Rural: 52, Urban: 68 (gap of -3.5 points on standardized scale)
#
# Output: output/chart2_rural_urban.png
# ============================================================================

library(ggplot2)

# ── Color palette ─────────────────────────────────────────────────────────────
navy   <- "#1B2A4A"
teal   <- "#0D7C8F"
red    <- "#C0392B"
slate  <- "#4A5568"
offwht <- "#F4F6F8"

# ── Base theme ────────────────────────────────────────────────────────────────
base_theme <- theme_minimal(base_family = "sans") +
  theme(
    plot.background   = element_rect(fill = offwht, color = NA),
    panel.background  = element_rect(fill = offwht, color = NA),
    panel.grid.major  = element_line(color = "#E2E8F0", linewidth = 0.4),
    panel.grid.minor  = element_blank(),
    axis.text         = element_text(color = slate, size = 9),
    axis.title        = element_text(color = navy,  size = 10, face = "bold"),
    plot.title        = element_text(color = navy,  size = 11, face = "bold", hjust = 0),
    plot.subtitle     = element_text(color = slate, size = 8,  hjust = 0,
                                     margin = margin(b = 6)),
    legend.background = element_rect(fill = offwht, color = NA),
    legend.text       = element_text(color = slate, size = 9),
    legend.title      = element_text(color = navy,  size = 9, face = "bold"),
    plot.margin       = margin(10, 14, 8, 10)
  )

# ── Data ──────────────────────────────────────────────────────────────────────
interop <- data.frame(
  category = rep(c(
    "EHR Adoption Rate",
    "Routine Exchange\n(All 4 Domains)",
    "FHIR App Access\nEnabled",
    "PI Score\n(Avg)"
  ), 2),
  setting = rep(c("Urban", "Rural"), each = 4),
  value   = c(
    74, 43, 64, 68,   # Urban
    64, 28, 41, 52    # Rural
  )
)

# Lock category display order
interop$category <- factor(interop$category, levels = c(
  "EHR Adoption Rate",
  "Routine Exchange\n(All 4 Domains)",
  "FHIR App Access\nEnabled",
  "PI Score\n(Avg)"
))

# ── Plot ──────────────────────────────────────────────────────────────────────
p <- ggplot(interop, aes(x = category, y = value, fill = setting)) +
  geom_col(position = position_dodge(width = 0.62),
           width = 0.55, alpha = 0.9) +
  # Labels — PI Score has no % suffix (raw score, not percentage)
  geom_text(
    aes(label = paste0(value,
                       ifelse(category == "PI Score\n(Avg)", "", "%"))),
    position = position_dodge(width = 0.62),
    vjust = -0.4, size = 3.2, fontface = "bold", color = navy
  ) +
  scale_fill_manual(
    values = c("Urban" = teal, "Rural" = red),
    name   = "Setting"
  ) +
  scale_y_continuous(
    limits = c(0, 88),
    labels = function(x) ifelse(x == 0, "0", paste0(x, "%"))
  ) +
  labs(
    title    = "Rural Hospitals Trail Urban on Every Interoperability Measure",
    subtitle = paste0("Sources: BMC Health Services Research 2025; ",
                      "ONC Data Brief No. 72, 2024"),
    x        = NULL,
    y        = "Percentage / Score"
  ) +
  base_theme +
  theme(
    legend.position      = "top",
    legend.justification = "left"
  )

# ── Save ──────────────────────────────────────────────────────────────────────
# Wide shallow format matches the slide space on slide 5 of the deck
dir.create("output", showWarnings = FALSE)
ggsave("output/chart2_rural_urban.png", p,
       width = 9.3, height = 2.8, dpi = 200, bg = offwht)
cat("Saved: output/chart2_rural_urban.png\n")
