import { PageHeader } from '@/components/dashboard/PageHeader';
import { dailyActiveUsers, featureUsage, collaborationUsage, snapMemoriesUsage } from '@/data/mockData';
import { 
  LineChart, 
  Line, 
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer,
  PieChart,
  Pie,
  Cell
} from 'recharts';
import { Users, CheckCircle, Users2, Camera, TrendingUp } from 'lucide-react';
import { Progress } from '@/components/ui/progress';

export default function AnalyticsPage() {
  return (
    <div className="space-y-8">
      <PageHeader 
        title="User Engagement" 
        description="Track user activity and feature adoption"
      />

      {/* Quick Stats */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up">
          <div className="flex items-center gap-4">
            <div className="p-3 rounded-lg gradient-primary">
              <Users className="h-5 w-5 text-primary-foreground" />
            </div>
            <div>
              <p className="text-2xl font-bold text-foreground">645</p>
              <p className="text-sm text-muted-foreground">Daily Active Users</p>
            </div>
          </div>
        </div>
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '50ms' }}>
          <div className="flex items-center gap-4">
            <div className="p-3 rounded-lg bg-success/10">
              <CheckCircle className="h-5 w-5 text-success" />
            </div>
            <div>
              <p className="text-2xl font-bold text-foreground">67%</p>
              <p className="text-sm text-muted-foreground">Quiz Completion</p>
            </div>
          </div>
        </div>
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '100ms' }}>
          <div className="flex items-center gap-4">
            <div className="p-3 rounded-lg gradient-accent">
              <Users2 className="h-5 w-5 text-accent-foreground" />
            </div>
            <div>
              <p className="text-2xl font-bold text-foreground">42%</p>
              <p className="text-sm text-muted-foreground">Group Collaboration</p>
            </div>
          </div>
        </div>
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '150ms' }}>
          <div className="flex items-center gap-4">
            <div className="p-3 rounded-lg bg-warning/10">
              <Camera className="h-5 w-5 text-warning" />
            </div>
            <div>
              <p className="text-2xl font-bold text-foreground">45.6k</p>
              <p className="text-sm text-muted-foreground">Snap Memories</p>
            </div>
          </div>
        </div>
      </div>

      {/* Daily Active Users Chart */}
      <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '200ms' }}>
        <div className="flex items-center justify-between mb-6">
          <h3 className="text-lg font-semibold text-foreground">Daily Active Users (Last 30 Days)</h3>
          <div className="flex items-center gap-2 text-sm text-success">
            <TrendingUp className="h-4 w-4" />
            <span>+24.5% vs last month</span>
          </div>
        </div>
        <div className="h-80">
          <ResponsiveContainer width="100%" height="100%">
            <LineChart data={dailyActiveUsers}>
              <defs>
                <linearGradient id="dauGradient" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="5%" stopColor="hsl(174, 62%, 32%)" stopOpacity={0.3}/>
                  <stop offset="95%" stopColor="hsl(174, 62%, 32%)" stopOpacity={0}/>
                </linearGradient>
              </defs>
              <CartesianGrid strokeDasharray="3 3" stroke="hsl(214, 20%, 90%)" vertical={false} />
              <XAxis 
                dataKey="day" 
                axisLine={false}
                tickLine={false}
                tick={{ fill: 'hsl(220, 10%, 45%)', fontSize: 11 }}
                interval={2}
              />
              <YAxis 
                axisLine={false}
                tickLine={false}
                tick={{ fill: 'hsl(220, 10%, 45%)', fontSize: 12 }}
              />
              <Tooltip 
                contentStyle={{ 
                  backgroundColor: 'hsl(0, 0%, 100%)', 
                  border: '1px solid hsl(214, 20%, 90%)',
                  borderRadius: '8px',
                  boxShadow: '0 4px 6px -1px hsl(220 25% 10% / 0.1)'
                }}
                labelFormatter={(label) => `Day ${label}`}
              />
              <Line 
                type="monotone" 
                dataKey="users" 
                stroke="hsl(174, 62%, 32%)" 
                strokeWidth={2}
                dot={false}
                activeDot={{ r: 6, fill: 'hsl(174, 62%, 32%)' }}
              />
            </LineChart>
          </ResponsiveContainer>
        </div>
      </div>

      {/* Feature Usage */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Quiz Completion */}
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '250ms' }}>
          <h3 className="text-lg font-semibold text-foreground mb-6">Quiz Completion Rate</h3>
          <div className="h-56">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={featureUsage}
                  cx="50%"
                  cy="50%"
                  innerRadius={50}
                  outerRadius={80}
                  paddingAngle={2}
                  dataKey="value"
                >
                  {featureUsage.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Pie>
                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </div>
          <div className="flex justify-center gap-6 mt-4">
            {featureUsage.map((item) => (
              <div key={item.name} className="flex items-center gap-2">
                <div 
                  className="w-3 h-3 rounded-full" 
                  style={{ backgroundColor: item.color }}
                />
                <span className="text-sm text-muted-foreground">{item.name}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Collaboration Usage */}
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '300ms' }}>
          <h3 className="text-lg font-semibold text-foreground mb-6">Trip Collaboration</h3>
          <div className="h-56">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={collaborationUsage}
                  cx="50%"
                  cy="50%"
                  innerRadius={50}
                  outerRadius={80}
                  paddingAngle={2}
                  dataKey="value"
                >
                  {collaborationUsage.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Pie>
                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </div>
          <div className="flex justify-center gap-6 mt-4">
            {collaborationUsage.map((item) => (
              <div key={item.name} className="flex items-center gap-2">
                <div 
                  className="w-3 h-3 rounded-full" 
                  style={{ backgroundColor: item.color }}
                />
                <span className="text-sm text-muted-foreground">{item.name}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Snap Memories */}
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '350ms' }}>
          <h3 className="text-lg font-semibold text-foreground mb-6">Snap Memories</h3>
          <div className="space-y-6">
            <div>
              <div className="flex items-center justify-between mb-2">
                <span className="text-sm text-muted-foreground">Total Uploads</span>
                <span className="font-semibold text-foreground">{snapMemoriesUsage.totalUploads.toLocaleString()}</span>
              </div>
              <Progress value={78} className="h-2" />
            </div>
            <div>
              <div className="flex items-center justify-between mb-2">
                <span className="text-sm text-muted-foreground">Avg. Per Trip</span>
                <span className="font-semibold text-foreground">{snapMemoriesUsage.avgPerTrip}</span>
              </div>
              <Progress value={62} className="h-2" />
            </div>
            <div>
              <div className="flex items-center justify-between mb-2">
                <span className="text-sm text-muted-foreground">Storage Used</span>
                <span className="font-semibold text-foreground">{snapMemoriesUsage.storageUsed}</span>
              </div>
              <Progress value={47} className="h-2" />
            </div>
            <div className="pt-4 border-t border-border">
              <div className="flex items-center gap-2 text-success">
                <TrendingUp className="h-4 w-4" />
                <span className="text-sm font-medium">+{snapMemoriesUsage.trend}% this month</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}