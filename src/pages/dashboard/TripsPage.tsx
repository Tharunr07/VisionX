import { PageHeader } from '@/components/dashboard/PageHeader';
import { tripsOverTime, tripsPerUser, tripDurations } from '@/data/mockData';
import { 
  AreaChart, 
  Area, 
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer,
  BarChart,
  Bar,
  PieChart,
  Pie,
  Cell,
  Legend
} from 'recharts';
import { Plane, Share2, Lock, Clock } from 'lucide-react';

const COLORS = ['hsl(174, 62%, 32%)', 'hsl(16, 85%, 60%)', 'hsl(38, 92%, 50%)', 'hsl(152, 60%, 42%)'];

export default function TripsPage() {
  return (
    <div className="space-y-8">
      <PageHeader 
        title="Trip Analytics" 
        description="Analyze trip creation patterns and user behavior"
      />

      {/* Summary Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up">
          <div className="flex items-center gap-4">
            <div className="p-3 rounded-lg gradient-primary">
              <Plane className="h-5 w-5 text-primary-foreground" />
            </div>
            <div>
              <p className="text-2xl font-bold text-foreground">8,234</p>
              <p className="text-sm text-muted-foreground">Total Trips</p>
            </div>
          </div>
        </div>
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '50ms' }}>
          <div className="flex items-center gap-4">
            <div className="p-3 rounded-lg gradient-accent">
              <Share2 className="h-5 w-5 text-accent-foreground" />
            </div>
            <div>
              <p className="text-2xl font-bold text-foreground">1,256</p>
              <p className="text-sm text-muted-foreground">Shared Trips</p>
            </div>
          </div>
        </div>
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '100ms' }}>
          <div className="flex items-center gap-4">
            <div className="p-3 rounded-lg bg-muted">
              <Lock className="h-5 w-5 text-muted-foreground" />
            </div>
            <div>
              <p className="text-2xl font-bold text-foreground">6,978</p>
              <p className="text-sm text-muted-foreground">Private Trips</p>
            </div>
          </div>
        </div>
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '150ms' }}>
          <div className="flex items-center gap-4">
            <div className="p-3 rounded-lg bg-success/10">
              <Clock className="h-5 w-5 text-success" />
            </div>
            <div>
              <p className="text-2xl font-bold text-foreground">5.2 days</p>
              <p className="text-sm text-muted-foreground">Avg. Duration</p>
            </div>
          </div>
        </div>
      </div>

      {/* Main Charts */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Trips Over Time */}
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '200ms' }}>
          <h3 className="text-lg font-semibold text-foreground mb-6">Trips Created Over Time</h3>
          <div className="h-80">
            <ResponsiveContainer width="100%" height="100%">
              <AreaChart data={tripsOverTime}>
                <defs>
                  <linearGradient id="tripGradient" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="hsl(174, 62%, 32%)" stopOpacity={0.4}/>
                    <stop offset="95%" stopColor="hsl(174, 62%, 32%)" stopOpacity={0}/>
                  </linearGradient>
                  <linearGradient id="sharedGradient" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="hsl(16, 85%, 60%)" stopOpacity={0.4}/>
                    <stop offset="95%" stopColor="hsl(16, 85%, 60%)" stopOpacity={0}/>
                  </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" stroke="hsl(214, 20%, 90%)" vertical={false} />
                <XAxis 
                  dataKey="month" 
                  axisLine={false}
                  tickLine={false}
                  tick={{ fill: 'hsl(220, 10%, 45%)', fontSize: 12 }}
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
                />
                <Legend />
                <Area 
                  type="monotone" 
                  dataKey="trips" 
                  name="Total Trips"
                  stroke="hsl(174, 62%, 32%)" 
                  strokeWidth={2}
                  fill="url(#tripGradient)" 
                />
                <Area 
                  type="monotone" 
                  dataKey="shared" 
                  name="Shared Trips"
                  stroke="hsl(16, 85%, 60%)" 
                  strokeWidth={2}
                  fill="url(#sharedGradient)" 
                />
              </AreaChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* Trips Per User */}
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '250ms' }}>
          <h3 className="text-lg font-semibold text-foreground mb-6">Trips Per User Distribution</h3>
          <div className="h-80">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={tripsPerUser}>
                <CartesianGrid strokeDasharray="3 3" stroke="hsl(214, 20%, 90%)" vertical={false} />
                <XAxis 
                  dataKey="range" 
                  axisLine={false}
                  tickLine={false}
                  tick={{ fill: 'hsl(220, 10%, 45%)', fontSize: 12 }}
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
                />
                <Bar 
                  dataKey="count" 
                  fill="hsl(174, 62%, 32%)" 
                  radius={[4, 4, 0, 0]}
                />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>

      {/* Trip Duration */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '300ms' }}>
          <h3 className="text-lg font-semibold text-foreground mb-6">Trip Duration Distribution</h3>
          <div className="h-72">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={tripDurations}
                  cx="50%"
                  cy="50%"
                  innerRadius={60}
                  outerRadius={100}
                  paddingAngle={2}
                  dataKey="count"
                  nameKey="duration"
                  label={({ duration, percentage }) => `${duration} (${percentage}%)`}
                  labelLine={false}
                >
                  {tripDurations.map((_, index) => (
                    <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                  ))}
                </Pie>
                <Tooltip 
                  contentStyle={{ 
                    backgroundColor: 'hsl(0, 0%, 100%)', 
                    border: '1px solid hsl(214, 20%, 90%)',
                    borderRadius: '8px',
                    boxShadow: '0 4px 6px -1px hsl(220 25% 10% / 0.1)'
                  }}
                />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* Duration Details */}
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '350ms' }}>
          <h3 className="text-lg font-semibold text-foreground mb-6">Duration Breakdown</h3>
          <div className="space-y-4">
            {tripDurations.map((item, index) => (
              <div key={item.duration} className="space-y-2">
                <div className="flex items-center justify-between">
                  <span className="text-sm font-medium text-foreground">{item.duration}</span>
                  <span className="text-sm text-muted-foreground">{item.count.toLocaleString()} trips ({item.percentage}%)</span>
                </div>
                <div className="h-2 bg-muted rounded-full overflow-hidden">
                  <div 
                    className="h-full rounded-full transition-all duration-500"
                    style={{ 
                      width: `${item.percentage}%`,
                      backgroundColor: COLORS[index % COLORS.length]
                    }}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}