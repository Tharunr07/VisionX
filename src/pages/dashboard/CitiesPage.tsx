import { PageHeader } from '@/components/dashboard/PageHeader';
import { topCities, topActivities } from '@/data/mockData';
import { 
  BarChart, 
  Bar, 
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer 
} from 'recharts';
import { MapPin, Star, DollarSign, Activity } from 'lucide-react';
import { Badge } from '@/components/ui/badge';

export default function CitiesPage() {
  const maxCityCount = Math.max(...topCities.map(c => c.count));
  const maxActivityCount = Math.max(...topActivities.map(a => a.count));

  return (
    <div className="space-y-8">
      <PageHeader 
        title="Cities & Activities" 
        description="Discover trending destinations and popular activities"
      />

      {/* Top Cities */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up">
          <div className="flex items-center gap-3 mb-6">
            <div className="p-2 rounded-lg gradient-primary">
              <MapPin className="h-5 w-5 text-primary-foreground" />
            </div>
            <h3 className="text-lg font-semibold text-foreground">Top 10 Cities</h3>
          </div>
          <div className="h-96">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={topCities} layout="vertical">
                <CartesianGrid strokeDasharray="3 3" stroke="hsl(214, 20%, 90%)" horizontal={false} />
                <XAxis 
                  type="number"
                  axisLine={false}
                  tickLine={false}
                  tick={{ fill: 'hsl(220, 10%, 45%)', fontSize: 11 }}
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
                  formatter={(value: number) => [value.toLocaleString(), 'Trips']}
                />
                <Bar 
                  dataKey="count" 
                  fill="hsl(174, 62%, 32%)" 
                  radius={[0, 4, 4, 0]}
                />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* City Rankings */}
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '50ms' }}>
          <div className="flex items-center gap-3 mb-6">
            <div className="p-2 rounded-lg gradient-accent">
              <DollarSign className="h-5 w-5 text-accent-foreground" />
            </div>
            <h3 className="text-lg font-semibold text-foreground">City Details</h3>
          </div>
          <div className="space-y-3 overflow-y-auto max-h-96">
            {topCities.map((city, index) => (
              <div 
                key={city.name}
                className="flex items-center gap-4 p-3 rounded-lg hover:bg-muted/50 transition-colors"
              >
                <div className="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center flex-shrink-0">
                  <span className="text-sm font-bold text-primary">{index + 1}</span>
                </div>
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2">
                    <span className="font-medium text-foreground">{city.name}</span>
                    {index < 3 && (
                      <Star className="h-4 w-4 text-warning fill-warning" />
                    )}
                  </div>
                  <div className="flex items-center gap-3 mt-1">
                    <span className="text-xs text-muted-foreground">
                      {city.count.toLocaleString()} trips
                    </span>
                    <span className="text-xs text-muted-foreground">•</span>
                    <span className="text-xs text-success font-medium">
                      ${city.avgCost.toLocaleString()} avg
                    </span>
                  </div>
                </div>
                <div className="w-24 h-2 bg-muted rounded-full overflow-hidden">
                  <div 
                    className="h-full gradient-primary rounded-full"
                    style={{ width: `${(city.count / maxCityCount) * 100}%` }}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Top Activities */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '100ms' }}>
          <div className="flex items-center gap-3 mb-6">
            <div className="p-2 rounded-lg bg-success/10">
              <Activity className="h-5 w-5 text-success" />
            </div>
            <h3 className="text-lg font-semibold text-foreground">Top 10 Activities</h3>
          </div>
          <div className="h-96">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={topActivities} layout="vertical">
                <CartesianGrid strokeDasharray="3 3" stroke="hsl(214, 20%, 90%)" horizontal={false} />
                <XAxis 
                  type="number"
                  axisLine={false}
                  tickLine={false}
                  tick={{ fill: 'hsl(220, 10%, 45%)', fontSize: 11 }}
                />
                <YAxis 
                  type="category"
                  dataKey="name"
                  axisLine={false}
                  tickLine={false}
                  tick={{ fill: 'hsl(220, 10%, 45%)', fontSize: 12 }}
                  width={100}
                />
                <Tooltip 
                  contentStyle={{ 
                    backgroundColor: 'hsl(0, 0%, 100%)', 
                    border: '1px solid hsl(214, 20%, 90%)',
                    borderRadius: '8px',
                    boxShadow: '0 4px 6px -1px hsl(220 25% 10% / 0.1)'
                  }}
                  formatter={(value: number) => [value.toLocaleString(), 'Times Added']}
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

        {/* Activity Rankings */}
        <div className="bg-card rounded-xl p-6 shadow-card border border-border/50 animate-slide-up" style={{ animationDelay: '150ms' }}>
          <div className="flex items-center gap-3 mb-6">
            <div className="p-2 rounded-lg bg-warning/10">
              <Star className="h-5 w-5 text-warning" />
            </div>
            <h3 className="text-lg font-semibold text-foreground">Activity Details</h3>
          </div>
          <div className="space-y-3 overflow-y-auto max-h-96">
            {topActivities.map((activity, index) => (
              <div 
                key={activity.name}
                className="flex items-center gap-4 p-3 rounded-lg hover:bg-muted/50 transition-colors"
              >
                <div className="w-8 h-8 rounded-full bg-accent/10 flex items-center justify-center flex-shrink-0">
                  <span className="text-sm font-bold text-accent">{index + 1}</span>
                </div>
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2">
                    <span className="font-medium text-foreground">{activity.name}</span>
                  </div>
                  <div className="flex items-center gap-2 mt-1">
                    <Badge variant="secondary" className="text-xs">
                      {activity.category}
                    </Badge>
                    <span className="text-xs text-muted-foreground">
                      {activity.count.toLocaleString()} times
                    </span>
                  </div>
                </div>
                <div className="w-24 h-2 bg-muted rounded-full overflow-hidden">
                  <div 
                    className="h-full gradient-accent rounded-full"
                    style={{ width: `${(activity.count / maxActivityCount) * 100}%` }}
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