import { Outlet } from 'react-router-dom';
import { DashboardSidebar } from '@/components/dashboard/DashboardSidebar';

export default function DashboardLayout() {
  return (
    <div className="flex min-h-screen w-full bg-background">
      <DashboardSidebar />
      <main className="flex-1 overflow-auto">
        <div className="p-6 lg:p-8 max-w-7xl mx-auto">
          <Outlet />
        </div>
      </main>
    </div>
  );
}