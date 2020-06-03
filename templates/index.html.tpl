<!doctype html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.0/journal/bootstrap.min.css" rel="stylesheet" integrity="sha384-vjBZc/DqIqR687k5rf6bUQ6IVSOxQUi9TcwtvULstA7+YGi//g3oT2qkh8W1Drx9" crossorigin="anonymous">
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

    <title>{{.Title}}</title>

    <style>
        body {
            padding-top: 4.5rem;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
        <a class="navbar-brand" href="/">{{.Title}}</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link text-success" href="#" data-toggle="modal" data-target="#addModal" title="Add New Guestbook Entry"><i class="fa fa-plus-square" aria-hidden="true"></i> Add Entry</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="https://github.com/jmckind/guestbook" target="_blank" title="View Project on GitHub"><i class="fa fa-github" aria-hidden="true"></i> Github</a>
                </li>
            </ul>
            <form class="form-inline mt-2 mt-md-0">
                <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search" name="q">
                <button class="btn btn-secondary my-2 my-sm-0" type="submit"><i class="fa fa-search" aria-hidden="true"></i> Search</button>
            </form>
        </div>
    </nav>

    <div class="container" role="main">
        <div class="my-3 p-3">
            {{range $entry := .Entries}}
            <div class="media text-muted">
                <p class="media-body pb-3 mb-0 border-bottom border-gray">
                    <strong class="d-block text-gray-dark">{{$entry.Author}}</strong>
                    <span class="d-block"><i class="date-format">{{$entry.Created}}</i></span>
                    {{$entry.Content}}
                </p>
            </div>
            {{end}}
        </div>
    </div>

    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addModalLabel"><i class="fa fa-pencil" aria-hidden="true"></i> Add Guestbook Entry</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form method="POST">
                    <div class="modal-body">                    
                        <div class="form-group">
                            <label for="txtName">Name</label>
                            <input type="text" id="txtName" class="form-control" name="author" required>
                        </div>
                        <div class="form-group">
                            <label for="txtMessage">Message</label>
                            <textarea class="form-control" id="txtMessage" name="content" rows="5" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal"><i class="fa fa-ban" aria-hidden="true"></i> Cancel</button>
                        <button type="submit" class="btn btn-primary"><i class="fa fa-hdd-o" aria-hidden="true"></i> Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.26.0/moment-with-locales.min.js" integrity="sha256-4HOrwHz9ACPZBxAav7mYYlbeMiAL0h6+lZ36cLNpR+E=" crossorigin="anonymous"></script>

    <script>
        $( document ).ready(function() {
            $(".date-format").each(function( index ) {
                element = $(this);
                datetime = moment(element.text(), "YYYY-MM-DD HH:mm:ss.SSSSSSSSS ZZ Z");
                element.attr("title", datetime.format("dddd, MMMM Do YYYY, h:mm:ss a"));
                element.text(datetime.fromNow());
            });
        });
    </script>
</body>
</html>
