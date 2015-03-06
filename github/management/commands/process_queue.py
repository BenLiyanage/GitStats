from django.core.management.base import BaseCommand, CommandError
import github.processing

class Command(BaseCommand):

    def handle(self, *args, **options):
        """
        Process as many items in the queue, until the time limit specified via args[0] in seconds has been exceeded.
        """
        
        self.stdout.write('Custom Command')