import os
#import readthedocs.settings.dev as config
from django.contrib.auth.models import User

print("django-rtd-create-users")
try:
    user = User.objects.create_superuser(
        # config.ADMIN_USERNAME,
        # config.ADMIN_EMAIL,
        # config.ADMIN_PASSWORD
        "admin",
        "admin@localhost",
        "admin"
    )
    user.save()
    #print("Created {0} superuser password {1} email {2}".format(config.ADMIN_USERNAME,config.ADMIN_PASSWORD,config.ADMIN_EMAIL))
except Exception as e:
    print("exception {0}".format(e))
    #print("Failed to create {0} user".format(config.ADMIN_USERNAME))
