Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7727E14C5FB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgA2Fmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:42:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgA2Fmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:42:54 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F8CD2071E;
        Wed, 29 Jan 2020 05:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580276573;
        bh=Srd47iZ1QD/K9zqx4GrY3uF68yiZ8dAcEhHeATBX5WM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=aON+qyPEkoC+i3w9hHfhBnQMMCC8gdc2FyD3ftJl+KIQjg5hT3qY4pAVyVFVtHFwE
         vegrZjwjTPkd/TuQ+bPcYyDPxRuBF8tcCiWX7mpMbeNo0XrVbaKeZGeDl3oKZhsWGX
         duq6HMmRLplmAKTFD74a9bRkU4eeNtjv9BA+mztw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200116080440.118679-6-jian.hu@amlogic.com>
References: <20200116080440.118679-1-jian.hu@amlogic.com> <20200116080440.118679-6-jian.hu@amlogic.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 5/5] clk: meson: a1: add support for Amlogic A1 Peripheral clock driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 28 Jan 2020 21:42:52 -0800
Message-Id: <20200129054253.6F8CD2071E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jian Hu (2020-01-16 00:04:40)
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> new file mode 100644
> index 000000000000..2cf20ae1db75
> --- /dev/null
> +++ b/drivers/clk/meson/a1.c
> @@ -0,0 +1,2249 @@
[...]
> +       &a1_ceca_32k_clkout,
> +       &a1_cecb_32k_clkin,
> +       &a1_cecb_32k_div,
> +       &a1_cecb_32k_sel_pre,
> +       &a1_cecb_32k_sel,
> +       &a1_cecb_32k_clkout,
> +};
> +
> +static struct regmap_config clkc_regmap_config =3D {

Can this be const?

> +       .reg_bits       =3D 32,
> +       .val_bits       =3D 32,
> +       .reg_stride     =3D 4,
> +};
> +
> +static int meson_a1_periphs_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct resource *res;
> +       void __iomem *base;
> +       struct regmap *map;
> +       int ret, i;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +       base =3D devm_ioremap_resource(dev, res);

Can you use the combination function that does the get resource and
ioremap in one function?

> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       map =3D devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
> +       if (IS_ERR(map))
> +               return PTR_ERR(map);
> +
> +       /* Populate regmap for the regmap backed clocks */

Seems like a useless comment.

> +       for (i =3D 0; i < ARRAY_SIZE(a1_periphs_regmaps); i++)
> +               a1_periphs_regmaps[i]->map =3D map;
> +
