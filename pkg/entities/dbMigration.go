package entities

import "time"

type DatabaseMigration struct {
	Index     int
	Name      string
	CreatedAt *time.Time
}
