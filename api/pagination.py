from django.core.paginator import EmptyPage
from rest_framework import pagination
from rest_framework.response import Response


class StandardPagination(pagination.PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    max_page_size = 100


class GenericPagination(pagination.PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    max_page_size = 10000

    def get_paginated_response(self, data):
        if 'page_size' in self.request.GET:
            self.page_size = self.request.GET.get('page_size')
        try:
            previous_page_number = self.page.previous_page_number()
        except EmptyPage:
            previous_page_number = None

        try:
            next_page_number = self.page.next_page_number()
        except EmptyPage:
            next_page_number = None

        return Response(
            {
                'data': data,
                'draw': self.page.number,
                'recordsTotal': self.page.paginator.count,
                'recordsFiltered': self.page.paginator.count,
            }
        )
