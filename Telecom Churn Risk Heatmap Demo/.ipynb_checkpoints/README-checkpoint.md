# Telecom Churn Risk Heatmap Demo

A quick demo showcasing geospatial analysis of customer churn risk for a telecom provider, using an interactive heatmap to visualize high-risk areas in Vienna.

## Overview
- **Problem**: Identify geographic areas with high customer churn risk to support targeted retention strategies.
- **Tools**: Python (`pandas`, `scikit-learn`, `folium`).
- **Steps**:
  - Generate simulated telecom customer data with geospatial coordinates (Vienna).
  - Predict churn probability using a random forest model.
  - Visualize churn risk on an optimized interactive heatmap.
  - Provide business recommendations for customer retention.

## How to Run
1. Install dependencies: `pip install -r requirements.txt`
2. Run `churn_heatmap.ipynb` in Jupyter Notebook.
3. Open `visualizations/churn_heatmap.html` in a browser to view the interactive heatmap.

## Results
- Interactive heatmap highlights high-risk churn areas in Vienna (e.g., Leopoldstadt, Favoriten) with improved color gradients (blue to red).
- Key insight: Target high-risk zones with localized promotions and adjust pricing for short-term, high-charge customers.

## Notes
- Uses synthetic data stored in `data/simulated_churn_data.csv` for demo purposes.
- Designed to align with Magenta Telekom's focus on geospatial data analysis and actionable insights.