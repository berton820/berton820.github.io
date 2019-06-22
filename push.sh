now_data=$(date)
echo $now_data
git add .
git commit -m "$now_data"
git push
