"""
  This script will check all Collage, Branches, Courses, Posts, Subjects and Universities  # NOQA
  Have a sitemap url in SitemapUrl's model.  # NOQA
  If url does't exist only then it will create a url.  # NOQA
"""
from dashboard.models import (Branch, Course,
                              SiteMapURL, Subject)


def course():
    sitemap_url = "/s?uni=%s&cou=%s"
    courses = Course.objects.all()
    for course in courses:
        for university in course.universities.all():
            this_url = sitemap_url % (university.slug, course.slug)
            if not SiteMapURL.objects.filter(url=this_url).exists():
                SiteMapURL.objects.create(url=this_url)


def branch():
    sitemap_url = "/s?uni=%s&cou=%s&bra=%s"
    branches = Branch.objects.all()
    for branch in branches:
        for university in branch.universities.all():
            for course in branch.courses.all():
                this_url = sitemap_url % (university.slug,
                                          course.slug,
                                          branch.slug)
                if not SiteMapURL.objects.filter(url=this_url).exists():
                    SiteMapURL.objects.create(url=this_url)


def subject():
    sitemap_url = "/s?uni=%s&cou=%s&bra=%s&sub=%s"
    subjects = Subject.objects.all()
    for subject in subjects:
        for university in subject.universities.all():
            for course in subject.courses.all():
                for branch in subject.branches.all():
                    this_url = sitemap_url % (university.slug,
                                              course.slug,
                                              branch.slug,
                                              subject.slug)
                    if not SiteMapURL.objects.filter(url=this_url).exists():
                        SiteMapURL.objects.create(url=this_url)


if __name__ == '__main__':
    course()
    branch()
    subject()
