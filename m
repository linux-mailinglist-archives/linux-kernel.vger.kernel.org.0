Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A128D96ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 18:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394178AbfJPQTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 12:19:33 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:53800 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404130AbfJPQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:19:32 -0400
Received: by mail-wm1-f51.google.com with SMTP id i16so3591727wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ClDQ27rib9gTJsQGXTTJRHusNU/eeaE+CiY63Jy96js=;
        b=R8ZUM76BwybIlfHTtRwSrwoeTc0Mm9dKOaxg1WK0QsHiLZlUH+m6fN0gP9qidVD9UO
         rt4KY3Z8S7I4b4fVvyHlt2c3Y5LEhzWqyoSrjgcXq3TPRDi/GDxJWxx8D0qVAksqziO6
         LAXz+tbSR8VjMmLtGRWn0oL0rz/OXkks//cZD0Kpi9iohJ7ZRw3DkXqeqvMZWRTo1Sp9
         IPbuJHaekq415jw2F+9KtXMCBZu/GcvpEYnRGPwT2tbab7MTuSBGt4WFKfFXQCvy3RFU
         K5GcdUL+FW/vh8hltdoCQli7FCk42R7JNG0zQznhzQWbCnSXdgWUKfNakM7kQ0Y/f4JV
         PDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClDQ27rib9gTJsQGXTTJRHusNU/eeaE+CiY63Jy96js=;
        b=km6mmm7krUp+aUTH/RJxOAOFScxATnnAannW9hE1SyctJy/uX37eCOmp+Rc6TLwFHa
         fhIsEmOIzNR2OqEVcORsQEemwZXmsx1sgaiQIqKDuHa05N4eJQxLzNi/vz5zroofnO2x
         bj+6rX5/XEdhoLfgZ1mOrsMcS16acYd2ppeka9uRUUbFn/YsVSnGb+IuubVMB3TV77op
         Nu/4L6QTvltNxWrk5WJjNqx+WOv6S2jzSPn9D+POQCmXqt8Kw2FV1dnJIwx0pq1Ft3Iq
         tMb8NzqfthmImGzTMwn0bm1nzXzAh5OQaApztaesS1xt1alXHVClTNYXtWNkb63lbZ5V
         3Xpw==
X-Gm-Message-State: APjAAAWQ/Cn2+JsISHQm5SgXfwxMIiOiIxBL9MzOAsueH5LWMXBfgrJY
        oGtNywv9U2ZoSaUmujYNpw0xESncOISyIMJXHClNkA==
X-Google-Smtp-Source: APXvYqwh8+A8W2StIQF2g+j5jrtEm7yZmJlKM7cnB2ptXcCThx5FPhYGZlDdtFTcJ8UwxXhdehgQHSIszElU/Zr+g78=
X-Received: by 2002:a7b:c395:: with SMTP id s21mr4085418wmj.102.1571242770235;
 Wed, 16 Oct 2019 09:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191016111541.20208-1-yuehaibing@huawei.com>
In-Reply-To: <20191016111541.20208-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 16 Oct 2019 12:19:15 -0400
Message-ID: <CADnq5_MzELoYV2=Fzioy_YqxdyQg+RXQKL4CUwayGP3_RMRg3A@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Make dc_link_detect_helper static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        David Francis <David.Francis@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Chris Park <Chris.Park@amd.com>,
        Martin Leung <martin.leung@amd.com>, david.galiffi@amd.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 8:29 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:746:6:
>  warning: symbol 'dc_link_detect_helper' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index fb18681..9350536 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -743,7 +743,8 @@ static bool wait_for_alt_mode(struct dc_link *link)
>   * This does not create remote sinks but will trigger DM
>   * to start MST detection if a branch is detected.
>   */
> -bool dc_link_detect_helper(struct dc_link *link, enum dc_detect_reason reason)
> +static bool dc_link_detect_helper(struct dc_link *link,
> +                                 enum dc_detect_reason reason)
>  {
>         struct dc_sink_init_data sink_init_data = { 0 };
>         struct display_sink_capability sink_caps = { 0 };
> --
> 2.7.4
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
