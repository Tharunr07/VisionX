// Mock Users Data
export const mockUsers = [
  { id: 'USR001', name: 'Emma Wilson', email: 'emma.w@email.com', trips: 12, status: 'active', joinDate: '2024-01-15' },
  { id: 'USR002', name: 'James Rodriguez', email: 'james.r@email.com', trips: 8, status: 'active', joinDate: '2024-02-03' },
  { id: 'USR003', name: 'Sophie Chen', email: 'sophie.c@email.com', trips: 15, status: 'active', joinDate: '2023-11-20' },
  { id: 'USR004', name: 'Michael Brown', email: 'michael.b@email.com', trips: 3, status: 'disabled', joinDate: '2024-03-10' },
  { id: 'USR005', name: 'Olivia Davis', email: 'olivia.d@email.com', trips: 22, status: 'active', joinDate: '2023-08-15' },
  { id: 'USR006', name: 'Liam Johnson', email: 'liam.j@email.com', trips: 6, status: 'active', joinDate: '2024-04-22' },
  { id: 'USR007', name: 'Ava Martinez', email: 'ava.m@email.com', trips: 9, status: 'active', joinDate: '2024-01-08' },
  { id: 'USR008', name: 'Noah Garcia', email: 'noah.g@email.com', trips: 1, status: 'disabled', joinDate: '2024-05-01' },
  { id: 'USR009', name: 'Isabella Lee', email: 'isabella.l@email.com', trips: 18, status: 'active', joinDate: '2023-09-12' },
  { id: 'USR010', name: 'Ethan Kim', email: 'ethan.k@email.com', trips: 11, status: 'active', joinDate: '2024-02-28' },
];

// Dashboard Metrics
export const dashboardMetrics = {
  totalUsers: 2847,
  totalTrips: 8234,
  activeTrips: 342,
  sharedTrips: 1256,
  avgBudget: 2450,
  trends: {
    users: { value: 12.5, isUp: true },
    trips: { value: 8.3, isUp: true },
    activeTrips: { value: 5.2, isUp: false },
    sharedTrips: { value: 15.7, isUp: true },
    avgBudget: { value: 3.1, isUp: true },
  }
};

// Trips Over Time (Monthly)
export const tripsOverTime = [
  { month: 'Jan', trips: 420, shared: 89 },
  { month: 'Feb', trips: 380, shared: 72 },
  { month: 'Mar', trips: 510, shared: 105 },
  { month: 'Apr', trips: 590, shared: 128 },
  { month: 'May', trips: 680, shared: 156 },
  { month: 'Jun', trips: 820, shared: 198 },
  { month: 'Jul', trips: 950, shared: 234 },
  { month: 'Aug', trips: 890, shared: 212 },
  { month: 'Sep', trips: 720, shared: 167 },
  { month: 'Oct', trips: 650, shared: 145 },
  { month: 'Nov', trips: 580, shared: 121 },
  { month: 'Dec', trips: 710, shared: 168 },
];

// Trips Per User Distribution
export const tripsPerUser = [
  { range: '1-2', count: 856 },
  { range: '3-5', count: 1234 },
  { range: '6-10', count: 498 },
  { range: '11-20', count: 187 },
  { range: '21+', count: 72 },
];

// Trip Duration Distribution
export const tripDurations = [
  { duration: '1-3 days', count: 1245, percentage: 35 },
  { duration: '4-7 days', count: 1823, percentage: 45 },
  { duration: '8-14 days', count: 567, percentage: 15 },
  { duration: '15+ days', count: 189, percentage: 5 },
];

// Top Cities
export const topCities = [
  { name: 'Agra', count: 1247, avgCost: 1850 },
  { name: 'Karnataka', count: 1089, avgCost: 2340 },
  { name: 'Kerala', count: 987, avgCost: 2150 },
  { name: 'Goa', count: 876, avgCost: 1920 },
  { name: 'Manali', count: 765, avgCost: 1450 },
  { name: 'Andaman Island', count: 698, avgCost: 1380 },
  { name: 'Jaipur', count: 654, avgCost: 1200 },
  { name: 'Mumbai', count: 598, avgCost: 2890 },
  { name: 'Chikmagaluru', count: 543, avgCost: 2560 },
  { name: 'Coorg', count: 521, avgCost: 1680 },
];

// Top Activities
export const topActivities = [
  { name: 'City Tours', count: 3456, category: 'Sightseeing' },
  { name: 'Beach Days', count: 2987, category: 'Relaxation' },
  { name: 'Museum Visits', count: 2654, category: 'Culture' },
  { name: 'Local Cuisine', count: 2432, category: 'Food' },
  { name: 'Hiking', count: 1987, category: 'Adventure' },
  { name: 'Shopping', count: 1765, category: 'Leisure' },
  { name: 'Nightlife', count: 1543, category: 'Entertainment' },
  { name: 'Photography', count: 1432, category: 'Creative' },
  { name: 'Water Sports', count: 1234, category: 'Adventure' },
  { name: 'Wellness & Spa', count: 987, category: 'Relaxation' },
];

// Daily Active Users (Last 30 days)
export const dailyActiveUsers = [
  { day: '1', users: 234 },
  { day: '2', users: 256 },
  { day: '3', users: 312 },
  { day: '4', users: 287 },
  { day: '5', users: 298 },
  { day: '6', users: 345 },
  { day: '7', users: 389 },
  { day: '8', users: 356 },
  { day: '9', users: 321 },
  { day: '10', users: 298 },
  { day: '11', users: 312 },
  { day: '12', users: 367 },
  { day: '13', users: 423 },
  { day: '14', users: 456 },
  { day: '15', users: 412 },
  { day: '16', users: 398 },
  { day: '17', users: 445 },
  { day: '18', users: 478 },
  { day: '19', users: 512 },
  { day: '20', users: 489 },
  { day: '21', users: 534 },
  { day: '22', users: 567 },
  { day: '23', users: 523 },
  { day: '24', users: 498 },
  { day: '25', users: 534 },
  { day: '26', users: 587 },
  { day: '27', users: 612 },
  { day: '28', users: 589 },
  { day: '29', users: 623 },
  { day: '30', users: 645 },
];

// Feature Usage
export const featureUsage = [
  { name: 'Quiz Completed', value: 67, color: 'hsl(174, 62%, 32%)' },
  { name: 'Skipped Quiz', value: 33, color: 'hsl(220, 15%, 80%)' },
];

export const collaborationUsage = [
  { name: 'Group Trips', value: 42, color: 'hsl(16, 85%, 60%)' },
  { name: 'Solo Trips', value: 58, color: 'hsl(174, 62%, 45%)' },
];

export const snapMemoriesUsage = {
  totalUploads: 45678,
  avgPerTrip: 12.4,
  storageUsed: '234 GB',
  trend: 18.5,
};

// System Info
export const systemInfo = {
  version: '2.4.1',
  lastUpdate: '2025-12-28',
  uptime: '99.97%',
  activeConnections: 1234,
  dbSize: '45.6 GB',
  cacheHitRate: '94.2%',
};