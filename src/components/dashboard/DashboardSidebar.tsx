import { NavLink, useLocation } from 'react-router-dom';
import { 
  LayoutDashboard, 
  Users, 
  Plane, 
  MapPin, 
  BarChart3, 
  Settings, 
  LogOut,
  Globe,
  ChevronLeft,
  ChevronRight
} from 'lucide-react';
import { useAuth } from '@/contexts/AuthContext';
import { cn } from '@/lib/utils';
import { useState } from 'react';
import { Button } from '@/components/ui/button';
import { Avatar, AvatarFallback } from '@/components/ui/avatar';

const navItems = [
  { path: '/dashboard', label: 'Overview', icon: LayoutDashboard },
  { path: '/dashboard/users', label: 'Users', icon: Users },
  { path: '/dashboard/trips', label: 'Trips', icon: Plane },
  { path: '/dashboard/cities', label: 'Cities & Activities', icon: MapPin },
  { path: '/dashboard/analytics', label: 'Analytics', icon: BarChart3 },
  { path: '/dashboard/settings', label: 'Settings', icon: Settings },
];

export function DashboardSidebar() {
  const { admin, logout } = useAuth();
  const location = useLocation();
  const [collapsed, setCollapsed] = useState(false);

  const isActive = (path: string) => {
    if (path === '/dashboard') {
      return location.pathname === '/dashboard';
    }
    return location.pathname.startsWith(path);
  };

  return (
    <aside 
      className={cn(
        "gradient-sidebar h-screen flex flex-col transition-all duration-300 ease-in-out relative",
        collapsed ? "w-20" : "w-64"
      )}
    >
      {/* Collapse Button */}
      <Button
        variant="ghost"
        size="icon"
        onClick={() => setCollapsed(!collapsed)}
        className="absolute -right-3 top-8 z-50 h-6 w-6 rounded-full border border-border bg-card shadow-md hover:bg-muted"
      >
        {collapsed ? (
          <ChevronRight className="h-3 w-3" />
        ) : (
          <ChevronLeft className="h-3 w-3" />
        )}
      </Button>

      {/* Logo */}
      <div className={cn(
        "flex items-center gap-3 px-6 py-6 border-b border-sidebar-border",
        collapsed && "justify-center px-4"
      )}>
        <div className="h-10 w-10 rounded-xl gradient-primary flex items-center justify-center shadow-glow">
          <Globe className="h-5 w-5 text-primary-foreground" />
        </div>
        {!collapsed && (
          <div className="flex flex-col">
            <span className="font-bold text-lg text-sidebar-accent-foreground tracking-tight">
              CO TRAVEL
            </span>
            <span className="text-xs text-sidebar-muted">Admin Dashboard</span>
          </div>
        )}
      </div>

      {/* Navigation */}
      <nav className="flex-1 py-6 px-3 space-y-1 overflow-y-auto">
        {navItems.map((item) => (
          <NavLink
            key={item.path}
            to={item.path}
            end={item.path === '/dashboard'}
            className={cn(
              "flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-200 group",
              collapsed && "justify-center px-3",
              isActive(item.path) 
                ? "bg-sidebar-primary/10 text-sidebar-primary" 
                : "text-sidebar-foreground hover:bg-sidebar-accent hover:text-sidebar-accent-foreground"
            )}
          >
            <item.icon className={cn(
              "h-5 w-5 flex-shrink-0 transition-transform group-hover:scale-110",
              isActive(item.path) && "text-sidebar-primary"
            )} />
            {!collapsed && (
              <span className="font-medium">{item.label}</span>
            )}
            {isActive(item.path) && !collapsed && (
              <div className="ml-auto w-1.5 h-1.5 rounded-full bg-sidebar-primary" />
            )}
          </NavLink>
        ))}
      </nav>

      {/* User Section */}
      <div className={cn(
        "border-t border-sidebar-border p-4",
        collapsed && "px-3"
      )}>
        <div className={cn(
          "flex items-center gap-3 mb-3",
          collapsed && "justify-center"
        )}>
          <Avatar className="h-10 w-10 border-2 border-sidebar-primary/30">
            <AvatarFallback className="bg-sidebar-primary/20 text-sidebar-primary font-semibold">
              {admin?.avatar || admin?.name?.slice(0, 2).toUpperCase()}
            </AvatarFallback>
          </Avatar>
          {!collapsed && (
            <div className="flex-1 min-w-0">
              <p className="text-sm font-medium text-sidebar-accent-foreground truncate">
                {admin?.name}
              </p>
              <p className="text-xs text-sidebar-muted truncate">
                {admin?.role === 'super_admin' ? 'Super Admin' : 'Admin'}
              </p>
            </div>
          )}
        </div>
        <Button
          variant="ghost"
          onClick={logout}
          className={cn(
            "w-full text-sidebar-foreground hover:text-destructive hover:bg-destructive/10 transition-colors",
            collapsed ? "px-3" : "justify-start gap-3"
          )}
        >
          <LogOut className="h-4 w-4" />
          {!collapsed && <span>Logout</span>}
        </Button>
      </div>
    </aside>
  );
}