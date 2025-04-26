#! /bin/sh

# User credentials
#user=admin
#email=admin@example.com
#password=pass
#file=db/db.sqlite3

python3 manage.py migrate

if [[ $(echo "from django.contrib.auth.models import User; print(User.objects.filter(username='$user').exists())" | python3 manage.py shell) == True ]] ; then 
	echo "Superuser $user already exists. Running server..."
else
	echo "from django.contrib.auth.models import User; User.objects.create_superuser('$user', '$email', '$password')" | python3 manage.py shell
	echo "Superuser $user created. Running server..."
fi
