import pandas as pd

def load_telecom_data():
    """统一数据加载接口"""
    towers = pd.read_csv('../data/synthetic_towers.csv')
    connections = pd.read_parquet('../data/synthetic_connections.parquet')
    return towers, connections