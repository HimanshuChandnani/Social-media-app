const handleLike = (elem, post) => {
    data = {
        like: $(elem).hasClass("liked") ? "dislike" : "like",
        post: post,
    };
    $(elem).hasClass("liked") ? $(elem).removeClass("liked") : $(elem).addClass("liked");
    $(elem).hasClass("liked")
        ? $(elem)
              .children()
              .last()
              .text(parseInt($(elem).children().last().text()) + 1)
        : $(elem)
              .children()
              .last()
              .text(parseInt($(elem).children().last().text()) - 1);
    axios.post("/handlelike", data, { headers: { "Content-Type": "text/plain" } });
};
