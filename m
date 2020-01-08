Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A407D13418E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgAHMXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 07:23:23 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40261 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgAHMXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:23:21 -0500
Received: by mail-pj1-f66.google.com with SMTP id bg7so1000110pjb.5;
        Wed, 08 Jan 2020 04:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDt3/BmyCi3mmATBGnzyjL+1pu0FJmQfjeOFbDPbHbs=;
        b=mr0z9Qd3OHCtlC7Y1VH+a5kwe2AtiJHdt5NH8/suy8BPRJjgUTP8848yfITr8/2Qb0
         7Sxi9R+vcvxEEpKXOviY9Mt3vpLogXiZnsaDxKzISWnrCe2MC6ySwZsNTlOEp9e8ebJy
         LeHjyzrSOH3NSHCYw7AFx56h0TMdX+wNvxxhQGxiVrPgHVHjkRxQy+ac3sy+yzu42Tsz
         RNM2bS40U6yi1fHultAIDEQ8X2tw/hcntfPqB4ZcBXOTuIOfE31NDZXHPSTogDqM+ohZ
         NvklttjOgdW6pbz3xBKPQV6L2g4O91C2N8NwcO447Jzt4TYPVwS7j9vXfaGHkdtAUccc
         ZvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDt3/BmyCi3mmATBGnzyjL+1pu0FJmQfjeOFbDPbHbs=;
        b=mr4WyFaIiXXtQAUKrtg6tNGtUPqem8ldC5I3kMivQbBr3XkcbO0wFwsFSyYDbtBMXN
         H9ezs8Y31Q+ZbudDXgZZNxW9pr6fyYD8xH6pWBQbdKDXZcxBifPQIctCVKXt1BVGHCLh
         OHhhvaQaEOY0CivqK/pcLKHYoS6snb7wDJXjIf6UAIdXB+Iyn0NpsEYz1bSFzuuQyjUn
         W2hn6iWBpmyjLFLjTBqNmPb5caiSDRlcQoscfS/lykheBOlV+EevbY69tVy7JqaXfgTv
         P+6B5XLlGvpqw0GIbacJbOtGZqmgdWpr8dmBXq2vxGxQKxYIP7ejw+HzAVKrx/vAY9ri
         TXzQ==
X-Gm-Message-State: APjAAAWXtLy8KcdSkpG4xNzrugynuPY1CWyRw21i1OYq4SuRgybew7nd
        BA7dk2Nt/Ri1puatWjnYhpAADS8LCLCfjwmMTEM=
X-Google-Smtp-Source: APXvYqwUPjcUZSMwCFvi1PiYTPG4JryE3mqB72Ywf4lMGCoFsW6uzceoa/MK0SVe6wXNAuAPSIxN9OksFbp3SExd9L8=
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr4033544pjb.30.1578486200238;
 Wed, 08 Jan 2020 04:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20200106144219.525215-1-hdegoede@redhat.com> <20200106144219.525215-2-hdegoede@redhat.com>
In-Reply-To: <20200106144219.525215-2-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Jan 2020 14:23:11 +0200
Message-ID: <CAHp75Ve5XF-UZw6D-OUCkgOPMYH0DgT1L5uVNGRuLmZ6Cjd1KA@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: GPD pocket fan: Allow somewhat
 lower/higher temperature limits
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Anderson <jasona.594@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 4:42 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Allow the user to configure the fan to turn on / speed-up at lower
> thresholds then before (20 degrees Celcius as minimum instead of 40) and
> likewise also allow the user to delay the fan speeding-up till the
> temperature hits 90 degrees Celcius (was 70).
>
> Cc: Jason Anderson <jasona.594@gmail.com>

> Reported-by: Jason Anderson <jasona.594@gmail.com>

My understanding of this tag that the report assumes a bug to fix
followed up with a corresponding Fixes tag.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/gpd-pocket-fan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/gpd-pocket-fan.c b/drivers/platform/x86/gpd-pocket-fan.c
> index 1e6a42f2ea8a..0ffcbf9bc18e 100644
> --- a/drivers/platform/x86/gpd-pocket-fan.c
> +++ b/drivers/platform/x86/gpd-pocket-fan.c
> @@ -126,7 +126,7 @@ static int gpd_pocket_fan_probe(struct platform_device *pdev)
>         int i;
>
>         for (i = 0; i < ARRAY_SIZE(temp_limits); i++) {
> -               if (temp_limits[i] < 40000 || temp_limits[i] > 70000) {
> +               if (temp_limits[i] < 20000 || temp_limits[i] > 90000) {
>                         dev_err(&pdev->dev, "Invalid temp-limit %d (must be between 40000 and 70000)\n",
>                                 temp_limits[i]);
>                         temp_limits[0] = TEMP_LIMIT0_DEFAULT;
> --
> 2.24.1
>


-- 
With Best Regards,
Andy Shevchenko
