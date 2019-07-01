Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659CA326AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 04:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfFCChB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 22:37:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35866 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726305AbfFCChA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 22:37:00 -0400
X-UUID: c958918fd11d4c02a51eee9d2bcd5f82-20190603
X-UUID: c958918fd11d4c02a51eee9d2bcd5f82-20190603
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1703332544; Mon, 03 Jun 2019 10:36:56 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Jun 2019 10:36:55 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Jun 2019 10:36:55 +0800
Message-ID: <1559529415.6663.10.camel@mtkswgap22>
Subject: Re: [PATCH v2 3/3] hwrng: add mtk-sec-rng driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Crystal Guo <Crystal.Guo@mediatek.com>
Date:   Mon, 3 Jun 2019 10:36:55 +0800
In-Reply-To: <CAGp9LzoC7d9MaCv4OSm5yEGP845zeoQ=Fas_MgZGzSUCeWZ=ww@mail.gmail.com>
References: <1558946326-13630-1-git-send-email-neal.liu@mediatek.com>
         <1558946326-13630-4-git-send-email-neal.liu@mediatek.com>
         <CAGp9LzoC7d9MaCv4OSm5yEGP845zeoQ=Fas_MgZGzSUCeWZ=ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Thu, 2019-05-30 at 15:59 -0700, Sean Wang wrote:
> Hi, Neal
> 
> On Mon, May 27, 2019 at 1:39 AM Neal Liu <neal.liu@mediatek.com> wrote:
> >
> > For MediaTek SoCs on ARMv8 with TrustZone enabled, peripherals like
> > entropy sources is not accessible from normal world (linux) and
> > rather accessible from secure world (ATF/TEE) only. This driver aims
> > to provide a generic interface to ATF rng service.
> >
> > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > ---
> >  drivers/char/hw_random/Kconfig       |   16 ++++++
> >  drivers/char/hw_random/Makefile      |    1 +
> >  drivers/char/hw_random/mtk-sec-rng.c |   97 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 114 insertions(+)
> >  create mode 100644 drivers/char/hw_random/mtk-sec-rng.c
> >
> > diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> > index 25a7d8f..6c82a3b 100644
> > --- a/drivers/char/hw_random/Kconfig
> > +++ b/drivers/char/hw_random/Kconfig
> > @@ -398,6 +398,22 @@ config HW_RANDOM_MTK
> >
> >           If unsure, say Y.
> >
> > +config HW_RANDOM_MTK_SEC
> > +       tristate "MediaTek Security Random Number Generator support"
> > +       depends on HW_RANDOM
> > +       depends on ARCH_MEDIATEK || COMPILE_TEST
> > +       default HW_RANDOM
> > +       help
> > +         This driver provides kernel-side support for the Random Number
> > +         Generator hardware found on MediaTek SoCs. The difference with
> > +         mtk-rng is the Random Number Generator hardware is secure
> > +         access only.
> > +
> > +         To compile this driver as a module, choose M here. the
> > +         module will be called mtk-sec-rng.
> > +
> > +         If unsure, say Y.
> > +
> >  config HW_RANDOM_S390
> >         tristate "S390 True Random Number Generator support"
> >         depends on S390
> > diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
> > index 7c9ef4a..0ae4993 100644
> > --- a/drivers/char/hw_random/Makefile
> > +++ b/drivers/char/hw_random/Makefile
> > @@ -36,6 +36,7 @@ obj-$(CONFIG_HW_RANDOM_PIC32) += pic32-rng.o
> >  obj-$(CONFIG_HW_RANDOM_MESON) += meson-rng.o
> >  obj-$(CONFIG_HW_RANDOM_CAVIUM) += cavium-rng.o cavium-rng-vf.o
> >  obj-$(CONFIG_HW_RANDOM_MTK)    += mtk-rng.o
> > +obj-$(CONFIG_HW_RANDOM_MTK_SEC) += mtk-sec-rng.o
> >  obj-$(CONFIG_HW_RANDOM_S390) += s390-trng.o
> >  obj-$(CONFIG_HW_RANDOM_KEYSTONE) += ks-sa-rng.o
> >  obj-$(CONFIG_HW_RANDOM_OPTEE) += optee-rng.o
> > diff --git a/drivers/char/hw_random/mtk-sec-rng.c b/drivers/char/hw_random/mtk-sec-rng.c
> > new file mode 100644
> > index 0000000..4c6e5bf
> > --- /dev/null
> > +++ b/drivers/char/hw_random/mtk-sec-rng.c
> > @@ -0,0 +1,97 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2019 MediaTek Inc.
> > + */
> > +
> > +#include <linux/arm-smccc.h>
> > +#include <linux/hw_random.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/soc/mediatek/mtk_sip_svc.h>
> > +
> > +#define MT67XX_RNG_MAGIC       0x74726e67
> > +#define SMC_RET_NUM            4
> > +#define MTK_SEC_RND_SIZE       (sizeof(u32) * SMC_RET_NUM)
> > +
> > +struct mtk_sec_rng_priv {
> > +       struct hwrng rng;
> > +};
> > +
> > +static void mtk_sec_get_rnd(uint32_t *val)
> > +{
> > +       struct arm_smccc_res res;
> > +
> > +       arm_smccc_smc(MTK_SIP_KERNEL_GET_RND,
> > +                     MT67XX_RNG_MAGIC, 0, 0, 0, 0, 0, 0, &res);
> > +
> > +       val[0] = res.a0;
> > +       val[1] = res.a1;
> > +       val[2] = res.a2;
> > +       val[3] = res.a3;
> > +}
> > +
> > +static int mtk_sec_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> > +{
> > +       size_t get_rnd_size = MTK_SEC_RND_SIZE;
> 
> the variable get_rnd_size can be further eliminated

Yes, sure. I'll send new patchset to eliminate this variable, Thanks

> 
> > +       u32 val[4] = {0};
> > +       int i, retval = 0;
> > +
> > +       while (max >= get_rnd_size) {
> > +               mtk_sec_get_rnd(val);
> > +
> > +               for (i = 0; i < SMC_RET_NUM; i++) {
> > +                       *(u32 *)buf = val[i];
> > +                       buf += sizeof(u32);
> > +               }
> > +
> > +               retval += get_rnd_size;
> > +               max -= get_rnd_size;
> > +       }
> > +
> > +       return retval;
> > +}
> > +
> > +static int mtk_sec_rng_probe(struct platform_device *pdev)
> > +{
> > +       struct mtk_sec_rng_priv *priv;
> > +       int ret;
> > +
> > +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       priv->rng.name = pdev->name;
> > +       priv->rng.read = mtk_sec_rng_read;
> > +       priv->rng.priv = (unsigned long)&pdev->dev;
> > +       priv->rng.quality = 900;
> > +
> > +       ret = devm_hwrng_register(&pdev->dev, &priv->rng);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failed to register rng device: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id mtk_sec_rng_match[] = {
> > +       { .compatible = "mediatek,mtk-sec-rng", },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, mtk_sec_rng_match);
> > +
> > +static struct platform_driver mtk_sec_rng_driver = {
> > +       .probe = mtk_sec_rng_probe,
> > +       .driver = {
> > +               .name = KBUILD_MODNAME,
> > +               .owner = THIS_MODULE,
> > +               .of_match_table = mtk_sec_rng_match,
> > +       },
> > +};
> > +
> > +module_platform_driver(mtk_sec_rng_driver);
> > +
> > +MODULE_DESCRIPTION("MediaTek Security Random Number Generator Driver");
> > +MODULE_AUTHOR("Neal Liu <neal.liu@mediatek.com>");
> > +MODULE_LICENSE("GPL");
> > --
> > 1.7.9.5
> >


