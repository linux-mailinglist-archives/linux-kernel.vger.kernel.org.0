Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A01A123D69
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 03:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLRCrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 21:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfLRCrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:47:00 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F37924679
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 02:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576637220;
        bh=EN9XGbtCVFK944Al0uckJBpC3fwAtS4+X+y3O5WYLdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W8gElQ6oUB4T3v7WLZo0xo/RWlXTJ4G1338qddAWGZocy4sQqcExFpivqsupYWXw9
         /ez6h5tkCZx9ba0610UE/DI1i4tgrsUycRKdOiENqXqww6Q0OXbHnweB1/hYYQAhrs
         QvkVbsingA+2bcvptfW18RFWZ4ILB/e70Otx2yqY=
Received: by mail-wr1-f41.google.com with SMTP id c14so591608wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 18:47:00 -0800 (PST)
X-Gm-Message-State: APjAAAWkZ72bfyfWUxGswrFQeaY4bMN18HJspKX2vKSP0tUIzrO9BnDt
        8hL/ybr0F13z8uDis2VzukN+1XaDxlqgnlkIXQU=
X-Google-Smtp-Source: APXvYqysa4a+4xeUb9YQTX1Eh4yJtSOADgVQZkRKpq63DrhasVdvKDjwwOKDppLi9wiOP9XubpNTkYeEip1VsbgqxhI=
X-Received: by 2002:adf:cf12:: with SMTP id o18mr1139856wrj.361.1576637218572;
 Tue, 17 Dec 2019 18:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20191210203149.7115-1-tiny.windzz@gmail.com> <20191210203149.7115-2-tiny.windzz@gmail.com>
In-Reply-To: <20191210203149.7115-2-tiny.windzz@gmail.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Wed, 18 Dec 2019 10:46:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v65vb0HOHS18-z2dzu=icQGssKtSNWGKa9Uy5dYREURheg@mail.gmail.com>
Message-ID: <CAGb2v65vb0HOHS18-z2dzu=icQGssKtSNWGKa9Uy5dYREURheg@mail.gmail.com>
Subject: Re: [PATCH 1/5] nvmem: sunxi_sid: convert to devm_platform_ioremap_resource
To:     Yangtao Li <tiny.windzz@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mans Rullgard <mans@mansr.com>,
        Thierry Reding <treding@nvidia.com>, suzuki.poulose@arm.com,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 4:32 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/nvmem/sunxi_sid.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index e26ef1bbf198..c54adf60b155 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -112,7 +112,6 @@ static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
>  static int sunxi_sid_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> -       struct resource *res;
>         struct nvmem_config *nvmem_cfg;
>         struct nvmem_device *nvmem;
>         struct sunxi_sid *sid;
> @@ -129,8 +128,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         sid->value_offset = cfg->value_offset;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       sid->base = devm_ioremap_resource(dev, res);
> +       sid->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(sid->base))
>                 return PTR_ERR(sid->base);
>
> --
> 2.17.1
>
