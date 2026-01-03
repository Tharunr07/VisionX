import { LucideIcon, TrendingUp, TrendingDown } from 'lucide-react';
import { cn } from '@/lib/utils';

interface MetricCardProps {
  title: string;
  value: string | number;
  icon: LucideIcon;
  trend?: {
    value: number;
    isUp: boolean;
  };
  delay?: number;
  variant?: 'default' | 'primary' | 'accent';
}

export function MetricCard({ 
  title, 
  value, 
  icon: Icon, 
  trend, 
  delay = 0,
  variant = 'default' 
}: MetricCardProps) {
  return (
    <div 
      className={cn(
        "bg-card rounded-xl p-6 shadow-card hover:shadow-card-hover transition-all duration-300 animate-slide-up border border-border/50",
        variant === 'primary' && "border-primary/20 bg-gradient-to-br from-primary/5 to-transparent",
        variant === 'accent' && "border-accent/20 bg-gradient-to-br from-accent/5 to-transparent"
      )}
      style={{ animationDelay: `${delay}ms` }}
    >
      <div className="flex items-start justify-between mb-4">
        <div className={cn(
          "p-3 rounded-lg",
          variant === 'default' && "bg-muted",
          variant === 'primary' && "gradient-primary",
          variant === 'accent' && "gradient-accent"
        )}>
          <Icon className={cn(
            "h-5 w-5",
            variant === 'default' && "text-muted-foreground",
            variant === 'primary' && "text-primary-foreground",
            variant === 'accent' && "text-accent-foreground"
          )} />
        </div>
        {trend && (
          <div className={cn(
            "flex items-center gap-1 text-sm font-medium px-2 py-1 rounded-full",
            trend.isUp 
              ? "text-success bg-success/10" 
              : "text-destructive bg-destructive/10"
          )}>
            {trend.isUp ? (
              <TrendingUp className="h-3.5 w-3.5" />
            ) : (
              <TrendingDown className="h-3.5 w-3.5" />
            )}
            <span>{trend.value}%</span>
          </div>
        )}
      </div>
      <div>
        <h3 className="text-2xl font-bold text-foreground mb-1">
          {typeof value === 'number' ? value.toLocaleString() : value}
        </h3>
        <p className="text-sm text-muted-foreground">{title}</p>
      </div>
    </div>
  );
}