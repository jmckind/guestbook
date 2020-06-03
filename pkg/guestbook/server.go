// Copyright 2020 John McKenzie
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// 	http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package guestbook

import (
	"html/template"
	"io"
	"log"
	"net/http"
	"time"
)

const (
	defaultListenAddress = "0.0.0.0:4778"
)

// Entry represents a guestbook entry.
type Entry struct {
	// Author is the name for the entry.
	Author string `json:"username"`

	// Content is the message for the guestbook entry.
	Content string `json:"message"`

	// Created is the date/time when the entry was created.
	Created time.Time `json:"created,omitempty"`
}

// Guestbook application.
type Guestbook struct {
	// Entries is the list of guestbook entries.
	Entries []Entry

	// ListenAddress is the address (including port) the application will listen to for requests.
	ListenAddress string
}

// NewGuestbook will create a new Guestbook.
func NewGuestbook() *Guestbook {
	return &Guestbook{
		Entries:       make([]Entry, 0),
		ListenAddress: defaultListenAddress,
	}
}

// Start will set up handler and begin listening for connections.
func (g *Guestbook) Start() {
	http.HandleFunc("/", g.handle)
	log.Printf("guestbook listening at %s", g.ListenAddress)
	log.Fatal(http.ListenAndServe(g.ListenAddress, nil))
}

// handle will call the appropriate handler based on the URL and HTTP method.
func (g *Guestbook) handle(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		w.WriteHeader(http.StatusNotFound)
		io.WriteString(w, "The requested resource could not be located.")
		return
	}

	switch r.Method {
	case http.MethodGet:
		g.display(w, r)
	case http.MethodPost:
		g.post(w, r)
	default:
		w.WriteHeader(http.StatusMethodNotAllowed)
		io.WriteString(w, "Method not allowed for this resource.")
	}
}

// display will handle requests for the list of guestbook entries.
func (g *Guestbook) display(w http.ResponseWriter, r *http.Request) {
	tmpl, _ := template.ParseFiles("templates/index.html.tpl")
	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	tmpl.Execute(w, map[string]interface{}{
		"Title":   "Guestbook",
		"Entries": g.Entries,
	})
}

// post will handle requests to create a new guestbook entry.
func (g *Guestbook) post(w http.ResponseWriter, r *http.Request) {
	g.save(&Entry{
		Author:  r.FormValue("author"),
		Content: r.FormValue("content"),
		Created: time.Now().UTC(),
	})
	http.Redirect(w, r, "/", http.StatusSeeOther)
}

// save will persist the given guestbook entry.
func (g *Guestbook) save(entry *Entry) {
	g.Entries = append(g.Entries, *entry)
}
