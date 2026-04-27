# ============================================================================
# Chart 3: Projected Year 1 ROI Model
#
# Part of: Hill Country Health System — Information Architecture Gap Analysis
# Course:  HM435 Senior Professional Practice Experience, Fisher College
# Author:  Andrew Crocker
# Date:    2026
#
# Description:
#   Waterfall-style bar chart showing the projected Year 1 financial return
#   on the gap analysis investment for Hill Country Health System. Two return
#   components are shown separately — denial recovery and PI penalty avoidance —
#   alongside the project cost and net return.
#
# IMPORTANT: This is an ILLUSTRATIVE model. Values are projections based on
#   industry benchmarks, not empirically measured outcomes. The chart is
#   clearly labeled as illustrative in the presentation.
#
# Assumption documentation:
#
#   Project cost ($43,600):
#     Upper bound of estimated range. Includes HIM Director/analyst time
#     (20% FTE for 90 days), project coordinator (50% FTE for 90 days),
#     clinical engagement across 5 sites, and HIT consulting support.
#
#   Denial recovery ($185,000):
#     Conservative Year 1 estimate. Literature supports 60–70% of denials
#     are recoverable with targeted documentation improvement at systems
#     of this size (MGMA 2024; Experian Health 2025). Figure assumes
#     partial-year recovery across ED and SNF transfer gap closures.
#
#   PI penalty avoidance ($62,000):
#     Based on CMS Promoting Interoperability penalty structure for
#     eligible hospitals. Reflects avoidance of downward Medicare
#     reimbursement adjustment for non-attestation.
#
#   Net Year 1 return ($203,400):
#     Denial recovery + PI penalty avoidance − project cost.
#     ($185,000 + $62,000 − $43,600 = $203,400)
#
# Output: output/chart3_roi.png
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
    axis.text         = element_text(color = slate, size = 8),
    axis.text.x       = element_text(color = navy,  size = 8, lineheight = 0.9),
    axis.title        = element_text(color = navy,  size = 9, face = "bold"),
    plot.title        = element_text(color = navy,  size = 10, face = "bold", hjust = 0),
    plot.subtitle     = element_text(color = slate, size = 7,  hjust = 0,
                                     margin = margin(b = 4)),
    plot.margin       = margin(10, 12, 8, 10)
  )

# ── Data ──────────────────────────────────────────────────────────────────────
roi <- data.frame(
  component = c(
    "Gap Analysis\nCost",
    "Denial\nRecovery",
    "PI Penalty\nAvoidance",
    "Net Year 1\nReturn"
  ),
  value = c(-43600, 185000, 62000, 203400),
  type  = c("Cost", "Return", "Return", "Net")
)

# Lock display order
roi$component <- factor(roi$component, levels = roi$component)

# Assign colors by component type
roi$color <- ifelse(roi$type == "Cost",   red,
             ifelse(roi$type == "Net",    navy, teal))

# Format dollar labels
roi$label <- ifelse(
  roi$value < 0,
  paste0("-$", formatC(abs(roi$value), format = "d", big.mark = ",")),
  paste0("+$", formatC(roi$value,      format = "d", big.mark = ","))
)

# ── Plot ──────────────────────────────────────────────────────────────────────
p <- ggplot(roi, aes(x = component, y = value / 1000, fill = color)) +
  geom_col(width = 0.6, alpha = 0.9) +
  geom_hline(yintercept = 0, color = slate, linewidth = 0.6) +
  # Labels above positive bars, below negative bars
  geom_text(
    aes(label = label,
        vjust = ifelse(value >= 0, -0.4, 1.3)),
    size = 2.9, fontface = "bold", color = navy
  ) +
  scale_fill_identity() +
  scale_y_continuous(
    labels = function(x) paste0("$", abs(x), "K"),
    limits = c(-65, 230)
  ) +
  labs(
    title    = "Projected Year 1 Return on Investment",
    subtitle = "Illustrative model | Hill Country Health System scenario",
    x        = NULL,
    y        = "USD (thousands)"
  ) +
  base_theme

# ── Save ──────────────────────────────────────────────────────────────────────
# Narrow format matches the right-column space on slide 6 of the deck
dir.create("output", showWarnings = FALSE)
ggsave("output/chart3_roi.png", p,
       width = 3.7, height = 3.1, dpi = 220, bg = offwht)
cat("Saved: output/chart3_roi.png\n")
