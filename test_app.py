# test_app.py
import unittest
from app import app


class FlaskAppTestCase(unittest.TestCase):
    def setUp(self):
        """Set up test client"""
        self.app = app.test_client()
        self.app.testing = True

    def test_home_page(self):
        """Test that home page loads correctly"""
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'ToDo List', response.data)

    def test_add_task(self):
        """Test adding a task"""
        response = self.app.post('/add', data=dict(task='Test Task'), follow_redirects=True)
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Test Task', response.data)

    def test_health_check(self):
        """Test health check endpoint"""
        response = self.app.get('/health')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'healthy', response.data)


if __name__ == '__main__':
    unittest.main()