from django.core.management.base import BaseCommand, CommandError
from github import processing
import datetime
from github.models import GitHubRequestCache

class Command(BaseCommand):

    def handle(self, *args, **options):
        """
        Process as many items in the queue, until the time limit specified via args[0] in seconds has been exceeded.
        """
        if len(args) > 0:
            duration = int(args[0])
        else:
            duration = 1
        
        endAt = datetime.datetime.now() + datetime.timedelta(0,duration)
        count = 0
        self.stdout.write(str(endAt) + ' ' + str(datetime.datetime.now()))
        # while duration is not expired
        while endAt > datetime.datetime.now():
            # execute commands
            processing.ProcessGitHubRequest(1)
            count+=1
            
            itemsInCache = GitHubRequestCache.objects.filter(started_at__isnull = True).order_by('created_at').count()
            
            # unless there are no commands to execute
            if itemsInCache == 0:
                self.stdout.write('No more commands to run.')
                break
        
        self.stdout.write('Processed {0} requests.'.format(count))