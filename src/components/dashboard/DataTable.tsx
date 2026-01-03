import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import { cn } from '@/lib/utils';

interface Column<T> {
  key: keyof T | string;
  header: string;
  render?: (item: T) => React.ReactNode;
  className?: string;
}

interface DataTableProps<T> {
  data: T[];
  columns: Column<T>[];
  className?: string;
}

export function DataTable<T extends Record<string, any>>({ 
  data, 
  columns,
  className 
}: DataTableProps<T>) {
  return (
    <div className={cn("rounded-xl border border-border bg-card overflow-hidden shadow-card", className)}>
      <Table>
        <TableHeader>
          <TableRow className="bg-muted/50 hover:bg-muted/50">
            {columns.map((column) => (
              <TableHead 
                key={String(column.key)} 
                className={cn("font-semibold text-foreground", column.className)}
              >
                {column.header}
              </TableHead>
            ))}
          </TableRow>
        </TableHeader>
        <TableBody>
          {data.map((item, index) => (
            <TableRow 
              key={index}
              className="hover:bg-muted/30 transition-colors"
            >
              {columns.map((column) => (
                <TableCell 
                  key={String(column.key)}
                  className={column.className}
                >
                  {column.render 
                    ? column.render(item) 
                    : String(item[column.key as keyof T] ?? '')}
                </TableCell>
              ))}
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
}