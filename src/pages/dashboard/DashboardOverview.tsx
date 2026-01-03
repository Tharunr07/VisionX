import { Users, Plane, MapPin, Share2, DollarSign, Calendar } from 'lucide-react';
import { MetricCard } from '@/components/dashboard/MetricCard';
import { PageHeader } from '@/components/dashboard/PageHeader';
import { dashboardMetrics, tripsOverTime, topCities } from '@/data/mockData';
import { 
  AreaChart, 
  Area, 
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer,
  BarChart,
  Bar
} from 'recharts';

export default function DashboardOverview() {
  return (
    <div className="space-y-8">
      <PageHeader
        title="CO TRAVEL Dashboard Overview"
        description="Monitor your platform's key metrics and performance"
      />

      {/* Metrics Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-4">
        <MetricCard
          title="Total Users"
          value={dashboardMetrics.totalUsers}
          icon={Users}
          trend={dashboardMetrics.trends.users}
          delay={0}
          variant="primary"
        />
        <MetricCard
          title="Total Trips"
          value={dashboardMetrics.totalTrips}
          icon={Plane}
          trend={dashboardMetrics.trends.trips}
          delay={50}
        />
        <MetricCard
          title="Active Trips"
          value={dashboardMetrics.activeTrips}
          icon={Calendar}
          trend={dashboardMetrics.trends.activeTrips}
          delay={100}
        />
        <MetricCard
          title="Shared Trips"
          value={dashboardMetrics.sharedTrips}
          icon={Share2}
          trend={dashboardMetrics.trends.sharedTrips}
          delay={150}
          variant="accent"
        />
        <MetricCard
          title="Avg. Budget"
          value={`$${dashboardMetrics.avgBudget.toLocaleString()}`}
          icon={DollarSign}
          trend={dashboardMetrics.trends.avgBudget}
          delay={200}
        />
      </div>

      {/* Charts Row */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Trips Over Time Chart */}
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '250ms' }}>
          <h3 className="text-lg font-semibold text-foreground mb-6">Trips Created Over Time</h3>
          <div className="h-72">
            <ResponsiveContainer width="100%" height="100%">
              <AreaChart data={tripsOverTime}>
                <defs>
                  <linearGradient id="tripsGradient" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="hsl(174, 62%, 32%)" stopOpacity={0.3}/>
                    <stop offset="95%" stopColor="hsl(174, 62%, 32%)" stopOpacity={0}/>
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
                <Area 
                  type="monotone" 
                  dataKey="trips" 
                  stroke="hsl(174, 62%, 32%)" 
                  strokeWidth={2}
                  fill="url(#tripsGradient)" 
                />
              </AreaChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* Top Cities Chart */}
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '300ms' }}>
          <h3 className="text-lg font-semibold text-foreground mb-6">Top Destinations</h3>
          <div className="h-72">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={topCities.slice(0, 6)} layout="vertical">
                <CartesianGrid strokeDasharray="3 3" stroke="hsl(214, 20%, 90%)" horizontal={false} />
                <XAxis 
                  type="number"
                  axisLine={false}
                  tickLine={false}
                  tick={{ fill: 'hsl(220, 10%, 45%)', fontSize: 12 }}
                />
                <YAxis 
                  type="category"
                  dataKey="name"
                  axisLine={false}
                  tickLine={false}
                  tick={{ fill: 'hsl(220, 10%, 45%)', fontSize: 12 }}
                  width={80}
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
                  fill="hsl(16, 85%, 60%)" 
                  radius={[0, 4, 4, 0]}
                />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>

      {/* Quick Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '350ms' }}>
          <div className="flex items-center gap-4">
            <div className="p-3 rounded-lg bg-success/10">
              <MapPin className="h-6 w-6 text-success" />
            </div>
            <div>
              <p className="text-2xl font-bold text-foreground">50+</p>
              <p className="text-sm text-muted-foreground">Countries Visited</p>
            </div>
          </div>
        </div>
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '400ms' }}>
          <div className="flex items-center gap-4">
            <div className="p-3 rounded-lg bg-warning/10">
              <Users className="h-6 w-6 text-warning" />
            </div>
            <div>
              <p className="text-2xl font-bold text-foreground">89%</p>
              <p className="text-sm text-muted-foreground">User Satisfaction</p>
            </div>
          </div>
        </div>
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '450ms' }}>
          <div className="flex items-center gap-4">
            <div className="p-3 rounded-lg bg-primary/10">
              <Plane className="h-6 w-6 text-primary" />
            </div>
            <div>
              <p className="text-2xl font-bold text-foreground">4.2</p>
              <p className="text-sm text-muted-foreground">Avg. Trips per User</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}