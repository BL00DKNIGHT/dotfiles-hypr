#!/bin/bash
echo $(swww query | awk '{print $8}')
