// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0

package geodataRepository

type Building struct {
	ID    int64       `json:"id"`
	Name  string      `json:"name"`
	Attr  []byte      `json:"attr"`
	Geom  interface{} `json:"geom"`
	DocID *int64      `json:"docId"`
}

type DocumentIndex struct {
	ID int64 `json:"id"`
}

type Door struct {
	ID    int64       `json:"id"`
	RoomA int64       `json:"roomA"`
	RoomB int64       `json:"roomB"`
	Attr  []byte      `json:"attr"`
	Geom  interface{} `json:"geom"`
}

type Level struct {
	ID         int64       `json:"id"`
	BuildingID int64       `json:"buildingId"`
	Name       string      `json:"name"`
	Attr       []byte      `json:"attr"`
	Geom       interface{} `json:"geom"`
	DocID      *int64      `json:"docId"`
}

type Room struct {
	ID      int64       `json:"id"`
	LevelID int64       `json:"levelId"`
	Name    string      `json:"name"`
	Attr    []byte      `json:"attr"`
	Geom    interface{} `json:"geom"`
	DocID   *int64      `json:"docId"`
}
