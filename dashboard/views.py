from django.views import View
from django.shortcuts import (get_object_or_404, render,
                              render_to_response)
from dashboard.models import (University, Collage,
                              Course, Branch, Subject)
from xpapers.utils import utils_commaSeperatedString


def handler404(request, *args, **argv):
    response = render_to_response('error-pages/404.html')
    response.status_code = 404
    return response


def handler500(request, *args, **argv):
    response = render_to_response('error-pages/500.html')
    response.status_code = 500
    return response


class DashboardView(View):
    template_name = 'dashboard/dashboard.html'

    def get(self, request, path=None):
        universities_name = University.objects.all().values_list('name', flat=True)
        description = "Get previous year question papers of %s" % utils_commaSeperatedString(universities_name)
        keywords = "%s" % utils_commaSeperatedString(universities_name, "previous year question papers")
        context = {
            "keywords": keywords,
            "description": description
        }
        return render(request, self.template_name, context)


class UploadPaperView(View):
    template_name = 'dashboard/upload-paper.html'

    def get(self, request, path=None):
        return render(request, self.template_name)


class SearchDataView(View):
    template_name = 'dashboard/show.html'

    def keyword_discription_maker(self, tag_line, replace_with=" "):
        if not tag_line:
            return None
        return tag_line.title().replace(" > ", replace_with)

    def breadcrumbs(self, tag=None, url=None):
        breadcrumbs_url = url.split("s?")
        url_host = breadcrumbs_url[0] + "s?"
        url_body = breadcrumbs_url[1].split('&')
        url_university = url_host + url_body[0]
        tag_split = tag.split(' > ')
        tag_split_length = len(tag_split)
        tagHtml = ""
        thisURL = url_university
        page_title = '<a href="%s">%s</a>' % (url_university, tag_split[0].title())
        for i in range(1, len(url_body)):
            thisURL = thisURL + "&" + url_body[i]
            if i == tag_split_length - 1:
                tagHtml += '<li class="breadcrumb-item text">' \
                           '<a href="%s" class="text">%s</a>' \
                           '</li>' % (thisURL, tag_split[i])
            else:
                tagHtml += '<li class="breadcrumb-item text-muted">' \
                           '<a href="%s" class="text-muted">%s</a>' \
                           '</li>' % (thisURL, tag_split[i])
        return {"breadcrumbs_title": page_title, "breadcrumbs_tags": tagHtml}

    def get(self, request, path=None):
        query_university = request.GET.get('uni', None)
        # query_collage = request.GET.get('col', None)
        query_course = request.GET.get('cou', None)
        query_branch = request.GET.get('bra', None)
        query_subject = request.GET.get('sub', None)
        university = get_object_or_404(University, slug=query_university)
        description = "Get %s previous year question paper "
        keywords = "%s previous year question paper"
        university_name = university.name.lower()
        tag = university_name

        if query_university and \
                not query_course and \
                not query_branch and \
                not query_subject:
            # Course, BTech
            university_course_name_list = []
            university_course = Course.objects.filter(universities=university)
            for course in university_course:
                if course.acronym:
                    university_course_name_list.append(course.acronym)
                else:
                    university_course_name_list.append(course.name)
            description = description % university_name.title()
            keywords = keywords % university_name
            description += "of " + utils_commaSeperatedString(university_course_name_list, capslock="upper")
            for course_name in university_course_name_list:
                keywords += ", %s question papers %s" % (university_name, course_name)
            context = {
                "data": "course",
                "tag": tag.title(),
                "description": description,
                "keywords": keywords.lower(),
                "uni_thumbnail": university.thumbnail.url if university.thumbnail else None,
                "uni_description": university.description,
                "uni_about": university.about,
                "uni_url": university.url
            }
        elif query_university and \
                query_course and \
                not query_branch and \
                not query_subject:
            # Branch C.S.E
            course_branch_name_list = []
            _course = get_object_or_404(Course, slug=query_course)
            course_branchs = Branch.objects.filter(universities=university, courses=_course)
            if _course.acronym:
                tag = tag + " > " + _course.acronym
            else:
                tag = tag + " > " + _course.name.title()
            for branch in course_branchs:
                if branch.acronym:
                    course_branch_name_list.append(branch.acronym)
                else:
                    course_branch_name_list.append(branch.name)
            keyword_discription = self.keyword_discription_maker(tag, replace_with=" question paper ")
            description = description % self.keyword_discription_maker(tag)
            keywords = keyword_discription
            description += "of " + utils_commaSeperatedString(course_branch_name_list, capslock="upper")
            for branch_name in course_branch_name_list:
                keywords += ", %s %s" % (tag.replace(" > ", ' question papers '), branch_name)

            breadcrumbs_data = self.breadcrumbs(url=request.get_full_path(),
                                                tag=tag)
            context = {
                "data": "branch",
                "tag": tag.title(),
                "description": description,
                "keywords": keywords.lower(),
                "breadcrumbs_title": breadcrumbs_data['breadcrumbs_title'],
                "breadcrumbs_tags": breadcrumbs_data['breadcrumbs_tags'],
            }
        elif query_university and \
                query_course and \
                query_branch and \
                not query_subject:
            # Subject Opp's
            _course = get_object_or_404(Course, slug=query_course)
            _branch = get_object_or_404(Branch, slug=query_branch)
            if _course.acronym:
                _course_name = _course.acronym
            else:
                _course_name = _course.name.title()
            if _branch.acronym:
                _branch_name = _branch.acronym
            else:
                _branch_name = _branch.name.title()

            tag = tag + " > " + _course_name + " > " + _branch_name
            keyword_discription = self.keyword_discription_maker(tag)
            description = description % keyword_discription
            keywords = keywords % keyword_discription
            breadcrumbs_data = self.breadcrumbs(url=request.get_full_path(),
                                                tag=tag)
            context = {
                "data": "subject",
                "tag": tag.title(),
                "description": description,
                "keywords": keywords,
                "breadcrumbs_title": breadcrumbs_data['breadcrumbs_title'],
                "breadcrumbs_tags": breadcrumbs_data['breadcrumbs_tags'],
            }

        elif query_university and \
                query_course and \
                query_branch and \
                query_subject:
            _course = get_object_or_404(Course, slug=query_course)
            _branch = get_object_or_404(Branch, slug=query_branch)
            _subject = get_object_or_404(Subject, slug=query_subject)
            if _course.acronym:
                _course_name = _course.acronym
            else:
                _course_name = _course.name.title()
            if _branch.acronym:
                _branch_name = _branch.acronym
            else:
                _branch_name = _branch.name.title()
            if _subject.acronym:
                _subject_name = _subject.acronym
            else:
                _subject_name = _subject.name.title()

            tag = tag + " > " + _course_name + " > " + _branch_name + " > " + _subject_name
            keyword_discription = self.keyword_discription_maker(tag)
            description = description % keyword_discription
            keywords = keywords % keyword_discription
            breadcrumbs_data = self.breadcrumbs(url=request.get_full_path(),
                                                tag=tag)
            context = {
                "data": "post",
                "tag": tag.title(),
                "description": description,
                "keywords": keywords,
                "breadcrumbs_title": breadcrumbs_data['breadcrumbs_title'],
                "breadcrumbs_tags": breadcrumbs_data['breadcrumbs_tags'],
            }
        else:
            return render(request, self.template_name)

        return render(request, self.template_name, context=context)


class AboutView(View):
    template_name = 'dashboard/about-us.html'

    def get(self, request, path=None):
        return render(request, self.template_name)


class ContactView(View):
    template_name = 'dashboard/contact-us.html'

    def get(self, request, path=None):
        return render(request, self.template_name)


class PrivacyPolicyView(View):
    template_name = 'dashboard/privacy-policy.html'

    def get(self, request, path=None):
        return render(request, self.template_name)


class DisclaimerView(View):
    template_name = 'dashboard/disclaimer.html'

    def get(self, request, path=None):
        return render(request, self.template_name)
