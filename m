Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C7F1EFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733063AbfEOLiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 07:38:08 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40437 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfEOLiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:38:06 -0400
Received: by mail-ua1-f68.google.com with SMTP id d4so891193uaj.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 04:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhei19leC0v0ZA7DjLdtqOfvCqcIJBYFgz9DlYcngkI=;
        b=oaroJl5NO9j75iHIVOTNAlnBr/aL4E1ohUkTQsEeea3XZJ4vkAJGhQEDeBrR6d9ESr
         zglYQaxjZnMOHQ3PUAzn9NB1Y1VnE6M/XP5FhlAis8HoPvrB2vebngrgqVa63OIQlFjj
         3QJBzbCLyw2i4gU1XWgA1ofiQgv26zC0eaoEgMsgG+D/RcTaw4TZ64Sk8h/VEN093i2D
         VBSUyrGXyWK7qYJQizQPcwPjf6UcDtZ0n8pIPGoRQfW3jieIYYVPlhywkXl3NSklXSgi
         blezqhaxahIUTuQ1COcVUiDME7s0xvpY2+3SXnOQNVSUFpIJH4Fs8c0pf+ZNxGB28k6K
         xqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhei19leC0v0ZA7DjLdtqOfvCqcIJBYFgz9DlYcngkI=;
        b=Lr41/RsCPCrwbC5CASDtnfO0R6aVyNcPQpXLjj4QJPRkQsTZuqy4Ye3Ki+qxkQKkNt
         v4ITTa1jTmB8sZl8pvlAsa7/XrNwgyHOLDW1yFCALXp7hcA5kGQO+d5G/yzpV+1qX8Xr
         Xwa/B+WtUzJGNSqJ71DOo27yWP8+saga7PjF2IZGEGThebLxcTRxsQIhJRlpq6seG8gC
         WRW6PgAVSBqSYdjgy1J9HUNZ3EKDYNjiOw8YS79hVND2vnZEFjk4fsTvEiPTD1iLWrXl
         KB8E1f+aEKUb1DqTbaI6Xjd1BkO0vh+2SQswTVfbUuLQTvhP3EBnFcCqTlZOifxvHyda
         8PSw==
X-Gm-Message-State: APjAAAWhMlG/s0Z7LxUOovbu/Wkkhvq9RVACKBOM+dX6XCdicOtWZxe6
        OT7G5nm5pSkF91sVi5n4+jCJ08rxUFE1GpCvprIT+g==
X-Google-Smtp-Source: APXvYqx2ho4ZoBSxolOdsewMdtUC+zzflgrlf7FvoPJG2+KVlkzz73geamFsVboy/g6Mx0Z2VtH6zsmbje4Xwvjdgv4=
X-Received: by 2002:ab0:2399:: with SMTP id b25mr300951uan.129.1557920285743;
 Wed, 15 May 2019 04:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190513091548.16674-1-narmstrong@baylibre.com> <20190513091548.16674-2-narmstrong@baylibre.com>
In-Reply-To: <20190513091548.16674-2-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 May 2019 13:37:29 +0200
Message-ID: <CAPDyKFr9HVLNpqncs6YhGvqPdXCk6mtVSPVcWDvmnrKiNB+ACQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: meson-gx: add ddr-access-quirk property
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        DTML <devicetree@vger.kernel.org>,
        baylibre-upstreaming@groups.io,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 at 11:16, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On the Amlogic G12A SoC family, (only) the SDIO controller has a bug which
> makes any DDR access from the MMC controller fail.
>
> Add the amlogic,ddr-access-quirk property so signal this particular
> controller has this bug and needs a quirk to work properly.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> index 13e70409e8ac..f8914dab06c6 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> @@ -22,6 +22,10 @@ Required properties:
>    clock rate requested by the MMC core.
>  - resets     : phandle of the internal reset line
>
> +Optional properties:
> +- amlogic,ddr-access-quirk: set when HW cannot access the DDR memory, like on
> +  the G12A SDIO controller.

As stated on the other patch, may I suggest to use DRAM instead of DDR.

Moreover, please mention that this is about the internal DMA support
of the controller.

> +
>  Example:
>
>         sd_emmc_a: mmc@70000 {
> --
> 2.21.0
>

Kind regards
Uffe
