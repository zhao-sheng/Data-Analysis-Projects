# Austrian Energy Market Analysis Project

![Price Analysis](./results/figures/price_analysis.png)

## ✅ Key Results 
**Risk Metrics (1-hour returns):**
- **Value-at-Risk (95%):** `-16.74%`  
  *Maximum expected loss under normal conditions*
- **Conditional VaR (95%):** `-23.36%`  
  *Average loss during extreme events*

**Strategy Performance:**
- Clear cyclical patterns in electricity-gas spread
- Demonstrated profitability in backtesting (see plot below)

![Trading Strategy](./results/figures/trading_strategy.png)

## 🛠️ How to Reproduce
1. **Generate Data** (if needed):
   ```matlab
   generate_data();  % Creates synthetic data in /data/raw