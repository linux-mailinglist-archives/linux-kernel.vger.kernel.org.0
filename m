Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1923BBE0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 17:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438583AbfIYPFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 11:05:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34394 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbfIYPFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:05:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so3643943pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0mVPTtIEGBf/i1OTZx5X2Frq3cCAYmFpUmTrmx+C5IM=;
        b=M0T2WR1FdwSsBjg6AEbvd64l5LnvcXW45oHiM6i5lW5nMg79K4TLIk6O8u/4Dyc00l
         6wYPvjGXqmAAZdr0dEWSO3iRb7u7QIS2bFZ6WhLWUdgx0vgmMSLAqMhBljj8xcxw+G+b
         5wjzUBqqcFQvjITPi0jAtmgOlyF3X6vccN+RlQ8yIrA+lNXJHbrU0qRWnYoNTLmtW21m
         3uDApXWj8FuPslhkMBDiGNP2Q40oHUKb6LehkwjlIAihbY1hlPxIoLNkhq2zSWcFkLBO
         XaOhpSgzU6D9aHKjNTdnJVFLixy78sJzjB/FxZfrwutZIKEwrUDv3oq6uSoMnNjBlgWJ
         5IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mVPTtIEGBf/i1OTZx5X2Frq3cCAYmFpUmTrmx+C5IM=;
        b=H+hlVhB25k2lAHTtLz40Xp0lQ4kgkciTSo+4T6IDej15xLuaLC5khnRWEnYw+8BN+A
         DjveN0umHrgIzt1EoxmEScN3dZzJQ4RRs//p/Id+toMih1rIrJEjP1EW7075JZmXnl+7
         NtvmuuZQLKL4TvJ9X+ooQxZkP7ccn0Ir0iw3PkKyPHDAIDESQ3JbZ8jhc3O2HZVtfEPP
         kB5RmUfOiDVDwgBhSleSiuYW7v2i4VKNvoP1YYluY1jdMxypcv7RSSfS4UHrQOT1xMj8
         BWM8hLXqqnap33GhzRRxr+i+bAILNgZgQ/hTaZcIPmhfBahiX+OeukTIy48BPm3DrTNK
         98Ow==
X-Gm-Message-State: APjAAAWzW/sImk4zlzKPgUZt1PtqEWKXo1J5Wwd3uZBFeOoGTDkYXd+c
        yEngTyogFcO1ScHNp3uGlr37O+61I8a3MDdG094=
X-Google-Smtp-Source: APXvYqxMLCTJlEGLBxLwzA+jpM5uRjcu0oP/k9wLtaxxcQf5zF3njNSyWzKWvv/WNpq/m2gOfEYtRuiU8dySeFKUaSo=
X-Received: by 2002:a63:1cd:: with SMTP id 196mr9171128pgb.74.1569423905865;
 Wed, 25 Sep 2019 08:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VdQES5oasGzi0JdnZAEL2AfCozHJaHBa9dpg1Ya_N17-A@mail.gmail.com>
 <20190920111207.129106-1-wangkefeng.wang@huawei.com> <20190920111207.129106-3-wangkefeng.wang@huawei.com>
In-Reply-To: <20190920111207.129106-3-wangkefeng.wang@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Sep 2019 18:04:55 +0300
Message-ID: <CAHp75VesyCCKqHKfa-L9gW7sufJZs2Tm60OgrgkY_H0ZcEuDYA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] platform/x86: intel_oaktrail: Use pr_warn instead
 of pr_warning
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 1:55 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> pr_warning"), removing pr_warning so all logging messages use a
> consistent <prefix>_warn style. Let's do it.
>

You have to send to proper mailing lists and people.
Don't spam the rest!

> Cc: Corentin Chary <corentin.chary@gmail.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/platform/x86/intel_oaktrail.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_oaktrail.c b/drivers/platform/x86/intel_oaktrail.c
> index 3c0438ba385e..1a09a75bd16d 100644
> --- a/drivers/platform/x86/intel_oaktrail.c
> +++ b/drivers/platform/x86/intel_oaktrail.c
> @@ -243,7 +243,7 @@ static int oaktrail_backlight_init(void)
>
>         if (IS_ERR(bd)) {
>                 oaktrail_bl_device = NULL;
> -               pr_warning("Unable to register backlight device\n");
> +               pr_warn("Unable to register backlight device\n");
>                 return PTR_ERR(bd);
>         }
>
> @@ -313,20 +313,20 @@ static int __init oaktrail_init(void)
>
>         ret = platform_driver_register(&oaktrail_driver);
>         if (ret) {
> -               pr_warning("Unable to register platform driver\n");
> +               pr_warn("Unable to register platform driver\n");
>                 goto err_driver_reg;
>         }
>
>         oaktrail_device = platform_device_alloc(DRIVER_NAME, -1);
>         if (!oaktrail_device) {
> -               pr_warning("Unable to allocate platform device\n");
> +               pr_warn("Unable to allocate platform device\n");
>                 ret = -ENOMEM;
>                 goto err_device_alloc;
>         }
>
>         ret = platform_device_add(oaktrail_device);
>         if (ret) {
> -               pr_warning("Unable to add platform device\n");
> +               pr_warn("Unable to add platform device\n");
>                 goto err_device_add;
>         }
>
> @@ -338,7 +338,7 @@ static int __init oaktrail_init(void)
>
>         ret = oaktrail_rfkill_init();
>         if (ret) {
> -               pr_warning("Setup rfkill failed\n");
> +               pr_warn("Setup rfkill failed\n");
>                 goto err_rfkill;
>         }
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
