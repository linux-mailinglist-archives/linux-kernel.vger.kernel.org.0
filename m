Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D89C7FD87F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 10:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfKOJLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 04:11:20 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:45865 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKOJLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:11:17 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MDgtl-1icvsi2c6h-00AlU4 for <linux-kernel@vger.kernel.org>; Fri, 15 Nov
 2019 10:11:15 +0100
Received: by mail-qv1-f48.google.com with SMTP id v16so3513276qvq.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 01:11:15 -0800 (PST)
X-Gm-Message-State: APjAAAVjqbydbac4xom0StAO09hIeAg/dvWEtOyecID7iiI0cKdz/idp
        dFf0F+/OM+S/sZfflUFAcoVpxrvo2+mmGk7j2BM=
X-Google-Smtp-Source: APXvYqz9RK5z2XbGxnTimA2wUl2cP5ll+VAR0trY1cR79bAG3pFyzevcMug4bItRDzyMNcJ2iYh/QxZSQ7DloNuegIM=
X-Received: by 2002:ad4:404e:: with SMTP id r14mr353152qvp.4.1573809074551;
 Fri, 15 Nov 2019 01:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20191115084931.77161-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20191115084931.77161-1-andriy.shevchenko@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Nov 2019 10:10:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3pFDPa49rXT3hbkptvqsRk5NdVimUT=x8-tGoZKH0yRQ@mail.gmail.com>
Message-ID: <CAK8P3a3pFDPa49rXT3hbkptvqsRk5NdVimUT=x8-tGoZKH0yRQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mfd: syscon: Re-use resource_size() to count max_register
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RMBoBhVAzRYQINMyKCb0z8GPuFQi7ldRheE99NyZNlZwDkXNoVJ
 aa2qR0/AziRGgkvTXcqi53aJ3OcmbqMU2VbUNCyYcU2X+dY4TqHSYYWs0THsnJRFcX7QNNd
 OT2UOXOaRKMzRVjb/mxQSY0dOzTbdGTKj29Bscj+ck4H9M50zkkOgaMlUm4uACeL92PaR0f
 8xMRbU59myf0TfealtxQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PMJL2C6d9NI=:yVn+lU98cDU2O1lH8LC7o8
 oSK7tnCIQLrNH+9HAnn46lGgfMroq188nY0KYbTzoJW2AJAXm8co8pIO77eQtNVTpYbX8PM2D
 H3FLatiJO0MtlFt73PUnC5S9G2fdfjBSWkfcAK/2WNEYpe2TFlFbkPFDtIolAPZTX5UzZ7Lpa
 9cg21kMdKIp7edQvSVqurZmN2P0Vvk3Ey10EQ6sYF/D68D6Pvamk4/6EHVHVk4Zjt8IT7qFd5
 l33MX6Vcv7v/K1OVhRLVbTIr8SFZ5EgEaOYDrZheh0XBmL8WFItLeEa0UeeU1sPAogfgTB5HT
 Wk3MXOYrC55eZcBjM0Fze+t1TpNtsYBRNAm3w20gN2nwxkJVzNCA+3nMemx/CzuV9Uvkl4vUO
 6BSVz0qD2qonR9bfe3Q/mIZjIlJ4OoMXeuU7dTp25bZBegRP96V3Sodlrt7HDaPWqVAt1QGRE
 3HaJ5D0kdy3y8yjMUoUM129sE0HOjw50efQENH7ekA5A6gWiOBaP6wgfnfLBbBRcSv/B4oYTO
 /qjglUIxst5jkGhRdd8zYzb22Z7A/T7DUO9O1/bLH4/NKiNmROEBduFlCFn3Z5QWxA3GQp38b
 h5iaGsk4ixd+ge7jT2kHEw9m4sL9EipMX63BIFwo7owpg8mAX9N06g/tNM6RcbGfC/snr/Vv5
 ZFBUb7O8mBE2f3XPx15nwhJxc7DvzSW1nxIAHy2zjfq+ZUjV5U6YKWofL2qy5WNtX42bKEhBa
 2U8ItA6C+U3oy4237qmj8gL6ZeXqxWZJn+OKWueL+9HxALdXDxE4aBfEi2VqXwaR6/MXktWFo
 utpVqDQy6VtE4UbM43+pf1IfUPyuWqAI9xMNs2ND9hy89pxhIqXlko/iEM7eOXYE4quQkCZ3T
 Comh5pBR2UfTDOTgmlZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 9:49 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Instead of open coded variant use resource_size() and replace
> weird '- 3' to more understandable '- 4'.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>

>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index e22197c832e8..13626bb2d432 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -245,7 +245,7 @@ static int syscon_probe(struct platform_device *pdev)
>         if (!base)
>                 return -ENOMEM;
>
> -       syscon_config.max_register = res->end - res->start - 3;
> +       syscon_config.max_register = resource_size(res) - 4;
>         if (pdata)
>                 syscon_config.name = pdata->label;
>         syscon->regmap = devm_regmap_init_mmio(dev, base, &syscon_config);
> --
> 2.24.0
>
