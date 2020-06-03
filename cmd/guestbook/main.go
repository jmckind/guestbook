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

package main

import (
	"log"
	"runtime"

	"github.com/jmckind/guestbook/pkg/guestbook"
)

func main() {
	printVersion()
	gb := guestbook.NewGuestbook()
	gb.Start()
}

func printVersion() {
	log.Printf("go version: %s", runtime.Version())
	log.Printf("go os/arch: %s/%s", runtime.GOOS, runtime.GOARCH)
	log.Printf("guestbook version: %s", guestbook.Version)
}
