(function($) {
    var sclbck;
    var fclbck;
    var qclbck;
    $.fn.automataExercise = function(templateHtml, data, successClbk, failureClbk, quizClbk) {
        sclbck = successClbk;
        fclbck = failureClbk;
        qclbck = quizClbk;
        var template = Handlebars.compile(templateHtml);
        var extrapolated = template(data);
        this.html(extrapolated);
        var input = this.find("#input");
        // restrict the input to a, b, backspace
        input.keypress(function(event) {
            if (!(event.which == 97 || event.which == 98 || event.which == 8)) {
                event.preventDefault();
            }
        });
        var cnvsCtx = document.getElementById("cnvs").getContext("2d");
        drawAutomaton(cnvsCtx, input.val(), data.automaton);
        input.keyup(function() {
            drawAutomaton(cnvsCtx, input.val(), data.automaton);
        });
        this.find("#hint").bind("click", function() { alert(data.hint);});
        buildQuiz(data.quiz);

        return this;
    };

    function buildQuiz(qdata) {
        if (qdata === undefined) {
            return;
        }
        renderQuestions(qdata[qdata.start], qdata);

    }

    function renderQuestions(q, qdata) {
        $(".radio").unbind();
        if (q.v1 === undefined) {
            $("#quizQuestion").html("<p>" + q.val + "</p>");
            if (typeof(qclbck) == "function") {
                qclbck();
            }
            return;
        }
        var html = "<label><input class='radio' type='radio' name='que' data-to='"
        html += q.v1.to;
        html += "'>&nbsp;";
        html += q.v1.q;
        html += "</label><br><label><input class='radio' type='radio' name='que' data-to='";
        html += q.v2.to;
        html += "'>&nbsp;";
        html += q.v2.q;
        html += "</label>";
        $("#quizQuestion").html(html);
        $(".radio").bind("click", function() {
            var ix = $(this).data("to");
            var q = qdata[ix];
            renderQuestions(q, qdata);
        });
    }

    var accepted;
    var error;
    var visited;

    function testAutomaton(text, defn) {
        accepted = false;
        error = false;
        visited = new Array();
        var entry = defn.nodes[defn.entry];
        if (text.length === 0 && entry.final) {
            accepted = true;
            visited.push(defn.entry);
            if (typeof(sclbck) == "function") {
                sclbck();
            }
            return;
        }
        if (text.length === 0) {
            return;
        }
        var cnodeix = defn.entry;
        var cnode = entry;
        for (var i = 0; i < text.length; i++) {
            visited.push(cnodeix);
            var cpathix = cnode[text.charAt(i)];
            visited.push(cpathix);
            var cpath = defn.paths[cpathix];
            cnodeix = cpath.to;
            if (cnodeix === undefined) {
                error = true;
                return;
            }
            visited.push(cnodeix);
            cnode = defn.nodes[cnodeix];
        }
        if (cnode.final) {
            accepted = true;
            if (typeof(sclbck) == "function") {
                sclbck();
            }
        } else {
            if (typeof(fclbck) == "function") {
                fclbck();
            }
        }
    }

    function getColor(id) {
        if (error) {
            return 'red';
        }
        if (isVisited(id) && accepted) {
            return 'green';
        }
        if (isVisited(id)) {
            return 'blue';
        }

        return 'black';
    }

    function isVisited(id) {
        for (var i in visited) {
            if (visited[i] == id) {
                return true;
            }
        }
        return false;
    }

    function drawAutomaton(ctx, text, defn) {
        ctx.clearRect ( 0 , 0 , 640 , 480 );
        testAutomaton(text, defn);
        drawNodes(ctx, defn.nodes);
        drawPaths(ctx, defn);
        drawEntry(ctx, defn.nodes[defn.entry]);
    }

    function drawNodes(ctx, nodes) {
        for (var ix in nodes) {
            var node = nodes[ix];
            var radius;
            if (node.final) {
                radius = 6;
            } else {
                radius = 10;
            }
            var color = getColor(ix);
            ctx.beginPath();
            ctx.strokeStyle = color;
            ctx.fillStyle = color;
            ctx.arc(node.x, node.y, radius, 0, 2 *Math.PI, false);
            ctx.fill();
            ctx.stroke();
            if (node.final) {
                ctx.beginPath();
                ctx.arc(node.x, node.y, 10, 0, 2 *Math.PI, false);
                ctx.stroke();
            }
        }
    }

    function drawEntry(ctx, node) {
        ctx.beginPath();
        ctx.moveTo(node.x - 30, node.y);
        ctx.lineTo(node.x - 10, node.y);
        ctx.save();
        ctx.lineWidth = 2;
        ctx.stroke();
        drawArrow(ctx, node.x - 10, node.y, 0);
        ctx.restore();
    }

    function drawPaths(ctx, defn) {
        var paths = defn.paths;
        var nodes = defn.nodes;
        for (var ix in paths) {
            var path = paths[ix];
            var angle = (path.angle === undefined ? 0 : path.angle);
            var color = getColor(ix);
            ctx.strokeStyle = color;
            ctx.fillStyle = color;

            drawPath(ctx, nodes[path.from], nodes[path.to], path.label, path.labX, path.labY, angle);
        }
    }

    function drawPath(ctx, from, to, label, lx, ly, aa) {
        if (to === undefined) {
            return;
        }
        drawLabel(ctx, lx, ly, label);
        if (from === to) {
            ctx.beginPath();
            ctx.moveTo(from.x - 2, from.y - 12);
            ctx.bezierCurveTo(from.x - 10, from.y - 30, from.x + 10, from.y - 30, from.x + 2, from.y - 12);
            ctx.stroke();
            drawArrow(ctx, from.x - 2, from.y - 12, 75);
        } else {
            if (from.x - to.x < 0) {
                ctx.beginPath();
                ctx.moveTo(from.x + 10, from.y);
                ctx.lineTo(to.x - 10, to.y);
                ctx.stroke();
                drawArrow(ctx, to.x - 10, to.y, aa);
            } else {
                ctx.beginPath();
                var cntr = lx + (ctx.measureText(label).width / 2);
                var distance = (from.x - to.x - 20) / 3;
                ctx.moveTo(from.x - 8.5, from.y - 8.5);
                ctx.bezierCurveTo(cntr + distance, ly + 2, cntr - distance, ly + 2, to.x + 8.5, to.y - 8.5);
                ctx.stroke();
                drawArrow(ctx, to.x + 8.5, to.y - 8.5, aa);
            }
        }
    }

    function drawArrow(ctx, x, y, angle) {
        angle += 180;
        ctx.beginPath();
        ctx.moveTo(x, y);
        var dx = Math.cos((angle + 30)*Math.PI/180) * 6;
        var dy = Math.sin((angle + 30)*Math.PI/180) * 6;
        ctx.lineTo(x + dx, y + dy);
        ctx.stroke();
        ctx.moveTo(x, y);
        dx = Math.cos((angle - 30)*Math.PI/180) * 6;
        dy = Math.sin((angle - 30)*Math.PI/180) * 6;
        ctx.lineTo(x + dx, y + dy);
        ctx.stroke();
    }

    function drawLabel(ctx, x, y, text) {
        ctx.font = "12px Arial";
        ctx.fillText(text, x, y);
    }
})(jQuery);