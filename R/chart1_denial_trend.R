# ============================================================================
# Chart 1: Claim Denial Rate Trend 2022–2025
#
# Part of: Hill Country Health System — Information Architecture Gap Analysis
# Course:  HM435 Senior Professional Practice Experience, Fisher College
# Author:  Andrew Crocker
# Date:    2026
#
# Description:
#   Dual-axis chart showing the national trend in initial claim denial rates
#   (teal bars, left axis) alongside the percentage of providers whose denial
#   rate exceeds 10% (red line, right axis). Both metrics have risen every
#   year from 2022 to 2025, grounding the rationale for a gap analysis
#   intervention at Hill Country Health System.
#
# Data sources:
#   - Experian Health. (2025). State of claims 2025: The denial problem.
#     https://www.experian.com/blogs/healthcare/state-of-claims-2025/
#   - MGMA. (2024). MGMA Stat: Medical group leaders experienced 60% more
#     claims denials in 2024.
#     https://www.mgma.com/data/data-stories/mgma-stat-medical-group-leaders-
#     experienced-60-more-claims-denials-in-2024
#
# Output: output/chart1_denial_trend.png
# ============================================================================

library(ggplot2)

# ── Color palette ─────────────────────────────────────────────────────────────
navy   <- "#1B2A4A"
teal   <- "#0D7C8F"
red    <- "#C0392B"
slate  <- "#4A5568"
offwht <- "#F4F6F8"
gray   <- "#718096"
ltgray <- "#A0AEC0"

# ── Base theme ────────────────────────────────────────────────────────────────
base_theme <- theme_minimal(base_family = "sans") +
  theme(
    plot.background   = element_rect(fill = offwht, color = NA),
    panel.background  = element_rect(fill = offwht, color = NA),
    panel.grid.major  = element_line(color = "#E2E8F0", linewidth = 0.4),
    panel.grid.minor  = element_blank(),
    axis.text         = element_text(color = slate,  size = 11),
    axis.title        = element_text(color = navy,   size = 12, face = "bold"),
    plot.title        = element_text(color = navy,   size = 14, face = "bold", hjust = 0),
    plot.subtitle     = element_text(color = slate,  size = 10, hjust = 0,
                                     margin = margin(b = 10)),
    legend.background = element_rect(fill = offwht,  color = NA),
    plot.margin       = margin(16, 20, 12, 16)
  )

# ── Data ──────────────────────────────────────────────────────────────────────
# rate:  Average initial denial rate (%) — Experian Health 2025
# pct10: Percentage of providers with denial rate above 10% — Experian / MGMA
denial <- data.frame(
  year  = c(2022, 2023, 2024, 2025),
  rate  = c(10.2, 11.0, 11.8, 12.4),
  pct10 = c(30,   34,   38,   41)
)

# Scale factor maps pct10 range onto the primary axis
scale_factor <- 3.5

# ── Plot ──────────────────────────────────────────────────────────────────────
p <- ggplot(denial, aes(x = year)) +
  # Bars: average initial denial rate
  geom_col(aes(y = rate), fill = teal, width = 0.45, alpha = 0.85) +
  # Line: % providers above 10% threshold (scaled to primary axis)
  geom_line(aes(y = pct10 / scale_factor),
            color = red, linewidth = 1.4) +
  geom_point(aes(y = pct10 / scale_factor),
             color = red, size = 3.5, shape = 19) +
  # Bar labels above bars
  geom_text(aes(y = rate + 0.25, label = paste0(rate, "%")),
            color = navy, size = 3.8, fontface = "bold") +
  # Line labels below points to avoid overlap with line
  geom_text(aes(y = pct10 / scale_factor - 0.35,
                label = paste0(pct10, "%")),
            color = red, size = 3.5, fontface = "bold", vjust = 1.0) +
  # Axes
  scale_x_continuous(breaks = 2022:2025) +
  scale_y_continuous(
    name   = "Initial Denial Rate (%)",
    limits = c(0, 15),
    breaks = seq(0, 15, by = 3),
    sec.axis = sec_axis(
      ~ . * scale_factor,
      name   = "Providers with >10% Denial Rate (%)",
      breaks = seq(0, 52.5, by = 10.5),
      labels = c("0%", "10%", "20%", "30%", "40%", "50%")
    )
  ) +
  # Legend annotation
  annotate("text", x = 2023.5, y = 13.8,
           label = "Bars = avg denial rate   Line = % providers above 10% threshold",
           color = gray, size = 3.2, hjust = 0.5) +
  labs(
    title    = "Claim Denial Rates Are Rising Every Year",
    subtitle = paste0("National trend 2022\u20132025 | ",
                      "Sources: Experian Health State of Claims 2025; MGMA 2024"),
    x        = NULL
  ) +
  base_theme +
  theme(
    axis.title.y.right = element_text(color = red, size = 11, face = "bold"),
    axis.text.y.right  = element_text(color = red)
  )

# ── Save ──────────────────────────────────────────────────────────────────────
dir.create("output", showWarnings = FALSE)
ggsave("output/chart1_denial_trend.png", p,
       width = 8, height = 4.2, dpi = 200, bg = offwht)
cat("Saved: output/chart1_denial_trend.png\n")
