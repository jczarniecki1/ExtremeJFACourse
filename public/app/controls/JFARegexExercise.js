(function($) {
    var clbck;
    $.fn.regexExercise = function(templateHtml, data, callback) {
        clbck = callback;
        var template = Handlebars.compile(templateHtml);
        data.body = createList(data.matches, "match");
        data.altbody = createList(data.nomatches, "nomatch");
        var extrapolated = template(data);
        this.html(extrapolated);
        this.find("#reinput").keyup(checkRe);
        this.find("#hint").bind("click", function() { alert(data.hint);});
        this.find("#word").keyup(function (event) {
            if (event.which === 13) {
                appendWord();
            }
        });
        this.find("#addword").bind("click", appendWord);

        return this;
    };

    function appendWord() {
        var word = $("#word").val();
        if (word === undefined || word.length === 0) {
            alert("Słowo nie może być puste.");
            return;
        }
        var isChecked = $("#wordcheck").is(":checked");
        var list = (isChecked ? $("#match") : $("#nomatch"));
        var html = "<li class='" + (isChecked ? "match" : "nomatch") + "'>" + word + "</li>";
        list.append(html);
    }

    function checkRe() {
        $(".failure").removeClass("failure");
        $(".success").removeClass("success");
        var regex = getRegexp($("#reinput").val());
        if (regex === undefined) {
            return;
        }
        $(".match").each(function() {
            var val = getText($(this));
            if (regex.exec(val) == val) {
                $(this).addClass("success");
            } else {
                $(this).addClass("failure");
            }
        });
        $(".nomatch").each(function() {
            var val = getText($(this));
            if (regex.exec(val) == val) {
                $(this).addClass("failure");
            } else {
                $(this).addClass("success");
            }
        });
        var failcount = $(".failure").size();
        if (failcount === 0) {
            clbck();
        }
    }

    function getRegexp(re) {
        if (re === undefined || re === "") {
            return undefined;
        }
        var group = new RegExp("\\(.\\|.\\)");
        while (group.test(re)) {
            var match = group.exec(re);
            var replacement = "[" + match[0].substring(1, match[0].length - 1).split("|").join("") + "]";
            re = re.replace(match[0], replacement);
        }
        try {
            return new RegExp("^" + re + "$");
        } catch (e) {
            console.log(e);
            return undefined;
        }
    }

    function getText(el) {
        var val = el.text();
        if (val === '@') {
            val = "";
        }
        return val;
    }

    function createList(data, className) {
        var body = "<ul id='";
        body += className;
        body += "'>";
        for (var index in data) {
            if (data.hasOwnProperty(index)){
                body += "<li><code class='";
                body += className;
                body += "'>";
                body += data[index];
                body += "</code></li>";
            }
        }
        body += "</ul>";
        return body;
    }
})(jQuery);