import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home(client):
    """Test the home page"""
    rv = client.get('/')
    assert rv.status_code == 200
    assert b'This is a simple flask app for demonstrating a deployment' in rv.data
