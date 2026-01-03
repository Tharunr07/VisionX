import { useState } from 'react';
import { Eye, UserCheck, UserX, Search, Filter } from 'lucide-react';
import { PageHeader } from '@/components/dashboard/PageHeader';
import { DataTable } from '@/components/dashboard/DataTable';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { mockUsers } from '@/data/mockData';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
} from '@/components/ui/dialog';
import { useToast } from '@/hooks/use-toast';

export default function UsersPage() {
  const [users, setUsers] = useState(mockUsers);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedUser, setSelectedUser] = useState<typeof mockUsers[0] | null>(null);
  const { toast } = useToast();

  const filteredUsers = users.filter(user => 
    user.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    user.email.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const toggleUserStatus = (userId: string) => {
    setUsers(prev => prev.map(user => {
      if (user.id === userId) {
        const newStatus = user.status === 'active' ? 'disabled' : 'active';
        toast({
          title: `User ${newStatus === 'active' ? 'enabled' : 'disabled'}`,
          description: `${user.name}'s account has been ${newStatus === 'active' ? 'enabled' : 'disabled'}`,
        });
        return { ...user, status: newStatus };
      }
      return user;
    }));
  };

  const columns = [
    {
      key: 'id',
      header: 'User ID',
      render: (user: typeof mockUsers[0]) => (
        <span className="font-mono text-sm text-muted-foreground">{user.id}</span>
      ),
    },
    {
      key: 'name',
      header: 'Name',
      render: (user: typeof mockUsers[0]) => (
        <span className="font-medium text-foreground">{user.name}</span>
      ),
    },
    {
      key: 'email',
      header: 'Email',
      render: (user: typeof mockUsers[0]) => (
        <span className="text-muted-foreground">{user.email}</span>
      ),
    },
    {
      key: 'trips',
      header: 'Trips',
      render: (user: typeof mockUsers[0]) => (
        <span className="font-semibold text-foreground">{user.trips}</span>
      ),
    },
    {
      key: 'status',
      header: 'Status',
      render: (user: typeof mockUsers[0]) => (
        <Badge 
          variant={user.status === 'active' ? 'default' : 'secondary'}
          className={user.status === 'active' 
            ? 'bg-success/10 text-success hover:bg-success/20' 
            : 'bg-muted text-muted-foreground'
          }
        >
          {user.status === 'active' ? 'Active' : 'Disabled'}
        </Badge>
      ),
    },
    {
      key: 'actions',
      header: 'Actions',
      render: (user: typeof mockUsers[0]) => (
        <div className="flex items-center gap-2">
          <Button
            variant="ghost"
            size="icon"
            onClick={() => setSelectedUser(user)}
            className="h-8 w-8 text-muted-foreground hover:text-foreground"
          >
            <Eye className="h-4 w-4" />
          </Button>
          <Button
            variant="ghost"
            size="icon"
            onClick={() => toggleUserStatus(user.id)}
            className={`h-8 w-8 ${
              user.status === 'active' 
                ? 'text-muted-foreground hover:text-destructive' 
                : 'text-muted-foreground hover:text-success'
            }`}
          >
            {user.status === 'active' ? (
              <UserX className="h-4 w-4" />
            ) : (
              <UserCheck className="h-4 w-4" />
            )}
          </Button>
        </div>
      ),
    },
  ];

  return (
    <div className="space-y-8">
      <PageHeader 
        title="User Management" 
        description="View and manage platform users"
      >
        <Button variant="outline" size="icon">
          <Filter className="h-4 w-4" />
        </Button>
      </PageHeader>

      {/* Search Bar */}
      <div className="relative max-w-md">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
        <Input
          placeholder="Search users by name or email..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="pl-10 bg-card border-border"
        />
      </div>

      {/* Users Table */}
      <DataTable data={filteredUsers} columns={columns} />

      {/* User Details Dialog */}
      <Dialog open={!!selectedUser} onOpenChange={() => setSelectedUser(null)}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>User Details</DialogTitle>
            <DialogDescription>View complete user information</DialogDescription>
          </DialogHeader>
          {selectedUser && (
            <div className="space-y-4 py-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <p className="text-sm text-muted-foreground">User ID</p>
                  <p className="font-mono text-sm">{selectedUser.id}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Status</p>
                  <Badge 
                    variant={selectedUser.status === 'active' ? 'default' : 'secondary'}
                    className={selectedUser.status === 'active' 
                      ? 'bg-success/10 text-success' 
                      : 'bg-muted text-muted-foreground'
                    }
                  >
                    {selectedUser.status === 'active' ? 'Active' : 'Disabled'}
                  </Badge>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Name</p>
                  <p className="font-medium">{selectedUser.name}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Email</p>
                  <p className="text-sm">{selectedUser.email}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Total Trips</p>
                  <p className="font-semibold text-lg">{selectedUser.trips}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Join Date</p>
                  <p className="text-sm">{new Date(selectedUser.joinDate).toLocaleDateString()}</p>
                </div>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
}