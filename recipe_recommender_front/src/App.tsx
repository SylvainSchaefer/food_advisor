import React, { useState, useEffect } from 'react';
import './App.css';
import { AuthPage } from './components/AuthPage';
import { Dashboard } from './components/Dashboard';
import { Recipe, AuthResponse } from './types';
import { api } from './services/api';

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    // Vérifier si un token existe au chargement
    const token = localStorage.getItem('auth_token');
    if (token) {
      // Vérifier la validité du token en faisant une requête
      verifyToken();
    } else {
      setIsLoading(false);
    }
  }, []);

  const verifyToken = async () => {
    try {
      // Tester le token avec une requête simple
      await api.getRecommendations(1, 1);
      setIsAuthenticated(true);
    } catch (error) {
      // Token invalide ou expiré
      localStorage.removeItem('auth_token');
      setIsAuthenticated(false);
    } finally {
      setIsLoading(false);
    }
  };

  const handleLogin = (response: AuthResponse) => {
    localStorage.setItem('auth_token', response.token);
    setIsAuthenticated(true);
  };

  const handleLogout = () => {
    localStorage.removeItem('auth_token');
    setIsAuthenticated(false);
  };

  if (isLoading) {
    return (
      <div className="loading-container">
        <div className="spinner"></div>
      </div>
    );
  }

  return (
    <div className="app">
      {isAuthenticated ? (
        <Dashboard onLogout={handleLogout} />
      ) : (
        <AuthPage onLogin={handleLogin} />
      )}
    </div>
  );
}

export default App;
