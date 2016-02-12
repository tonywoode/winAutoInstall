if (typeof (Answers) == "undefined") {
    Answers = {};
}

Answers.SearchWithAutoSuggest = {
    previousSearchText: "", // stores the last user entered text in the search textbox so that it can be re-populated when the user is cycling through the autosuggestions

    menuKeys:
        {
            tab: 9,
            escape: 27,
            expand: 39,
            previous: 38,
            collapse: 37,
            next: 40,
            enter: 13
        },

    // A flag to tell the "select" event of the kendoUI autocomplete 
    // control if the select event was triggered via the Tab keypress event.
    isTabbing: false,

    // Indicates whether autosuggest is enabled or not, depending on the selected category. 
    // For Search Community member, autosuggest is disabled. For all others, autosuggest is enabled.
    isEnabled: true,

    Initialize: function () {
        if ($("#SearchBox").length == 0) {
            return;
        }

        Answers.SearchWithAutoSuggest.InitializeSearchEvents();

        // check if Search Community member is the selected category, if it is, do not enable auto suggest
        if ($("#SearchBox").data("searchmemberfiltername") === $("#CurrentScope_Filter").val()) {
            Answers.SearchWithAutoSuggest.isEnabled = false;
        }
        else {
            Answers.SearchWithAutoSuggest.InitializeAutoCompleteControl();
            Answers.SearchWithAutoSuggest.isEnabled = true;
        }
    },

    InitializeSearchEvents: function () {
        $("#SearchTerm").on({
            "mouseup.search": function () {
                return false;
            },
            "focus.search": function () {
                // close any dropdown control that is still open
                Answers.DropNav.HideNav(".dropNavShow", false);

                $("#SearchForm").addClass("inputHasFocus");

                // show the forums list
                if ($("#categoryList")[0].parentNode.id !== "SearchTerm-list") {
                    $("#categoryList").insertAfter($("#SearchButtons")).show(10);
                    $("#searchCategory").height("auto");

                    // remove inline style "overflow: hidden" added by jquery
                    $('#categoryList').attr('style', function (i, style) {
                        return style.replace("overflow: hidden;", '');
                    });
                }

                // hightlight the selected forum
                var selectedForum = $("#CurrentScope_ForumName").val();
                var selectedFilter = $("#CurrentScope_Filter").val();
                var selectedOption = $("a[data-forum='" + selectedForum + "'][data-filter='" + selectedFilter + "']");

                if (selectedOption) {
                    selectedOption.addClass("dropNavSelected");
                }
            },

            "blur.search": function (event) {
                $("#SearchForm").removeClass("inputHasFocus");
                setTimeout(function () {
                    var searchBox = $(document.activeElement).parents("#SearchBox");
                    if (searchBox.length === 0) {
                        $("#categoryList").hide();
                    }
                }, 10);
            },
            "keydown.search": function (event) {
                // check if the autosuggest list is open
                if ($("#SearchTerm-list").is(":visible")) {
                    // if autosuggest is open, handle scenario where the user is pressing up/down arrows
                    if (event.which === Answers.SearchWithAutoSuggest.menuKeys.next || event.which === Answers.SearchWithAutoSuggest.menuKeys.previous) {
                        setTimeout(function () {
                            if ($("#SearchTerm_option_selected").text() === "") {
                                // override kendoui autocomplete by showing the user input search text
                                Answers.SearchWithAutoSuggest.SetSearchParameters(false, Answers.SearchWithAutoSuggest.previousSearchText);
                            }
                            else {
                                // override kendoui autocomplete by showing the selected suggestion
                                var searchTerm = $("#SearchTerm_option_selected").text();

                                // find the selected suggestion then set the value of the search parameters
                                var autocomplete = $("#SearchTerm").data("kendoAutoComplete");
                                var selectedOptions = $.grep(autocomplete.dataSource.data(), function (option) {
                                    return option.SearchTerm === searchTerm;
                                });

                                if (selectedOptions && selectedOptions.length > 0) {
                                    Answers.SearchWithAutoSuggest.SetSearchParameters(true, searchTerm);
                                }
                            }
                        }, 10);

                        return true;
                    }
                }

                return Answers.SearchWithAutoSuggest.HandleSearchKeyCommands(event);
            },
        });

        $(".forumSelect").on({
            "keydown.forum": function (event) {
                return Answers.SearchWithAutoSuggest.HandleForumKeyCommands(this, event);
            },
            "click.forum": function (event) {
                var selectedForum = $("#CurrentScope_ForumName").val();
                var selectedFilter = $("#CurrentScope_Filter").val();
                var selectedOption = $("a[data-forum='" + selectedForum + "'][data-filter='" + selectedFilter + "']");
                var nextOption = this;
                Answers.SearchWithAutoSuggest.ChangeSelection(selectedOption, nextOption);

                var input = $.trim($("#SearchTerm").val());
                if (input.length > 0) {
                    $("#SearchTerm").closest("form").submit(); // if has value, proceed with submit
                }
                else {
                    $("#SearchTerm").focus();
                }
            },
            "blur.forum": function (event) {
                setTimeout(function () {
                    var searchBox = $(document.activeElement).parents("#SearchBox");
                    if (searchBox.length > 0) {
                        return;
                    }

                    $("#categoryList").hide();
                }, 10);
            }
        });

        $("#SearchForm").on("submit.search", function () {
            if (jQuery.trim($("#SearchTerm").val()).length > 0) {
                var isSuggested = $("#IsSuggestedTerm").val();

                if (isSuggested === "true") {
                    var data = { suggestedTerm: $("#SearchTerm").val() };
                    $(document).trigger("Answers.SearchWithAutoSuggest.SuggestionSelected", data);
                }

                return true;
            }

            $("#SearchTerm").focus();
            return false;
        });

        // Filters for Search Page
        $("#Questions, #Discussions, #Wikis, #BlogPosts").on("click.search", function () {
            var contentTypeScope = [];
            if ($("#Questions").is(":checked")) {
                contentTypeScope.push("QnA");
            }
            if ($("#Discussions").is(":checked")) {
                contentTypeScope.push("Discussion");
            }
            if ($("#Wikis").is(":checked")) {
                contentTypeScope.push("Wiki");
            }
            if ($("#BlogPosts").is(":checked")) {
                contentTypeScope.push("BlogPost");
            }

            $("#ContentTypeScope").val(contentTypeScope.toString());
            $("#SearchForm").submit();
        });
    },

    InitializeAutoCompleteControl: function () {
        $("#SearchTerm").kendoAutoComplete({
            animation: {
                open: {
                    duration: 10
                },
                close: {
                    duration: 10
                }
            },
            dataTextField: "SearchTerm",
            filter: "contains",
            minLength: $("#SearchBox").data("autosuggesttriggercharcount"),
            dataSource: {
                type: "json",
                serverFiltering: true,
                transport: {
                    read: {
                        dataType: "jsonp",
                        url: function (opt) {
                            var keyword = encodeURIComponent(opt.filter.filters[0].value);
                            var forum = encodeURIComponent($("#CurrentScope_ForumName").val()) || "all";
                            var appId = Answers.Res.PageControls.StatsServiceAppId;
                            var language = $("html").attr("lang");

                            return Answers.Res.PageControls.StatsServiceUrl + "GetSearchSuggestions/"
                                + appId + "/" + forum + "/?searchterm=" + keyword + "&lang=" + language;
                        }
                    },
                },
                schema: {
                    data: function (data) {
                        var maxLength = $("#SearchBox").data("autosuggestphrasemaxlength");
                        var maxSuggestionsCount = $("#SearchBox").data("autosuggestmaxsuggestionscount");
                        var suggestedItems = [];

                        // there is only one suggestion and it is the same as the value of search term, do not show it
                        if (data[0].Items.length === 1 && data[0].Items[0].SearchTerm === $.trim($("#SearchTerm").val())) {
                            return suggestedItems;
                        }

                        // truncate suggestion texts if suggestion is too long
                        for (var i = 0; i < data[0].Items.length; i++) {
                            var suggestionItem = data[0].Items[i];
                            suggestionItem.SearchTerm = Answers.Util.TruncateText(suggestionItem.SearchTerm, maxLength, false);

                            // check for existing before adding
                            var existingItems = $.grep(suggestedItems, function (item) {
                                return item.SearchTerm === suggestionItem.SearchTerm;
                            });

                            if (!existingItems || existingItems.length === 0) {
                                suggestedItems.push(suggestionItem);
                            }

                            if (suggestedItems.length >= maxSuggestionsCount) {
                                break;
                            }
                        }

                        return suggestedItems;
                    }
                }
            },
            height: 260, // this is used to create an inline style
            autoBind: true,
            open: function (event) {
                // remove inline style "overflow: hidden" added by jquery
                $('#categoryList').attr('style', function (i, style) {
                    return style.replace(/overflow[^;]+;?/g, '');
                });
            },
            close: function (event) {
                // This gets fired when: 
                //      (1) the text in search term is deleted
                //      (2) the text in search term has no matching suggestion
                //      (3) a category is selected by mouse click - Note: depending on how this event is handled, the event may or may not bubble up to forumSelect.click (it must bubble up)
                //      (4) user tabs out from search textbox to search icon button
                //      (5) the escape key is clicked
                // remove inline style "overflow: hidden" added by jquery
                $('#categoryList').attr('style', function (i, style) {
                    return style.replace("overflow: hidden;", '');
                });

                if ($("#SearchTerm").val().length === 0) {
                    Answers.SearchWithAutoSuggest.SetSearchParameters(false, "");
                }

                setTimeout(function () {
                    // Move top position of the category dropdown to just below the searchbox.
                    // forumSelect.click will not get fired if setTimeout is not used here.
                    $("#categoryList").css("top", 0);
                }, 150);
            },
            dataBound: function (event) {
                var options = event.sender.dataSource.data();
                var positionTop = options.length > 0 ? $("#SearchTerm-list").height() + 6 : 0;

                $("#categoryList").css("top", positionTop);

                // store the search text that the user is typing, this is needed to write back this value when the user cycles through auto suggestions using the up/down arrows
                Answers.SearchWithAutoSuggest.previousSearchText = $("#SearchTerm").val();
            },
            select: function (event) {
                // The autocomplete control interprets TAB key press as selecting an item. Prevent submit if tab was pressed.
                if (Answers.SearchWithAutoSuggest.isTabbing) {
                    // reset the flag
                    Answers.SearchWithAutoSuggest.isTabbing = false;
                    return;
                }

                // select happened by clicking or pressing Enter on a suggestion item, proceed with submit
                var suggestion = this.dataItem(event.item.index());
                if (suggestion.SearchTerm) {
                    Answers.SearchWithAutoSuggest.SetSearchParameters(true, suggestion.SearchTerm);
                    $("#SearchForm").submit();
                }
            }
        });

        $("#SearchTerm-list").width(372); // this is used to generate an inline style
    },

    HandleSearchKeyCommands: function (event) {

        switch (event.which) {
            case Answers.SearchWithAutoSuggest.menuKeys.enter:
                var input = $.trim($("#SearchTerm").val());
                if (input.length > 0) {
                    $("#SearchTerm").closest("form").submit(); // if has value, proceed with submit
                }

                break;

            case Answers.SearchWithAutoSuggest.menuKeys.tab:
                // set the isTabbing flag to make sure the "select" handler of the autocomplete control
                // knows that the intent was not to select a suggestion item but to tab to the next control
                Answers.SearchWithAutoSuggest.isTabbing = true;
                break;

            case Answers.SearchWithAutoSuggest.menuKeys.next:
                Answers.SearchWithAutoSuggest.MoveToCurrentForum();
                break;

            case Answers.SearchWithAutoSuggest.menuKeys.previous:
                Answers.SearchWithAutoSuggest.MoveToCurrentForum();
                break;
        }

        return true;
    },

    HandleForumKeyCommands: function (elem, event) {
        switch (event.which) {
            case Answers.SearchWithAutoSuggest.menuKeys.enter:
                var selectedForum = $("#CurrentScope_ForumName").val();
                var selectedFilter = $("#CurrentScope_Filter").val();
                var selectedOption = $("a[data-forum='" + selectedForum + "'][data-filter='" + selectedFilter + "']");
                var nextOption = elem;
                Answers.SearchWithAutoSuggest.ChangeSelection(selectedOption, nextOption);

                var input = $.trim($("#SearchTerm").val());
                if (input.length > 0) {
                    $("#SearchTerm").closest("form").submit(); // if has value, proceed with submit
                }
                else {
                    $("#SearchTerm").focus();
                }

                event.preventDefault();
                return false;

            case Answers.SearchWithAutoSuggest.menuKeys.escape:
                selectedForum = $("#CurrentScope_ForumName").val();
                selectedFilter = $("#CurrentScope_Filter").val();
                selectedOption = $("a[data-forum='" + selectedForum + "'][data-filter='" + selectedFilter + "']");
                nextOption = elem;
                Answers.SearchWithAutoSuggest.ChangeSelection(selectedOption, nextOption);

                $("#SearchTerm").focus();
                event.preventDefault();
                return false;

            case Answers.SearchWithAutoSuggest.menuKeys.tab:
                $("a:first", "#TopNav").focus();
                event.preventDefault();
                return false;

            case Answers.SearchWithAutoSuggest.menuKeys.next:
                Answers.SearchWithAutoSuggest.MoveToNextForum();
                event.preventDefault();
                return false;

            case Answers.SearchWithAutoSuggest.menuKeys.previous:
                Answers.SearchWithAutoSuggest.MoveToPreviousForum();
                event.preventDefault();
                return false;
        }

        return true;
    },

    SetSearchParameters: function (isSuggestedTerm, searchTerm) {
        $("#SearchTerm").val(searchTerm);
        $("#IsSuggestedTerm").val(isSuggestedTerm);
    },

    MoveToCurrentForum: function () {
        var selectedForum = $("#CurrentScope_ForumName").val();
        var selectedFilter = $("#CurrentScope_Filter").val();
        var selectedOption = $("a[data-forum='" + selectedForum + "'][data-filter='" + selectedFilter + "']");
        selectedOption.focus();
    },

    ChangeSelection: function (currentSelection, newSelection) {
        $("#CurrentScope_ForumName").val($(newSelection).data("forum"));
        $("#CurrentScope_Filter").val($(newSelection).data("filter"));

        currentSelection.removeClass("dropNavSelected");
        $(newSelection).addClass("dropNavSelected");

        var searchMemberFilterName = $("#SearchBox").data("searchmemberfiltername");
        var autocomplete = $("#SearchTerm").data("kendoAutoComplete");

        // if autosuggest is enabled and category was changed to Search Community member, disable autosuggest
        if (Answers.SearchWithAutoSuggest.isEnabled && searchMemberFilterName === $("#CurrentScope_Filter").val()) {
            autocomplete.destroy();
            Answers.SearchWithAutoSuggest.isEnabled = false;
            return;
        }

        // if autosuggest is not enabled and category was changed to any category other than Search Community member, enable autosuggest
        if (!Answers.SearchWithAutoSuggest.isEnabled && searchMemberFilterName !== $("#CurrentScope_Filter").val()) {
            Answers.SearchWithAutoSuggest.InitializeAutoCompleteControl();
            Answers.SearchWithAutoSuggest.isEnabled = true;
            return;
        }
    },

    MoveToPreviousForum: function () {
        var selectedForum = $("#CurrentScope_ForumName").val();
        var selectedFilter = $("#CurrentScope_Filter").val();
        var selectedOption = $("a[data-forum='" + selectedForum + "'][data-filter='" + selectedFilter + "']");

        if (selectedOption) {
            // get previous option
            var previousOptionContainer = $(selectedOption[0].parentElement).prev();

            if (previousOptionContainer && previousOptionContainer.hasClass("topNavLink")) {
                previousOptionContainer = previousOptionContainer.prev();
            }

            if (previousOptionContainer && previousOptionContainer[0]) {
                // move to previous
                var previousOption = $(previousOptionContainer[0].firstChild);
                if (previousOption) {
                    Answers.DropNav.ChangeSelection(selectedOption, previousOption);
                }

                previousOption.focus();
            }
            else {
                // topmost item has been reached, move to last option
                var lastOption = $("#searchCategory li:last")[0].firstChild;
                if (lastOption) {
                    Answers.DropNav.ChangeSelection(selectedOption, lastOption);
                }

                lastOption.focus();
            }
        }
    },

    MoveToNextForum: function () {
        var selectedForum = $("#CurrentScope_ForumName").val();
        var selectedFilter = $("#CurrentScope_Filter").val();
        var selectedOption = $("a[data-forum='" + selectedForum + "'][data-filter='" + selectedFilter + "']");

        if (selectedOption) {
            // get next option
            var nextOptionContainer = $(selectedOption[0].parentElement).next();
            if (nextOptionContainer && nextOptionContainer.hasClass("topNavLink")) {
                nextOptionContainer = nextOptionContainer.next();
            }

            if (nextOptionContainer && nextOptionContainer[0]) {
                // move to next option
                var nextOption = $(nextOptionContainer[0].firstChild);
                if (nextOption) {
                    Answers.DropNav.ChangeSelection(selectedOption, nextOption);
                }

                nextOption.focus();
            }
            else {
                // last option has been reached, move to first option
                var firstOption = $("#searchCategory li:first")[0].firstChild;

                if (firstOption) {
                    Answers.DropNav.ChangeSelection(selectedOption, firstOption);
                }

                firstOption.focus();
            }
        }
    },
}