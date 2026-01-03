import React, { createContext, useContext, useState, useEffect } from 'react';

interface Admin {
  id: string;
  email: string;
  name: string;
  role: 'admin' | 'super_admin';
  avatar?: string;
}

interface AuthContextType {
  admin: Admin | null;
  isAuthenticated: boolean;
  isLoading: boolean;
  login: (email: string, password: string) => Promise<boolean>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

// Mock admin credentials
const MOCK_ADMINS = [
  {
    id: '1',
    email: 'admin@cotravel.com',
    password: 'admin123',
    name: 'Sarah Chen',
    role: 'super_admin' as const,
    avatar: 'SC',
  },
  {
    id: '2',
    email: 'demo@globetrotter.com',
    password: 'demo123',
    name: 'Demo User',
    role: 'admin' as const,
    avatar: 'DU',
  },
];

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [admin, setAdmin] = useState<Admin | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    // Check for existing session
    const savedAdmin = localStorage.getItem('globetrotter_admin');
    if (savedAdmin) {
      setAdmin(JSON.parse(savedAdmin));
    }
    setIsLoading(false);
  }, []);

  const login = async (email: string, password: string): Promise<boolean> => {
    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 800));
    
    const foundAdmin = MOCK_ADMINS.find(
      a => a.email === email && a.password === password
    );
    
    if (foundAdmin) {
      const { password: _, ...adminData } = foundAdmin;
      setAdmin(adminData);
      localStorage.setItem('globetrotter_admin', JSON.stringify(adminData));
      return true;
    }
    return false;
  };

  const logout = () => {
    setAdmin(null);
    localStorage.removeItem('globetrotter_admin');
  };

  return (
    <AuthContext.Provider value={{ 
      admin, 
      isAuthenticated: !!admin, 
      isLoading,
      login, 
      logout 
    }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}