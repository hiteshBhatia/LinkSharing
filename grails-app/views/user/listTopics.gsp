<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.intelligrape.linksharing.*" %>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>Dashboard</title>
    <meta name="layout" content="kickstart"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#myTabs a').click(function (e) {
                e.preventDefault();
                $(this).tab('show')
            })

            $(".dropdown-toggle").dropdown();
        })
    </script>
</head>

<body>
<div>
    <ul id="myTabs" class="nav nav-tabs">
        <li class="active"><a href="#ownedTopics">Your topics</a></li>
        <li><a href="#subscribedTopics">Subscribed topics</a></li>
        <li><a href="#publicTopics">Public topics</a></li>
        <li><a href="#readingItems">Reading items</a></li>
    </ul>

    <div class="tab-content">
        <div class="tab-pane active" id="ownedTopics">
            <table class="table-striped table-hover table table-bordered">
                <thead><tr><th>Name</th> <th>Subscribe/Unsubscribe</th><th>Delete</th></tr></thead>
                <tbody>
                <g:each in="${ownedTopics}" var="topic">
                    <tr>
                        <td>
                            ${topic.name}
                        </td>
                        <td>
                            <g:if test="${Subscription.findBySubscriberAndTopic(user, topic)}">
                                <g:link name="unsubscribe" controller="user" action="unsubscribe"
                                        id="${topic.id}">Unsubscribe</g:link>
                            </g:if>
                            <g:else>
                                <g:link name="subscribe" controller="user" action="subscribe"
                                        id="${topic.id}">Subscribe</g:link>
                            </g:else>
                        </td>
                        <td>
                            <g:link controller="user" action="deleteTopic" name="deleteTopic"
                                    id="${topic.id}" class="btn btn-small btn-danger">Delete</g:link>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div style="padding-bottom: 50px" class="tab-pane" id="subscribedTopics">
            <table class="table-striped table-hover table table-bordered">
                <thead><tr><th>Name</th><th>Seriousness</th><th>Create resource</th><th>Associated resources</th><th>Send invitation</th><th>Unsubscribe</th>
                </tr></thead>
                <tbody>
                <g:each in="${subscriptions}" var="subscription">
                    <tr>
                        <td>
                            <g:link name="topicSettings" controller="user" action="changeTopicSettings"
                                    id="${subscription.topic.id}">${subscription.topic}</g:link>
                        </td>
                        <td>${subscription.seriousness}</td>
                        <td>
                            <div class="dropdown">
                                <a data-target="#" class="btn btn-small dropdown-toggle" data-toggle="dropdown">
                                    Add resource <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu" role="menu" area-labelledby="dropdownMenu">
                                    <li><g:link name="createLinkResource" controller="resource"
                                                action="createLinkResource"
                                                id="${subscription.topic.id}">Create link resource</g:link></li>
                                    <li><g:link name="createDocumentResource" controller="resource"
                                                action="createDocumentResource"
                                                id="${subscription.topic.id}">Create document resource</g:link></li>
                                </ul>
                            </div>
                        </td>
                        <td>
                            <div class="dropdown">
                                <a data-target="#" class="btn btn-small dropdown-toggle" data-toggle="dropdown">
                                    View resources <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu" role="menu" area-labelledby="dropdownMenu">
                                    <li><g:link controller="resource" action="viewAssociatedLinkResources"
                                                id="${subscription.topic.id}"
                                                name="viewAssociatedLinkResources">View link resource</g:link></li>

                                    <li><g:link controller="resource" action="viewAssociatedDocumentResources"
                                                id="${subscription.topic.id}"
                                                name="viewAssociatedDocumentResources">View document resource</g:link></li>
                                </ul>
                            </div>
                        </td>
                        <td>
                            <g:link class="btn btn-small btn-success" name="sendInvitation" controller="user"
                                    action="sendInvitation"
                                    id="${subscription.topic.id}">Send invitation</g:link>
                        </td>
                        <td>
                            <g:link class="btn btn-small btn-info" name="unsubscribe" controller="user"
                                    action="unsubscribe"
                                    id="${subscription.topic.id}">Unsubscribe</g:link>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div class="tab-pane" id="publicTopics">
            <table class="table-striped table-hover table table-bordered">
                <thead><tr><th>Name</th><th>Subscribe/Unsubscribe</th></tr></thead>
                <tbody>
                <g:each in="${publicTopics}" var="topic">
                    <tr>
                        <td>${topic.name}</td>
                        <td>
                            <g:link class="btn btn-small btn-success" name="subscribe" controller="user"
                                    action="subscribe"
                                    id="${topic.id}">Subscribe</g:link>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div class="tab-pane" id="readingItems">
            <table class="table-striped table-hover table table-bordered">
                <thead><tr><th>Associated Resource</th><th>Mark read</th></tr></thead>
                <tbody>
                <g:each in="${readingItems}" var="readingItem">
                    <tr>
                        <td>${readingItem.resource.title}</td>
                        <td>
                                <g:link controller="readingItem" action="markRead" name="markRead"
                                        id="${readingItem.id}">Mark read</g:link>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>