# Hill Country Health System — Information Architecture Gap Analysis
## Data Visualizations for HM435 Senior Professional Practice Experience

**Author:** Andrew Crocker  
**Course:** HM435 — Senior Professional Practice Experience  
**Institution:** Fisher College  
**Term:** March 2026  
**Credentials:** CPC-A, CEDC, COSC  

---

## Overview

This repository contains the R source code used to generate four data visualizations for the HM435 capstone PowerPoint presentation: *Closing the Gaps: Information Architecture Assessment at Hill Country Health System.*

The presentation proposes a 12-week, HIM-led information architecture gap analysis across a fictional multi-site community health system — Hill Country Health System, anchored by Fisher Medical Center in Kerrville, Texas. All charts were built in R using ggplot2 and embedded directly into the PowerPoint deck.

---

## Charts

| File | Chart | Data Type |
|------|-------|-----------|
| `R/chart1_denial_trend.R` | Claim Denial Rate Trend 2022–2025 | Sourced |
| `R/chart2_rural_urban.R` | Rural vs Urban Interoperability Gap | Sourced |
| `R/chart3_roi.R` | Projected Year 1 ROI Model | Illustrative |
| `R/chart4_heatmap.R` | Gap Risk Heat Map by Site and Data Type | Illustrative |

**Sourced** charts use data from published research with full citations in each script.  
**Illustrative** charts use modeled figures based on the Hill Country Health System fictional scenario and industry benchmarks. These are clearly labeled as illustrative in both the scripts and the presentation slides.

---

## Data Sources

- Experian Health. (2025). *State of claims 2025: The denial problem.* https://www.experian.com/blogs/healthcare/state-of-claims-2025/
- MGMA. (2024). *MGMA Stat: Medical group leaders experienced 60% more claims denials in 2024.* https://www.mgma.com/data/data-stories/mgma-stat-medical-group-leaders-experienced-60-more-claims-denials-in-2024
- BMC Health Services Research. (2025). *Lower electronic health record adoption and interoperability in rural versus urban physician participants.* https://bmchealthservres.biomedcentral.com/articles/10.1186/s12913-024-12168-5
- Office of the Assistant Secretary for Technology Policy (ASTP/ONC). (2024). *Interoperable exchange of patient health information among U.S. hospitals: 2023.* ONC Data Brief No. 72. https://www.healthit.gov/data/databriefs
- Office of the Assistant Secretary for Technology Policy (ASTP/ONC). (2025, July). *Electronic public health reporting among non-federal acute care hospitals, 2024.* ASTP Data Brief No. 78. https://healthit.gov/wp-content/uploads/2025/07/2024-AHA-Public-Health-DB78_508.pdf

---

## Requirements

- R 4.3.3 or later
- ggplot2

Install ggplot2 if needed:

```r
install.packages("ggplot2")
```

---

## Usage

### Run all four charts at once

```r
source("R/run_all_charts.R")
```

### Run individual charts

```r
source("R/chart1_denial_trend.R")
source("R/chart2_rural_urban.R")
source("R/chart3_roi.R")
source("R/chart4_heatmap.R")
```

All output PNG files are saved to the `output/` directory.

---

## Repository Structure

```
.
├── README.md
├── .gitignore
├── R/
│   ├── run_all_charts.R        # Master script — runs all four charts
│   ├── chart1_denial_trend.R   # Claim denial rate trend 2022–2025
│   ├── chart2_rural_urban.R    # Rural vs urban interoperability comparison
│   ├── chart3_roi.R            # Projected Year 1 ROI model
│   └── chart4_heatmap.R        # Gap risk heat map by site and data type
└── output/
    ├── chart1_denial_trend.png
    ├── chart2_rural_urban.png
    ├── chart3_roi.png
    └── chart4_heatmap.png
```

---

## Color Palette

All charts use the Hill Country Health System presentation palette for visual consistency with the PowerPoint deck.

| Color | Hex | Usage |
|-------|-----|-------|
| Navy | `#1B2A4A` | Primary text, net return bars |
| Teal | `#0D7C8F` | Primary data bars, urban setting |
| Gold | `#C8922A` | Accent, mid-range risk |
| Red | `#C0392B` | High risk, denial data, rural setting |
| Slate | `#4A5568` | Secondary text |
| Off-white | `#F4F6F8` | Plot background |

---

## Citation

If referencing this code:

> Crocker, A. (2026). *HCHS_gap_analysis_charts* [R source code]. GitHub. https://github.com/[YOUR-USERNAME]/[YOUR-REPO]

---

## License

MIT License. See LICENSE file for details.  
Data sources retain their original copyrights. Illustrative figures are original work.
