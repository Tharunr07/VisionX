import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Globe, Mail, Lock, ArrowRight, Eye, EyeOff } from 'lucide-react';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { useToast } from '@/hooks/use-toast';

export default function LoginPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const { login } = useAuth();
  const navigate = useNavigate();
  const { toast } = useToast();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    const success = await login(email, password);
    
    if (success) {
      toast({
        title: "Welcome back!",
        description: "Successfully logged into CO TRAVEL Admin with admin@cotravel.com",
      });
      navigate('/dashboard');
    } else {
      toast({
        title: "Login failed",
        description: "Invalid email or password. Try admin@cotravel.com / admin123",
        variant: "destructive",
      });
    }
    setIsLoading(false);
  };

  return (
    <div className="min-h-screen flex">
      {/* Left Panel - Branding */}
      <div className="hidden lg:flex lg:w-1/2 gradient-sidebar relative overflow-hidden">
        {/* Background Pattern */}
        <div className="absolute inset-0 opacity-10">
          <svg className="w-full h-full" xmlns="http://www.w3.org/2000/svg">
            <defs>
              <pattern id="grid" width="40" height="40" patternUnits="userSpaceOnUse">
                <path d="M 40 0 L 0 0 0 40" fill="none" stroke="currentColor" strokeWidth="0.5"/>
              </pattern>
            </defs>
            <rect width="100%" height="100%" fill="url(#grid)" className="text-sidebar-foreground"/>
          </svg>
        </div>
        
        {/* Floating Elements */}
        <div className="absolute top-20 left-20 w-32 h-32 rounded-full bg-sidebar-primary/10 blur-3xl animate-pulse" />
        <div className="absolute bottom-32 right-20 w-48 h-48 rounded-full bg-accent/10 blur-3xl animate-pulse" style={{ animationDelay: '1s' }} />
        
        <div className="relative z-10 flex flex-col items-center justify-center w-full px-12">
          <div className="h-20 w-20 rounded-2xl gradient-primary flex items-center justify-center shadow-glow mb-8">
            <Globe className="h-10 w-10 text-primary-foreground" />
          </div>
          <h1 className="text-4xl font-bold text-sidebar-accent-foreground mb-4 text-center">
            CO TRAVEL
          </h1>
          <p className="text-sidebar-foreground text-center max-w-sm text-lg">
            Admin Dashboard for managing your travel planning platform
          </p>
          
          <div className="mt-12 grid grid-cols-3 gap-8 text-center">
            <div>
              <p className="text-3xl font-bold text-sidebar-primary">2.8k+</p>
              <p className="text-sm text-sidebar-muted mt-1">Active Users</p>
            </div>
            <div>
              <p className="text-3xl font-bold text-sidebar-primary">8.2k+</p>
              <p className="text-sm text-sidebar-muted mt-1">Trips Created</p>
            </div>
            <div>
              <p className="text-3xl font-bold text-sidebar-primary">50+</p>
              <p className="text-sm text-sidebar-muted mt-1">Countries</p>
            </div>
          </div>
        </div>
      </div>

      {/* Right Panel - Login Form */}
      <div className="flex-1 flex items-center justify-center p-8 bg-background">
        <div className="w-full max-w-md animate-fade-in">
          {/* Mobile Logo */}
          <div className="lg:hidden flex items-center justify-center gap-3 mb-12">
            <div className="h-12 w-12 rounded-xl gradient-primary flex items-center justify-center shadow-glow">
              <Globe className="h-6 w-6 text-primary-foreground" />
            </div>
            <span className="font-bold text-2xl text-foreground">CO TRAVEL</span>
          </div>

          <div className="mb-8">
            <h2 className="text-3xl font-bold text-foreground mb-2">Welcome back</h2>
            <p className="text-muted-foreground">
              Sign in to access your admin dashboard
            </p>
          </div>

          <form onSubmit={handleSubmit} className="space-y-6">
            <div className="space-y-2">
              <Label htmlFor="email" className="text-foreground font-medium">
                Email Address
              </Label>
              <div className="relative">
                <Mail className="absolute left-3 top-1/2 -translate-y-1/2 h-5 w-5 text-muted-foreground" />
                <Input
                  id="email"
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="admin@cotravel.com"
                  className="pl-11 h-12 bg-muted/50 border-border focus:border-primary focus:ring-primary/20"
                  required
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="password" className="text-foreground font-medium">
                Password
              </Label>
              <div className="relative">
                <Lock className="absolute left-3 top-1/2 -translate-y-1/2 h-5 w-5 text-muted-foreground" />
                <Input
                  id="password"
                  type={showPassword ? 'text' : 'password'}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="••••••••"
                  className="pl-11 pr-11 h-12 bg-muted/50 border-border focus:border-primary focus:ring-primary/20"
                  required
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
                >
                  {showPassword ? <EyeOff className="h-5 w-5" /> : <Eye className="h-5 w-5" />}
                </button>
              </div>
            </div>

            <Button
              type="submit"
              disabled={isLoading}
              className="w-full h-12 gradient-primary text-primary-foreground font-semibold text-base shadow-glow hover:opacity-90 transition-opacity"
            >
              {isLoading ? (
                <div className="h-5 w-5 border-2 border-primary-foreground/30 border-t-primary-foreground rounded-full animate-spin" />
              ) : (
                <>
                  Sign In
                  <ArrowRight className="ml-2 h-5 w-5" />
                </>
              )}
            </Button>
          </form>

          <div className="mt-8 p-4 rounded-lg bg-muted/50 border border-border">
            <p className="text-sm text-muted-foreground mb-2">Demo Credentials:</p>
            <p className="text-sm font-mono text-foreground">admin@cotravel.com</p>
            <p className="text-sm font-mono text-foreground">admin123</p>
          </div>
        </div>
      </div>
    </div>
  );
}