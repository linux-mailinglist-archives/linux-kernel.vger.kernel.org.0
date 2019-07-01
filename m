Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300A430519
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 00:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfE3W7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 18:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfE3W7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 18:59:49 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28926262D3;
        Thu, 30 May 2019 22:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559257188;
        bh=G5YV9O22/1UxV1YJU/dGvKTsjODYWPEfxn4+6TUmwRM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1+7zl0SfC/X2D0gNL1k3wm1QWcK2VPavqXVccW8VYlMSMzZ11QgWzoGfKWYnj8Ofe
         QoYRlo6TQzJScsYRkpScQuH57s2k9mXuB4353Mxc7Wq569GXOnr5+wWw8i5SizCylG
         QhpPPWgzTjIOeQFXVtPXYVdRQVCzDqzSYNv50D2c=
Received: by mail-wm1-f50.google.com with SMTP id d17so4894387wmb.3;
        Thu, 30 May 2019 15:59:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWXzYnIw/0OuyGxpE9T8O5+7wkowkK680aL1T7qWrrmfdzUILuU
        I3Tf9f7ZQdDXYYBq668O0h1/Zn9jJEB79tmUuwM=
X-Google-Smtp-Source: APXvYqwClGtyBz+ZnXOQGQAF7++JFFoH2RLfaSB7q56mYro/VASYaiqO81qOsisdoVlT8WS2G26HMrA07OjDSwr8tAg=
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr3656544wmh.152.1559257186685;
 Thu, 30 May 2019 15:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <1558946326-13630-1-git-send-email-neal.liu@mediatek.com> <1558946326-13630-4-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1558946326-13630-4-git-send-email-neal.liu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 30 May 2019 15:59:36 -0700
X-Gmail-Original-Message-ID: <CAGp9LzoC7d9MaCv4OSm5yEGP845zeoQ=Fas_MgZGzSUCeWZ=ww@mail.gmail.com>
Message-ID: <CAGp9LzoC7d9MaCv4OSm5yEGP845zeoQ=Fas_MgZGzSUCeWZ=ww@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hwrng: add mtk-sec-rng driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, wsd_upstream@mediatek.com,
        Crystal Guo <Crystal.Guo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neal

On Mon, May 27, 2019 at 1:39 AM Neal Liu <neal.liu@mediatek.com> wrote:
>
> For MediaTek SoCs on ARMv8 with TrustZone enabled, peripherals like
> entropy sources is not accessible from normal world (linux) and
> rather accessible from secure world (ATF/TEE) only. This driver aims
> to provide a generic interface to ATF rng service.
>
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---
>  drivers/char/hw_random/Kconfig       |   16 ++++++
>  drivers/char/hw_random/Makefile      |    1 +
>  drivers/char/hw_random/mtk-sec-rng.c |   97 ++++++++++++++++++++++++++++++++++
>  3 files changed, 114 insertions(+)
>  create mode 100644 drivers/char/hw_random/mtk-sec-rng.c
>
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index 25a7d8f..6c82a3b 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -398,6 +398,22 @@ config HW_RANDOM_MTK
>
>           If unsure, say Y.
>
> +config HW_RANDOM_MTK_SEC
> +       tristate "MediaTek Security Random Number Generator support"
> +       depends on HW_RANDOM
> +       depends on ARCH_MEDIATEK || COMPILE_TEST
> +       default HW_RANDOM
> +       help
> +         This driver provides kernel-side support for the Random Number
> +         Generator hardware found on MediaTek SoCs. The difference with
> +         mtk-rng is the Random Number Generator hardware is secure
> +         access only.
> +
> +         To compile this driver as a module, choose M here. the
> +         module will be called mtk-sec-rng.
> +
> +         If unsure, say Y.
> +
>  config HW_RANDOM_S390
>         tristate "S390 True Random Number Generator support"
>         depends on S390
> diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
> index 7c9ef4a..0ae4993 100644
> --- a/drivers/char/hw_random/Makefile
> +++ b/drivers/char/hw_random/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_HW_RANDOM_PIC32) += pic32-rng.o
>  obj-$(CONFIG_HW_RANDOM_MESON) += meson-rng.o
>  obj-$(CONFIG_HW_RANDOM_CAVIUM) += cavium-rng.o cavium-rng-vf.o
>  obj-$(CONFIG_HW_RANDOM_MTK)    += mtk-rng.o
> +obj-$(CONFIG_HW_RANDOM_MTK_SEC) += mtk-sec-rng.o
>  obj-$(CONFIG_HW_RANDOM_S390) += s390-trng.o
>  obj-$(CONFIG_HW_RANDOM_KEYSTONE) += ks-sa-rng.o
>  obj-$(CONFIG_HW_RANDOM_OPTEE) += optee-rng.o
> diff --git a/drivers/char/hw_random/mtk-sec-rng.c b/drivers/char/hw_random/mtk-sec-rng.c
> new file mode 100644
> index 0000000..4c6e5bf
> --- /dev/null
> +++ b/drivers/char/hw_random/mtk-sec-rng.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 MediaTek Inc.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/hw_random.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/mediatek/mtk_sip_svc.h>
> +
> +#define MT67XX_RNG_MAGIC       0x74726e67
> +#define SMC_RET_NUM            4
> +#define MTK_SEC_RND_SIZE       (sizeof(u32) * SMC_RET_NUM)
> +
> +struct mtk_sec_rng_priv {
> +       struct hwrng rng;
> +};
> +
> +static void mtk_sec_get_rnd(uint32_t *val)
> +{
> +       struct arm_smccc_res res;
> +
> +       arm_smccc_smc(MTK_SIP_KERNEL_GET_RND,
> +                     MT67XX_RNG_MAGIC, 0, 0, 0, 0, 0, 0, &res);
> +
> +       val[0] = res.a0;
> +       val[1] = res.a1;
> +       val[2] = res.a2;
> +       val[3] = res.a3;
> +}
> +
> +static int mtk_sec_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> +{
> +       size_t get_rnd_size = MTK_SEC_RND_SIZE;

the variable get_rnd_size can be further eliminated

> +       u32 val[4] = {0};
> +       int i, retval = 0;
> +
> +       while (max >= get_rnd_size) {
> +               mtk_sec_get_rnd(val);
> +
> +               for (i = 0; i < SMC_RET_NUM; i++) {
> +                       *(u32 *)buf = val[i];
> +                       buf += sizeof(u32);
> +               }
> +
> +               retval += get_rnd_size;
> +               max -= get_rnd_size;
> +       }
> +
> +       return retval;
> +}
> +
> +static int mtk_sec_rng_probe(struct platform_device *pdev)
> +{
> +       struct mtk_sec_rng_priv *priv;
> +       int ret;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->rng.name = pdev->name;
> +       priv->rng.read = mtk_sec_rng_read;
> +       priv->rng.priv = (unsigned long)&pdev->dev;
> +       priv->rng.quality = 900;
> +
> +       ret = devm_hwrng_register(&pdev->dev, &priv->rng);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to register rng device: %d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mtk_sec_rng_match[] = {
> +       { .compatible = "mediatek,mtk-sec-rng", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, mtk_sec_rng_match);
> +
> +static struct platform_driver mtk_sec_rng_driver = {
> +       .probe = mtk_sec_rng_probe,
> +       .driver = {
> +               .name = KBUILD_MODNAME,
> +               .owner = THIS_MODULE,
> +               .of_match_table = mtk_sec_rng_match,
> +       },
> +};
> +
> +module_platform_driver(mtk_sec_rng_driver);
> +
> +MODULE_DESCRIPTION("MediaTek Security Random Number Generator Driver");
> +MODULE_AUTHOR("Neal Liu <neal.liu@mediatek.com>");
> +MODULE_LICENSE("GPL");
> --
> 1.7.9.5
>
