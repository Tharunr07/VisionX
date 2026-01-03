import { useState } from 'react';
import { PageHeader } from '@/components/dashboard/PageHeader';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Switch } from '@/components/ui/switch';
import { Separator } from '@/components/ui/separator';
import { Avatar, AvatarFallback } from '@/components/ui/avatar';
import { systemInfo } from '@/data/mockData';
import { useToast } from '@/hooks/use-toast';
import { User, Shield, Eye, Bell, Database, Server, Save } from 'lucide-react';

export default function SettingsPage() {
  const { admin } = useAuth();
  const { toast } = useToast();
  
  const [profile, setProfile] = useState({
    name: admin?.name || '',
    email: admin?.email || '',
  });
  
  const [budgetLimits, setBudgetLimits] = useState({
    default: 2500,
    minimum: 500,
    maximum: 50000,
  });
  
  const [features, setFeatures] = useState({
    quizFeature: true,
    groupCollaboration: true,
    snapMemories: true,
    aiRecommendations: false,
    socialSharing: true,
  });

  const handleSave = () => {
    toast({
      title: "Settings saved",
      description: "Your preferences have been updated successfully.",
    });
  };

  return (
    <div className="space-y-8">
      <PageHeader 
        title="Admin Settings" 
        description="Manage your account and platform settings"
      />

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Left Column - Profile & Budget */}
        <div className="lg:col-span-2 space-y-6">
          {/* Profile Section */}
          <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up">
            <div className="flex items-center gap-3 mb-6">
              <div className="p-2 rounded-lg gradient-primary">
                <User className="h-5 w-5 text-primary-foreground" />
              </div>
              <h3 className="text-lg font-semibold text-foreground">Admin Profile</h3>
            </div>
            
            <div className="flex items-start gap-6">
              <Avatar className="h-20 w-20 border-4 border-primary/20">
                <AvatarFallback className="bg-primary/10 text-primary text-xl font-bold">
                  {admin?.avatar || admin?.name?.slice(0, 2).toUpperCase()}
                </AvatarFallback>
              </Avatar>
              
              <div className="flex-1 space-y-4">
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="name">Full Name</Label>
                    <Input
                      id="name"
                      value={profile.name}
                      onChange={(e) => setProfile(p => ({ ...p, name: e.target.value }))}
                      className="bg-muted/50"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="email">Email Address</Label>
                    <Input
                      id="email"
                      type="email"
                      value={profile.email}
                      onChange={(e) => setProfile(p => ({ ...p, email: e.target.value }))}
                      className="bg-muted/50"
                    />
                  </div>
                </div>
                <div className="flex items-center gap-2">
                  <Shield className="h-4 w-4 text-primary" />
                  <span className="text-sm text-muted-foreground">
                    Role: {admin?.role === 'super_admin' ? 'Super Admin' : 'Admin'}
                  </span>
                </div>
              </div>
            </div>
          </div>

          {/* Budget Limits */}
          <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '50ms' }}>
            <div className="flex items-center gap-3 mb-6">
              <div className="p-2 rounded-lg bg-success/10">
                <Bell className="h-5 w-5 text-success" />
              </div>
              <h3 className="text-lg font-semibold text-foreground">Default Budget Limits</h3>
            </div>
            
            <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
              <div className="space-y-2">
                <Label htmlFor="default-budget">Default Budget</Label>
                <div className="relative">
                  <span className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground">$</span>
                  <Input
                    id="default-budget"
                    type="number"
                    value={budgetLimits.default}
                    onChange={(e) => setBudgetLimits(b => ({ ...b, default: Number(e.target.value) }))}
                    className="pl-8 bg-muted/50"
                  />
                </div>
              </div>
              <div className="space-y-2">
                <Label htmlFor="min-budget">Minimum Budget</Label>
                <div className="relative">
                  <span className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground">$</span>
                  <Input
                    id="min-budget"
                    type="number"
                    value={budgetLimits.minimum}
                    onChange={(e) => setBudgetLimits(b => ({ ...b, minimum: Number(e.target.value) }))}
                    className="pl-8 bg-muted/50"
                  />
                </div>
              </div>
              <div className="space-y-2">
                <Label htmlFor="max-budget">Maximum Budget</Label>
                <div className="relative">
                  <span className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground">$</span>
                  <Input
                    id="max-budget"
                    type="number"
                    value={budgetLimits.maximum}
                    onChange={(e) => setBudgetLimits(b => ({ ...b, maximum: Number(e.target.value) }))}
                    className="pl-8 bg-muted/50"
                  />
                </div>
              </div>
            </div>
          </div>

          {/* Feature Toggles */}
          <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '100ms' }}>
            <div className="flex items-center gap-3 mb-6">
              <div className="p-2 rounded-lg gradient-accent">
                <Eye className="h-5 w-5 text-accent-foreground" />
              </div>
              <h3 className="text-lg font-semibold text-foreground">Feature Visibility</h3>
            </div>
            
            <div className="space-y-4">
              {[
                { key: 'quizFeature', label: 'Travel Quiz', description: 'Personalized travel preference quiz' },
                { key: 'groupCollaboration', label: 'Group Collaboration', description: 'Allow users to plan trips together' },
                { key: 'snapMemories', label: 'Snap Memories', description: 'Photo upload and sharing feature' },
                { key: 'aiRecommendations', label: 'AI Recommendations', description: 'AI-powered destination suggestions' },
                { key: 'socialSharing', label: 'Social Sharing', description: 'Share trips on social media' },
              ].map((feature) => (
                <div key={feature.key} className="flex items-center justify-between py-2">
                  <div>
                    <p className="font-medium text-foreground">{feature.label}</p>
                    <p className="text-sm text-muted-foreground">{feature.description}</p>
                  </div>
                  <Switch
                    checked={features[feature.key as keyof typeof features]}
                    onCheckedChange={(checked) => 
                      setFeatures(f => ({ ...f, [feature.key]: checked }))
                    }
                  />
                </div>
              ))}
            </div>
          </div>

          <Button onClick={handleSave} className="gradient-primary text-primary-foreground shadow-glow">
            <Save className="h-4 w-4 mr-2" />
            Save Changes
          </Button>
        </div>

        {/* Right Column - System Info */}
        <div className="space-y-6">
          <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '150ms' }}>
            <div className="flex items-center gap-3 mb-6">
              <div className="p-2 rounded-lg bg-muted">
                <Server className="h-5 w-5 text-muted-foreground" />
              </div>
              <h3 className="text-lg font-semibold text-foreground">System Info</h3>
            </div>
            
            <div className="space-y-4">
              <div className="flex items-center justify-between py-2 border-b border-border">
                <span className="text-sm text-muted-foreground">Version</span>
                <span className="font-mono text-sm text-foreground">{systemInfo.version}</span>
              </div>
              <div className="flex items-center justify-between py-2 border-b border-border">
                <span className="text-sm text-muted-foreground">Last Update</span>
                <span className="text-sm text-foreground">{systemInfo.lastUpdate}</span>
              </div>
              <div className="flex items-center justify-between py-2 border-b border-border">
                <span className="text-sm text-muted-foreground">Uptime</span>
                <span className="text-sm font-medium text-success">{systemInfo.uptime}</span>
              </div>
              <div className="flex items-center justify-between py-2 border-b border-border">
                <span className="text-sm text-muted-foreground">Active Connections</span>
                <span className="text-sm text-foreground">{systemInfo.activeConnections.toLocaleString()}</span>
              </div>
            </div>
          </div>

          <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '200ms' }}>
            <div className="flex items-center gap-3 mb-6">
              <div className="p-2 rounded-lg bg-primary/10">
                <Database className="h-5 w-5 text-primary" />
              </div>
              <h3 className="text-lg font-semibold text-foreground">Database</h3>
            </div>
            
            <div className="space-y-4">
              <div className="flex items-center justify-between py-2 border-b border-border">
                <span className="text-sm text-muted-foreground">Database Size</span>
                <span className="font-mono text-sm text-foreground">{systemInfo.dbSize}</span>
              </div>
              <div className="flex items-center justify-between py-2">
                <span className="text-sm text-muted-foreground">Cache Hit Rate</span>
                <span className="text-sm font-medium text-success">{systemInfo.cacheHitRate}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}