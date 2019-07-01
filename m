Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412E65706F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 20:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfFZSQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 14:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZSQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:16:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFA6321726;
        Wed, 26 Jun 2019 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561572997;
        bh=sab0MWfiVzl74QqPr+RXCGs4tGCyw2k4Qdv+3xOa4JE=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=q4reBCx0kjurRaRwQCFE39ixbHBA2Xo4uCyhZOrdRVtkOSq4ksMmBuWxBZ/ncAR+V
         WcKjBtg17QGOSQFwRdt62OI1c10cduhAP01gt9k9k7shRRzAZDGvfPy3uQ3aXeQJmc
         lXi5yN5NLGb4ob6mJix5G6MAaeGT/9Hx9/EpSPDs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190522011504.19342-2-zhang.chunyan@linaro.org>
References: <20190522011504.19342-1-zhang.chunyan@linaro.org> <20190522011504.19342-2-zhang.chunyan@linaro.org>
To:     Chunyan Zhang <zhang.chunyan@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/3] clk: sprd: Switch from of_iomap() to devm_ioremap_resource()
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
User-Agent: alot/0.8.1
Date:   Wed, 26 Jun 2019 11:16:36 -0700
Message-Id: <20190626181637.CFA6321726@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2019-05-21 18:15:01)
> devm_ioremap_resources() automatically requests resources and devm_ wrapp=
ers
> do better error handling and unmapping of the I/O region when needed,
> that would make drivers more clean and simple.
>=20
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

Applied to clk-next

> diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
> index e038b0447206..9ce690999eaa 100644
> --- a/drivers/clk/sprd/common.c
> +++ b/drivers/clk/sprd/common.c
> @@ -50,7 +51,11 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
>                         return PTR_ERR(regmap);
>                 }
>         } else {
> -               base =3D of_iomap(node, 0);
> +               res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +               base =3D devm_ioremap_resource(&pdev->dev, res);
> +               if (IS_ERR(base))

There's also devm_platform_ioremap_resource() if you want to save even
more lines!

> +                       return PTR_ERR(base);
> +
