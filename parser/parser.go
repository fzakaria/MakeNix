package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"text/template"
)

type CompileUnit struct {
	SrcFile    string
	HeaderDeps []string
	ObjFile    string
}

func parseDepFile(depFile string) (CompileUnit, error) {
	data, err := os.ReadFile(depFile)
	if err != nil {
		return CompileUnit{}, err
	}

	lines := strings.Split(string(data), "\n")
	if len(lines) < 1 {
		return CompileUnit{}, fmt.Errorf("empty or invalid dep file: %s", depFile)
	}

	parts := strings.SplitN(lines[0], ":", 2)
	if len(parts) < 2 {
		return CompileUnit{}, fmt.Errorf("invalid format in: %s", depFile)
	}

	target := strings.TrimSpace(parts[0])
	deps := strings.Fields(parts[1])
	if len(deps) < 1 {
		return CompileUnit{}, fmt.Errorf("no deps found in: %s", depFile)
	}

	return CompileUnit{
		SrcFile:    filepath.Base(deps[0]),
		HeaderDeps: deps[1:],
		ObjFile:    filepath.Base(strings.TrimSuffix(target, ":")),
	}, nil
}

func main() {
	depFiles, err := filepath.Glob("src/*.d")
	if err != nil {
		panic(err)
	}

	var units []CompileUnit
	for _, depFile := range depFiles {
		unit, err := parseDepFile(depFile)
		if err != nil {
			panic(err)
		}
		units = append(units, unit)
	}

	tmpl, err := template.ParseFiles("parser/derivation.gotmpl")
	if err != nil {
		panic(err)
	}

	err = tmpl.Execute(os.Stdout, units)
	if err != nil {
		panic(err)
	}
}
