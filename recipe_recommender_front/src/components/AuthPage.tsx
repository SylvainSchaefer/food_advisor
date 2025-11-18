import React, { useState } from 'react';
import { LoginRequest, RegisterRequest, AuthResponse } from '../types';
import { api } from '../services/api';
import './AuthPage.css';

interface AuthPageProps {
  onLogin: (response: AuthResponse) => void;
}

export const AuthPage: React.FC<AuthPageProps> = ({ onLogin }) => {
  const [isLogin, setIsLogin] = useState(true);
  const [error, setError] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const [loginData, setLoginData] = useState<LoginRequest>({
    email: '',
    password: ''
  });

  const [registerData, setRegisterData] = useState<RegisterRequest>({
    email: '',
    password: '',
    first_name: '',
    last_name: '',
    gender: 'Other',
    birth_date: '',
    country: ''
  });

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setIsLoading(true);

    try {
      const response = await api.login(loginData);
      onLogin(response);
    } catch (err: any) {
      setError(err.message || 'Erreur de connexion');
    } finally {
      setIsLoading(false);
    }
  };

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setIsLoading(true);

    try {
      const response = await api.register(registerData);
      onLogin(response);
    } catch (err: any) {
      setError(err.message || 'Erreur lors de l\'inscription');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="auth-page">
      <div className="auth-container">
        <div className="auth-header">
          <h1>🍳 Food Advisor</h1>
          <p>Découvrez des recettes personnalisées</p>
        </div>

        <div className="auth-tabs">
          <button 
            className={isLogin ? 'active' : ''} 
            onClick={() => setIsLogin(true)}
          >
            Connexion
          </button>
          <button 
            className={!isLogin ? 'active' : ''} 
            onClick={() => setIsLogin(false)}
          >
            Inscription
          </button>
        </div>

        {error && <div className="error-message">{error}</div>}

        {isLogin ? (
          <form onSubmit={handleLogin} className="auth-form">
            <div className="form-group">
              <label>Email</label>
              <input
                type="email"
                value={loginData.email}
                onChange={(e) => setLoginData({ ...loginData, email: e.target.value })}
                required
                placeholder="votre@email.com"
              />
            </div>

            <div className="form-group">
              <label>Mot de passe</label>
              <input
                type="password"
                value={loginData.password}
                onChange={(e) => setLoginData({ ...loginData, password: e.target.value })}
                required
                placeholder="••••••••"
              />
            </div>

            <button type="submit" className="submit-btn" disabled={isLoading}>
              {isLoading ? 'Connexion...' : 'Se connecter'}
            </button>
          </form>
        ) : (
          <form onSubmit={handleRegister} className="auth-form">
            <div className="form-row">
              <div className="form-group">
                <label>Prénom</label>
                <input
                  type="text"
                  value={registerData.first_name}
                  onChange={(e) => setRegisterData({ ...registerData, first_name: e.target.value })}
                  required
                  placeholder="John"
                />
              </div>

              <div className="form-group">
                <label>Nom</label>
                <input
                  type="text"
                  value={registerData.last_name}
                  onChange={(e) => setRegisterData({ ...registerData, last_name: e.target.value })}
                  required
                  placeholder="Doe"
                />
              </div>
            </div>

            <div className="form-group">
              <label>Email</label>
              <input
                type="email"
                value={registerData.email}
                onChange={(e) => setRegisterData({ ...registerData, email: e.target.value })}
                required
                placeholder="votre@email.com"
              />
            </div>

            <div className="form-group">
              <label>Mot de passe</label>
              <input
                type="password"
                value={registerData.password}
                onChange={(e) => setRegisterData({ ...registerData, password: e.target.value })}
                required
                placeholder="••••••••"
              />
            </div>

            <div className="form-row">
              <div className="form-group">
                <label>Genre</label>
                <select
                  value={registerData.gender}
                  onChange={(e) => setRegisterData({ ...registerData, gender: e.target.value as any })}
                  required
                >
                  <option value="Male">Homme</option>
                  <option value="Female">Femme</option>
                  <option value="Other">Autre</option>
                </select>
              </div>

              <div className="form-group">
                <label>Date de naissance</label>
                <input
                  type="date"
                  value={registerData.birth_date}
                  onChange={(e) => setRegisterData({ ...registerData, birth_date: e.target.value })}
                  required
                />
              </div>
            </div>

            <div className="form-group">
              <label>Pays</label>
              <input
                type="text"
                value={registerData.country}
                onChange={(e) => setRegisterData({ ...registerData, country: e.target.value })}
                required
                placeholder="France"
              />
            </div>

            <button type="submit" className="submit-btn" disabled={isLoading}>
              {isLoading ? 'Inscription...' : 'S\'inscrire'}
            </button>
          </form>
        )}
      </div>
    </div>
  );
};
