//------------------------------------------------------------------------------
// <copyright file="profileimage.js" company="Microsoft">
//     Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// <summary>
//    Javascript file for resizing user profile images to scale them well.
// </summary>
//------------------------------------------------------------------------------

Answers = Answers || {};

Answers.ProfileImage = Answers.ProfileImage || {};

Answers.ProfileImage.RefreshProfileImage = function (profileImage) {

    if (!profileImage) {
        profileImage = $(".profile-image");
    }

    profileImage.load(function () {
        //Obtain the height and width of the image to be scaled to fit in the circle
        var width = this.naturalWidth;
        var height = this.naturalHeight;
        var self = $(this);
        var sizeToBeSet = self.data("height");
        var ratio = 1;

        //Scale a rectangular image proportionately to a sqaure image to make it fit in a circle. 
        if (width > height) {
            self.css("height", sizeToBeSet + "px");
            ratio = width / height;
            self.css("width", sizeToBeSet * ratio);
            self.css("margin-left", ((sizeToBeSet - parseInt(self.css("width"))) / 2));
        }
        else {
            self.css("width", sizeToBeSet + "px");
            ratio = height / width;
            self.css("height", sizeToBeSet * ratio);
            self.css("margin-top", ((sizeToBeSet - parseInt(self.css("height"))) / 2));
        }

        return false;
    }).each(function () {
        // If image is loaded from cache
        if (this.complete && this.naturalWidth !== 0) {
            $(this).trigger("load");
        }
    });

    profileImage.show();
};

$(document).ready(function () {
    Answers.ProfileImage.RefreshProfileImage();
});
