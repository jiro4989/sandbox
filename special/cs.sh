#!/bin/bash
# -*- coding: utf-8 -*-

for day in 201701 201709 201710 202002; do
  go run mkcal.go $day > $day.html
done

