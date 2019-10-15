Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72BB0D74FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 13:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfJOLa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 07:30:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35990 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfJOLa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:30:56 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so45011184iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 04:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RtwLgNKRpNhkyME3bQOf88dgkJJDIAzn5Urw+0dKu8o=;
        b=L9l1RVAZWtRMjwo9mgda6cYzzwo/ZDddO4aGEggqlHK5KVLj8p2CWHhBay+AwBP8YH
         elSQfW0uePz/Bxlnj6/9BMXOVSdQeg6eQ2DIXMGMoWOg3mD9QuDAUz/QTKX490qHGano
         P0WO2GVXTK0VPvizc9AMG2RMDeFKYWVmyPOXOK/DTgItrmo/PAPZ5M81PFyoDvj85RPa
         EOpFDRozCaqpHaPqwP1SmyFWgfgPLERvbHypU5pDnhLfZo2X54fM5Ce5NaPgNm5c0Gyk
         WJABLiYniRJFuC/iQjz4L9RRVElVihthqw2LXfXMDnLSOsgRneilnATV7FP3C81f+iM4
         1dkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RtwLgNKRpNhkyME3bQOf88dgkJJDIAzn5Urw+0dKu8o=;
        b=SGEqiuIfHBn+ZRsTRFE3sbtHWgu2Kk4MO9L/X46C5DLR05DqypsICOSz3ksVCYjmA5
         Tj2YuSxxGH1ykjY87PN8f9lAM6rOqmLA6kdnXp3nU2DZYTSqDAdgv/gODRiU/doWnO1V
         RTR9CMWeJ56ItJf3HeWSKXgGInPAlXU4H37+BFi2yrv7OK0aBpFZV2Hanckoo/igczMr
         fhMARUA4p6PpmUdcNASBGavMn9Am7PFvu2aYPAtdagVEtpqH+2QaRt0+zsOGSaXcmmYY
         HnU9JNTfwjgDsdqVB0rCzlYJhnf9t+v3hjmA9SHiCwOZ3j3mvus60SG81tfZcSY6gRG1
         WfQQ==
X-Gm-Message-State: APjAAAUKL2KjeZAOvU0DKzyxuv3+E2yjTKPg9hxOJhk4jFthHc68upZu
        A8mKDdDUgGMNS+43E+MuFzPmICaRsS7N1ga1Zso=
X-Google-Smtp-Source: APXvYqzB8FPCxxhFMtYROSLiXOS8LzVCr42k5Ct4vYB7gy/LMtjd3tai5nwqnCwJDZhNgvvxW/t706+gBS6hE1UvJwM=
X-Received: by 2002:a5e:8219:: with SMTP id l25mr4935422iom.292.1571139053146;
 Tue, 15 Oct 2019 04:30:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a92:a04a:0:0:0:0:0 with HTTP; Tue, 15 Oct 2019 04:30:51
 -0700 (PDT)
In-Reply-To: <CAE+NS37bQyWknxy+bXYZqyHH_3RbhTQJc5fVd=ibjV6QMz_rew@mail.gmail.com>
References: <1569338741-2784-1-git-send-email-gene.chen.richtek@gmail.com>
 <20191004133324.GE18429@dell> <CAE+NS37bQyWknxy+bXYZqyHH_3RbhTQJc5fVd=ibjV6QMz_rew@mail.gmail.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 15 Oct 2019 19:30:51 +0800
Message-ID: <CAE+NS37TEcfxOy97WL0kQ2u8zM9sbROaEr-1b81hX2eoqh-sfg@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: mt6360: add pmic mt6360 driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

we find OF_MFD_CELL is not defined in mfd/core.h, which is ready to
merge to next kernel version
https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next-hi=
story/+/master/Next/merge.log

may i ask how can i upstream without this definition?
e.g. we pull this patch and build pass, new patch without add macro define

2019-10-08 2:24 GMT+08:00, Gene Chen <gene.chen.richtek@gmail.com>:
> Hi Jones,
>
> Thanks for review, we will fix some comment which your suggestion in next
> patch
>
> Lee Jones <lee.jones@linaro.org> =E6=96=BC 2019=E5=B9=B410=E6=9C=884=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:33=E5=AF=AB=E9=81=93=EF=BC=9A
>>
>> Wolfram,
>>
>> Would you be kind enough to grep for your name below?
>>
>> On Tue, 24 Sep 2019, Gene Chen wrote:
>>
>> > From: Gene Chen <gene_chen@richtek.com>
>> >
>> > Add mfd driver for mt6360 pmic chip include
>> > Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
>> >
>> > Signed-off-by: Gene Chen <gene_chen@richtek.com
>> > ---
>> >  drivers/mfd/Kconfig                |  12 +
>> >  drivers/mfd/Makefile               |   1 +
>> >  drivers/mfd/mt6360-core.c          | 463
>> > +++++++++++++++++++++++++++++++++++++
>> >  include/linux/mfd/mt6360-private.h | 279 ++++++++++++++++++++++
>> >  include/linux/mfd/mt6360.h         |  33 +++
>> >  5 files changed, 788 insertions(+)
>> >  create mode 100644 drivers/mfd/mt6360-core.c
>> >  create mode 100644 include/linux/mfd/mt6360-private.h
>> >  create mode 100644 include/linux/mfd/mt6360.h
>> >
>> > changelogs between v1 & v2
>> > - include missing header file
>> >
>> > changelogs between v2 & v3
>> > - add changelogs
>> >
>> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> > index f129f96..a422c76 100644
>> > --- a/drivers/mfd/Kconfig
>> > +++ b/drivers/mfd/Kconfig
>> > @@ -862,6 +862,18 @@ config MFD_MAX8998
>> >         additional drivers must be enabled in order to use the
>> > functionality
>> >         of the device.
>> >
>> > +config MFD_MT6360
>> > +     tristate "Mediatek MT6360 SubPMIC"
>> > +     select MFD_CORE
>> > +     select REGMAP_I2C
>> > +     select REGMAP_IRQ
>> > +     depends on I2C
>> > +     help
>> > +       Say Y here to enable MT6360 PMU/PMIC/LDO functional support.
>> > +       PMU part include charger, flashlight, rgb led
>> > +       PMIC part include 2-channel BUCKs and 2-channel LDOs
>> > +       LDO part include 4-channel LDOs
>>
>>           PMU part includes Charger, Flashlight, RGB and LED
>>           PMIC part includes 2-channel BUCKs and 2-channel LDOs
>>           LDO part includes 4-channel LDOs
>>
>
> ACK. RGB LED is one of indicator light, only single feature
>
>> >  config MFD_MT6397
>> >       tristate "MediaTek MT6397 PMIC Support"
>> >       select MFD_CORE
>> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> > index f026ada..77a8f0b 100644
>> > --- a/drivers/mfd/Makefile
>> > +++ b/drivers/mfd/Makefile
>> > @@ -241,6 +241,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC)      +=3D
>> > intel-soc-pmic.o
>> >  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)   +=3D intel_soc_pmic_bxtwc.o
>> >  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)   +=3D intel_soc_pmic_chtwc.o
>> >  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)        +=3D
>> > intel_soc_pmic_chtdc_ti.o
>> > +obj-$(CONFIG_MFD_MT6360)     +=3D mt6360-core.o
>> >  obj-$(CONFIG_MFD_MT6397)     +=3D mt6397-core.o
>> >
>> >  obj-$(CONFIG_MFD_ALTERA_A10SR)       +=3D altera-a10sr.o
>> > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
>> > new file mode 100644
>> > index 0000000..d3580618
>> > --- /dev/null
>> > +++ b/drivers/mfd/mt6360-core.c
>> > @@ -0,0 +1,463 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +/*
>> > + * Copyright (c) 2019 MediaTek Inc.
>> > + */
>> > +
>> > +#include <linux/i2c.h>
>> > +#include <linux/init.h>
>> > +#include <linux/kernel.h>
>> > +#include <linux/mfd/core.h>
>> > +#include <linux/module.h>
>> > +#include <linux/of_irq.h>
>> > +#include <linux/of_platform.h>
>> > +#include <linux/version.h>
>> > +
>> > +#include <linux/mfd/mt6360.h>
>> > +#include <linux/mfd/mt6360-private.h>
>> > +
>> > +/* reg 0 -> 0 ~ 7 */
>> > +#define MT6360_CHG_TREG_EVT          (4)
>> > +#define MT6360_CHG_AICR_EVT          (5)
>> > +#define MT6360_CHG_MIVR_EVT          (6)
>> > +#define MT6360_PWR_RDY_EVT           (7)
>> > +/* REG 1 -> 8 ~ 15 */
>> > +#define MT6360_CHG_BATSYSUV_EVT              (9)
>> > +#define MT6360_FLED_CHG_VINOVP_EVT   (11)
>> > +#define MT6360_CHG_VSYSUV_EVT                (12)
>> > +#define MT6360_CHG_VSYSOV_EVT                (13)
>> > +#define MT6360_CHG_VBATOV_EVT                (14)
>> > +#define MT6360_CHG_VBUSOV_EVT                (15)
>> > +/* REG 2 -> 16 ~ 23 */
>> > +/* REG 3 -> 24 ~ 31 */
>> > +#define MT6360_WD_PMU_DET            (25)
>> > +#define MT6360_WD_PMU_DONE           (26)
>> > +#define MT6360_CHG_TMRI                      (27)
>> > +#define MT6360_CHG_ADPBADI           (29)
>> > +#define MT6360_CHG_RVPI                      (30)
>> > +#define MT6360_OTPI                  (31)
>> > +/* REG 4 -> 32 ~ 39 */
>> > +#define MT6360_CHG_AICCMEASL         (32)
>> > +#define MT6360_CHGDET_DONEI          (34)
>> > +#define MT6360_WDTMRI                        (35)
>> > +#define MT6360_SSFINISHI             (36)
>> > +#define MT6360_CHG_RECHGI            (37)
>> > +#define MT6360_CHG_TERMI             (38)
>> > +#define MT6360_CHG_IEOCI             (39)
>> > +/* REG 5 -> 40 ~ 47 */
>> > +#define MT6360_PUMPX_DONEI           (40)
>> > +#define MT6360_BAT_OVP_ADC_EVT               (41)
>> > +#define MT6360_TYPEC_OTP_EVT         (42)
>> > +#define MT6360_ADC_WAKEUP_EVT                (43)
>> > +#define MT6360_ADC_DONEI             (44)
>> > +#define MT6360_BST_BATUVI            (45)
>> > +#define MT6360_BST_VBUSOVI           (46)
>> > +#define MT6360_BST_OLPI                      (47)
>> > +/* REG 6 -> 48 ~ 55 */
>> > +#define MT6360_ATTACH_I                      (48)
>> > +#define MT6360_DETACH_I                      (49)
>> > +#define MT6360_QC30_STPDONE          (51)
>> > +#define MT6360_QC_VBUSDET_DONE               (52)
>> > +#define MT6360_HVDCP_DET             (53)
>> > +#define MT6360_CHGDETI                       (54)
>> > +#define MT6360_DCDTI                 (55)
>> > +/* REG 7 -> 56 ~ 63 */
>> > +#define MT6360_FOD_DONE_EVT          (56)
>> > +#define MT6360_FOD_OV_EVT            (57)
>> > +#define MT6360_CHRDET_UVP_EVT                (58)
>> > +#define MT6360_CHRDET_OVP_EVT                (59)
>> > +#define MT6360_CHRDET_EXT_EVT                (60)
>> > +#define MT6360_FOD_LR_EVT            (61)
>> > +#define MT6360_FOD_HR_EVT            (62)
>> > +#define MT6360_FOD_DISCHG_FAIL_EVT   (63)
>> > +/* REG 8 -> 64 ~ 71 */
>> > +#define MT6360_USBID_EVT             (64)
>> > +#define MT6360_APWDTRST_EVT          (65)
>> > +#define MT6360_EN_EVT                        (66)
>> > +#define MT6360_QONB_RST_EVT          (67)
>> > +#define MT6360_MRSTB_EVT             (68)
>> > +#define MT6360_OTP_EVT                       (69)
>> > +#define MT6360_VDDAOV_EVT            (70)
>> > +#define MT6360_SYSUV_EVT             (71)
>> > +/* REG 9 -> 72 ~ 79 */
>> > +#define MT6360_FLED_STRBPIN_EVT              (72)
>> > +#define MT6360_FLED_TORPIN_EVT               (73)
>> > +#define MT6360_FLED_TX_EVT           (74)
>> > +#define MT6360_FLED_LVF_EVT          (75)
>> > +#define MT6360_FLED2_SHORT_EVT               (78)
>> > +#define MT6360_FLED1_SHORT_EVT               (79)
>> > +/* REG 10 -> 80 ~ 87 */
>> > +#define MT6360_FLED2_STRB_EVT                (80)
>> > +#define MT6360_FLED1_STRB_EVT                (81)
>> > +#define MT6360_FLED2_STRB_TO_EVT     (82)
>> > +#define MT6360_FLED1_STRB_TO_EVT     (83)
>> > +#define MT6360_FLED2_TOR_EVT         (84)
>> > +#define MT6360_FLED1_TOR_EVT         (85)
>> > +/* REG 11 -> 88 ~ 95 */
>> > +/* REG 12 -> 96 ~ 103 */
>> > +#define MT6360_BUCK1_PGB_EVT         (96)
>> > +#define MT6360_BUCK1_OC_EVT          (100)
>> > +#define MT6360_BUCK1_OV_EVT          (101)
>> > +#define MT6360_BUCK1_UV_EVT          (102)
>> > +/* REG 13 -> 104 ~ 111 */
>> > +#define MT6360_BUCK2_PGB_EVT         (104)
>> > +#define MT6360_BUCK2_OC_EVT          (108)
>> > +#define MT6360_BUCK2_OV_EVT          (109)
>> > +#define MT6360_BUCK2_UV_EVT          (110)
>> > +/* REG 14 -> 112 ~ 119 */
>> > +#define MT6360_LDO1_OC_EVT           (113)
>> > +#define MT6360_LDO2_OC_EVT           (114)
>> > +#define MT6360_LDO3_OC_EVT           (115)
>> > +#define MT6360_LDO5_OC_EVT           (117)
>> > +#define MT6360_LDO6_OC_EVT           (118)
>> > +#define MT6360_LDO7_OC_EVT           (119)
>> > +/* REG 15 -> 120 ~ 127 */
>> > +#define MT6360_LDO1_PGB_EVT          (121)
>> > +#define MT6360_LDO2_PGB_EVT          (122)
>> > +#define MT6360_LDO3_PGB_EVT          (123)
>> > +#define MT6360_LDO5_PGB_EVT          (125)
>> > +#define MT6360_LDO6_PGB_EVT          (126)
>> > +#define MT6360_LDO7_PGB_EVT          (127)
>> > +
>> > +#define MT6360_REGMAP_IRQ_REG(_irq_evt)              \
>> > +     REGMAP_IRQ_REG(_irq_evt, (_irq_evt) / 8, BIT((_irq_evt) % 8))
>> > +
>> > +#define MT6360_MFD_CELL(_name)                                       =
\
>> > +     {                                                       \
>> > +             .name =3D #_name,                                 \
>> > +             .of_compatible =3D "mediatek," #_name,            \
>> > +             .num_resources =3D ARRAY_SIZE(_name##_resources), \
>> > +             .resources =3D _name##_resources,                 \
>> > +     }
>>
>> Please do not roll your own MACROS like this.  If they are helpful for
>> you, they are likely to be helpful for others.  However, this is your
>> lucky day, as we've been here before.  Please rebase onto the MFD tree
>> where you will find some pre-authored macros which aren't too
>> dissimilar to this one.  Please use one of those instead.
>>
>
> ACK
>
>> > +static const struct regmap_irq mt6360_pmu_irqs[] =3D  {
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_TREG_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_AICR_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_MIVR_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_PWR_RDY_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_BATSYSUV_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED_CHG_VINOVP_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_VSYSUV_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_VSYSOV_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_VBATOV_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_VBUSOV_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_WD_PMU_DET),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_WD_PMU_DONE),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_TMRI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_ADPBADI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_RVPI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_OTPI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_AICCMEASL),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHGDET_DONEI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_WDTMRI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_SSFINISHI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_RECHGI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_TERMI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_IEOCI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_PUMPX_DONEI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHG_TREG_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_BAT_OVP_ADC_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_TYPEC_OTP_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_ADC_WAKEUP_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_ADC_DONEI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_BST_BATUVI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_BST_VBUSOVI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_BST_OLPI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_ATTACH_I),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_DETACH_I),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_QC30_STPDONE),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_QC_VBUSDET_DONE),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_HVDCP_DET),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHGDETI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_DCDTI),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FOD_DONE_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FOD_OV_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHRDET_UVP_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHRDET_OVP_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_CHRDET_EXT_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FOD_LR_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FOD_HR_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FOD_DISCHG_FAIL_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_USBID_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_APWDTRST_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_EN_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_QONB_RST_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_MRSTB_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_OTP_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_VDDAOV_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_SYSUV_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED_STRBPIN_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED_TORPIN_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED_TX_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED_LVF_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED2_SHORT_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED1_SHORT_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED2_STRB_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED1_STRB_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED2_STRB_TO_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED1_STRB_TO_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED2_TOR_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_FLED1_TOR_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK1_PGB_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK1_OC_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK1_OV_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK1_UV_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK2_PGB_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK2_OC_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK2_OV_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_BUCK2_UV_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO1_OC_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO2_OC_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO3_OC_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO5_OC_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO6_OC_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO7_OC_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO1_PGB_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO2_PGB_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO3_PGB_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO5_PGB_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO6_PGB_EVT),
>> > +     MT6360_REGMAP_IRQ_REG(MT6360_LDO7_PGB_EVT),
>> > +};
>> > +
>> > +static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
>> > +{
>> > +     struct mt6360_pmu_info *mpi =3D irq_drv_data;
>> > +
>> > +     return regmap_update_bits(mpi->regmap,
>> > +             MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG,
>> > MT6360_IRQ_RETRIG);
>> > +}
>> > +
>> > +static const struct regmap_irq_chip mt6360_pmu_irq_chip =3D {
>> > +     .irqs =3D mt6360_pmu_irqs,
>> > +     .num_irqs =3D ARRAY_SIZE(mt6360_pmu_irqs),
>> > +     .num_regs =3D MT6360_PMU_IRQ_REGNUM,
>> > +     .mask_base =3D MT6360_PMU_CHG_MASK1,
>> > +     .status_base =3D MT6360_PMU_CHG_IRQ1,
>> > +     .ack_base =3D MT6360_PMU_CHG_IRQ1,
>> > +     .init_ack_masked =3D true,
>> > +     .use_ack =3D true,
>> > +     .handle_post_irq =3D mt6360_pmu_handle_post_irq,
>> > +};
>> > +
>> > +static const struct regmap_config mt6360_pmu_regmap_config =3D {
>> > +     .reg_bits =3D 8,
>> > +     .val_bits =3D 8,
>> > +     .max_register =3D MT6360_PMU_MAXREG,
>> > +};
>> > +
>> > +static const struct resource mt6360_adc_resources[] =3D {
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_ADC_DONEI, "adc_donei"),
>> > +};
>> > +
>> > +static const struct resource mt6360_chg_resources[] =3D {
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_TREG_EVT, "chg_treg_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_PWR_RDY_EVT, "pwr_rdy_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_BATSYSUV_EVT,
>> > "chg_batsysuv_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_VSYSUV_EVT, "chg_vsysuv_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_VSYSOV_EVT, "chg_vsysov_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_VBATOV_EVT, "chg_vbatov_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_VBUSOV_EVT, "chg_vbusov_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_AICCMEASL, "chg_aiccmeasl"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_WDTMRI, "wdtmri"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_RECHGI, "chg_rechgi"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_TERMI, "chg_termi"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHG_IEOCI, "chg_ieoci"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_PUMPX_DONEI, "pumpx_donei"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_ATTACH_I, "attach_i"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_CHRDET_EXT_EVT, "chrdet_ext_evt"),
>> > +};
>> > +
>> > +static const struct resource mt6360_led_resources[] =3D {
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_FLED_CHG_VINOVP_EVT,
>> > "fled_chg_vinovp_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_FLED_LVF_EVT, "fled_lvf_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_FLED2_SHORT_EVT, "fled2_short_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_FLED1_SHORT_EVT, "fled1_short_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_FLED2_STRB_TO_EVT,
>> > "fled2_strb_to_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT,
>> > "fled1_strb_to_evt"),
>> > +};
>> > +
>> > +static const struct resource mt6360_pmic_resources[] =3D {
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_UV_EVT, "buck1_uv_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK2_PGB_EVT, "buck2_pgb_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK2_OC_EVT, "buck2_oc_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK2_OV_EVT, "buck2_ov_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_BUCK2_UV_EVT, "buck2_uv_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO6_OC_EVT, "ldo6_oc_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
>> > +};
>> > +
>> > +static const struct resource mt6360_ldo_resources[] =3D {
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO5_OC_EVT, "ldo5_oc_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO1_PGB_EVT, "ldo1_pgb_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO2_PGB_EVT, "ldo2_pgb_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO3_PGB_EVT, "ldo3_pgb_evt"),
>> > +     DEFINE_RES_IRQ_NAMED(MT6360_LDO5_PGB_EVT, "ldo5_pgb_evt"),
>> > +};
>> > +
>> > +static const struct mfd_cell mt6360_devs[] =3D {
>> > +     MT6360_MFD_CELL(mt6360_adc),
>> > +     MT6360_MFD_CELL(mt6360_chg),
>> > +     MT6360_MFD_CELL(mt6360_led),
>> > +     MT6360_MFD_CELL(mt6360_pmic),
>> > +     MT6360_MFD_CELL(mt6360_ldo),
>> > +     /* tcpc dev */
>> > +     {
>> > +             .name =3D "mt6360_tcpc",
>> > +             .of_compatible =3D "mediatek,mt6360_tcpc",
>>
>> There is a macro for this too (OF_MFD_CELL())
>>
>
> ACK
>
>> > +     },
>> > +};
>> > +
>> > +static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] =3D {
>> > +     MT6360_PMU_SLAVEID,
>> > +     MT6360_PMIC_SLAVEID,
>> > +     MT6360_LDO_SLAVEID,
>> > +     MT6360_TCPC_SLAVEID,
>> > +};
>> > +
>> > +static int mt6360_pmu_probe(struct i2c_client *client,
>> > +                         const struct i2c_device_id *id)
>>
>> If you use .probe_new (see below) you can omit the 'id' param.
>>
>
> ACK
>
>> > +{
>> > +     struct mt6360_pmu_info *mpi;
>>
>> We normally call this ddata.
>>
>
> ACK
>
>> > +     unsigned int reg_data =3D 0;
>> > +     int i, ret;
>> > +
>> > +     mpi =3D devm_kzalloc(&client->dev, sizeof(*mpi), GFP_KERNEL);
>> > +     if (!mpi)
>> > +             return -ENOMEM;
>>
>> '\n' here.
>>
>
> ACK
>
>> > +     mpi->dev =3D &client->dev;
>> > +     i2c_set_clientdata(client, mpi);
>> > +
>> > +     /* regmap regiser */
>>
>> This comment is spelt incorrectly and doesn't really add anything.
>>
>
> ACK
>
>> > +     mpi->regmap =3D devm_regmap_init_i2c(client,
>> > &mt6360_pmu_regmap_config);
>> > +     if (IS_ERR(mpi->regmap)) {
>> > +             dev_err(&client->dev, "regmap register fail\n");
>>
>> "Failed to register regmap"
>>
>
> ACK
>
>> > +             return PTR_ERR(mpi->regmap);
>> > +     }
>>
>> '\n' here.
>>
>
> ACK
>
>> > +     /* chip id check */
>>
>> Again, the code is pretty obvious.
>>
>
> ACK
>
>> > +     ret =3D regmap_read(mpi->regmap, MT6360_PMU_DEV_INFO, &reg_data)=
;
>> > +     if (ret < 0) {
>> > +             dev_err(&client->dev, "device not found\n");
>>
>> "Device not found"
>>
>
> ACK
>
>> > +             return ret;
>> > +     }
>>
>> '\n' here.
>>
>
> ACK
>
>> > +     if ((reg_data & CHIP_VEN_MASK) !=3D CHIP_VEN_MT6360) {
>> > +             dev_err(&client->dev, "not mt6360 chip\n");
>>
>> "Device not supported"
>>
>
> ACK
>
>> > +             return -ENODEV;
>> > +     }
>>
>> '\n' here.
>>
>
> ACK
>
>> > +     mpi->chip_rev =3D reg_data & CHIP_REV_MASK;
>>
>> Do this above the check, then do
>>
>>   (mpi->chip_rev !=3D CHIP_VEN_MT6360)
>>
>> ... above.
>>
>
> ACK
>
>> > +     /* irq register */
>>
>> Please remove all of these comments.
>>
>
> ACK
>
>> > +     memcpy(&mpi->irq_chip, &mt6360_pmu_irq_chip,
>> > sizeof(mpi->irq_chip));
>>
>> Why do we need to make a copy of it?
>>
>
> consider of using mutiple mt6360 chips, we can seperate diff i2c
> irq_chip.name by device_name originally
> but we can't find silimar case by overview other mfd driver
> we will delete this
>
>> > +     mpi->irq_chip.name =3D dev_name(&client->dev);
>>
>> We already know the name.  Why do we need to do this dynamically?
>>
>
> same as above
>
>> > +     mpi->irq_chip.irq_drv_data =3D mpi;
>>
>> We already saved ddata.  Why do we need to save it here as well?
>>
>
> we implement ops ".handle_post_irq" for irq retrigger when irq stuck keep
> low
>
>> > +     ret =3D devm_regmap_add_irq_chip(&client->dev, mpi->regmap,
>> > client->irq,
>> > +                                    IRQF_TRIGGER_FALLING, 0,
>> > &mpi->irq_chip,
>> > +                                    &mpi->irq_data);
>> > +     if (ret < 0) {
>>
>> Is (ret > 0) valid?
>>
>
> we consider mt6360 driver need add irq_chip for full functionality
>
>> > +             dev_err(&client->dev, "regmap irq chip add fail\n");
>>
>> "Failed to add Regmap IRQ Chip"
>>
>
> ACK
>
>> > +             return ret;
>> > +     }
>>
>> '\n' here.
>>
>
> ACK
>
>> > +     /* new i2c slave device */
>> > +     for (i =3D 0; i < MT6360_SLAVE_MAX; i++) {
>> > +             if (mt6360_slave_addr[i] =3D=3D client->addr) {
>> > +                     mpi->i2c[i] =3D client;
>> > +                     continue;
>> > +             }
>> > +             mpi->i2c[i] =3D i2c_new_dummy(client->adapter,
>> > +                                         mt6360_slave_addr[i]);
>> > +             if (!mpi->i2c[i]) {
>> > +                     dev_err(&client->dev, "new i2c dev [%d] fail\n",
>> > i);
>> > +                     ret =3D -ENODEV;
>> > +                     goto out;
>> > +             }
>> > +             i2c_set_clientdata(mpi->i2c[i], mpi);
>> > +     }
>>
>> This doesn't look right to me.
>>
>> Wolfram, would you be kind enough to take a look?
>>
>> '\n' here.
>>
>
> ACK
>
>> > +     /* mfd cell register */
>> > +     ret =3D devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
>> > +                                mt6360_devs, ARRAY_SIZE(mt6360_devs),
>> > NULL,
>> > +                                0,
>> > regmap_irq_get_domain(mpi->irq_data));
>> > +     if (ret < 0) {
>> > +             dev_err(&client->dev, "mfd add cells fail\n");
>> > +             goto out;
>> > +     }
>>
>> '\n' here.
>>
>
> ACK
>
>> > +     dev_info(&client->dev, "Successfully probed\n");
>>
>> Please remove this line.  It doesn't provide anything.
>>
>
> ACK
>
>> > +     return 0;
>> > +out:
>> > +     while (--i >=3D 0) {
>> > +             if (mpi->i2c[i]->addr =3D=3D client->addr)
>> > +                     continue;
>> > +             i2c_unregister_device(mpi->i2c[i]);
>> > +     }
>>
>> '\n' here.
>>
>
> ACK
>
>> > +     return ret;
>> > +}
>> > +
>> > +static int mt6360_pmu_remove(struct i2c_client *client)
>> > +{
>> > +     struct mt6360_pmu_info *mpi =3D i2c_get_clientdata(client);
>> > +     int i;
>> > +
>> > +     for (i =3D 0; i < MT6360_SLAVE_MAX; i++) {
>> > +             if (mpi->i2c[i]->addr =3D=3D client->addr)
>> > +                     continue;
>> > +             i2c_unregister_device(mpi->i2c[i]);
>> > +     }
>>
>> '\n' here.
>>
>
> ACK
>
>> > +     return 0;
>> > +}
>> > +
>> > +static int __maybe_unused mt6360_pmu_suspend(struct device *dev)
>> > +{
>> > +     struct i2c_client *i2c =3D to_i2c_client(dev);
>> > +
>> > +     if (device_may_wakeup(dev))
>> > +             enable_irq_wake(i2c->irq);
>>
>> '\n' here.
>>
>
> ACK
>
>> > +     return 0;
>> > +}
>> > +
>> > +static int __maybe_unused mt6360_pmu_resume(struct device *dev)
>> > +{
>> > +
>> > +     struct i2c_client *i2c =3D to_i2c_client(dev);
>> > +
>> > +     if (device_may_wakeup(dev))
>> > +             disable_irq_wake(i2c->irq);
>>
>> '\n' here.
>>
>
> ACK
>
>> > +     return 0;
>> > +}
>> > +
>> > +static SIMPLE_DEV_PM_OPS(mt6360_pmu_pm_ops,
>> > +                      mt6360_pmu_suspend, mt6360_pmu_resume);
>> > +
>> > +static const struct of_device_id __maybe_unused mt6360_pmu_of_id[] =
=3D {
>> > +     { .compatible =3D "mediatek,mt6360_pmu", },
>> > +     {},
>> > +};
>> > +MODULE_DEVICE_TABLE(of, mt6360_pmu_of_id);
>> > +
>> > +static const struct i2c_device_id mt6360_pmu_id[] =3D {
>> > +     { "mt6360_pmu", 0 },
>> > +     {},
>> > +};
>> > +MODULE_DEVICE_TABLE(i2c, mt6360_pmu_id);
>>
>> If you use .probe_new (see below, you can remove this table.
>>
>
> ACK
>
>> > +static struct i2c_driver mt6360_pmu_driver =3D {
>> > +     .driver =3D {
>> > +             .name =3D "mt6360_pmu",
>> > +             .owner =3D THIS_MODULE,
>>
>> This is no longer required.
>>
>
> ACK
>
>> > +             .pm =3D &mt6360_pmu_pm_ops,
>> > +             .of_match_table =3D of_match_ptr(mt6360_pmu_of_id),
>> > +     },
>> > +     .probe =3D mt6360_pmu_probe,
>>
>> Use .probe_new here.
>>
>
> ACK
>
>> > +     .remove =3D mt6360_pmu_remove,
>> > +     .id_table =3D mt6360_pmu_id,
>> > +};
>> > +module_i2c_driver(mt6360_pmu_driver);
>> > +
>> > +MODULE_AUTHOR("CY_Huang <cy_huang@richtek.com>");
>> > +MODULE_DESCRIPTION("MT6360 PMU I2C Driver");
>> > +MODULE_LICENSE("GPL");
>> > +MODULE_VERSION("1.0.0");
>> > diff --git a/include/linux/mfd/mt6360-private.h
>> > b/include/linux/mfd/mt6360-private.h
>> > new file mode 100644
>> > index 0000000..b07b3d9
>> > --- /dev/null
>> > +++ b/include/linux/mfd/mt6360-private.h
>>
>> Why do you need 2 header files?
>>
>
> According to our architecture as attachment,
> mt6360 have 4 i2c slave address for different parts
> so we set whole register table in mt6360-private.h, it will be
> included by other modules
> we will delete it next patch
> and we will add until we use it
>
>> > @@ -0,0 +1,279 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> > +/*
>> > + * Copyright (c) 2019 MediaTek Inc.
>> > + */
>> > +
>> > +#ifndef __MT6360_PRIVATE_H__
>> > +#define __MT6360_PRIVATE_H__
>>
>> __MFD_MT6360_H__
>>
>> > +#include <linux/interrupt.h>
>> > +
>> > +/* PMU register defininition */
>> > +#define MT6360_PMU_DEV_INFO                  (0x00)
>> > +#define MT6360_PMU_CORE_CTRL1                        (0x01)
>> > +#define MT6360_PMU_RST1                              (0x02)
>> > +#define MT6360_PMU_CRCEN                     (0x03)
>> > +#define MT6360_PMU_RST_PAS_CODE1             (0x04)
>> > +#define MT6360_PMU_RST_PAS_CODE2             (0x05)
>> > +#define MT6360_PMU_CORE_CTRL2                        (0x06)
>> > +#define MT6360_PMU_TM_PAS_CODE1                      (0x07)
>> > +#define MT6360_PMU_TM_PAS_CODE2                      (0x08)
>> > +#define MT6360_PMU_TM_PAS_CODE3                      (0x09)
>> > +#define MT6360_PMU_TM_PAS_CODE4                      (0x0A)
>> > +#define MT6360_PMU_IRQ_IND                   (0x0B)
>> > +#define MT6360_PMU_IRQ_MASK                  (0x0C)
>> > +#define MT6360_PMU_IRQ_SET                   (0x0D)
>> > +#define MT6360_PMU_SHDN_CTRL                 (0x0E)
>> > +#define MT6360_PMU_TM_INF                    (0x0F)
>> > +#define MT6360_PMU_I2C_CTRL                  (0x10)
>> > +#define MT6360_PMU_CHG_CTRL1                 (0x11)
>> > +#define MT6360_PMU_CHG_CTRL2                 (0x12)
>> > +#define MT6360_PMU_CHG_CTRL3                 (0x13)
>> > +#define MT6360_PMU_CHG_CTRL4                 (0x14)
>> > +#define MT6360_PMU_CHG_CTRL5                 (0x15)
>> > +#define MT6360_PMU_CHG_CTRL6                 (0x16)
>> > +#define MT6360_PMU_CHG_CTRL7                 (0x17)
>> > +#define MT6360_PMU_CHG_CTRL8                 (0x18)
>> > +#define MT6360_PMU_CHG_CTRL9                 (0x19)
>> > +#define MT6360_PMU_CHG_CTRL10                        (0x1A)
>> > +#define MT6360_PMU_CHG_CTRL11                        (0x1B)
>> > +#define MT6360_PMU_CHG_CTRL12                        (0x1C)
>> > +#define MT6360_PMU_CHG_CTRL13                        (0x1D)
>> > +#define MT6360_PMU_CHG_CTRL14                        (0x1E)
>> > +#define MT6360_PMU_CHG_CTRL15                        (0x1F)
>> > +#define MT6360_PMU_CHG_CTRL16                        (0x20)
>> > +#define MT6360_PMU_CHG_AICC_RESULT           (0x21)
>> > +#define MT6360_PMU_DEVICE_TYPE                       (0x22)
>> > +#define MT6360_PMU_QC_CONTROL1                       (0x23)
>> > +#define MT6360_PMU_QC_CONTROL2                       (0x24)
>> > +#define MT6360_PMU_QC30_CONTROL1             (0x25)
>> > +#define MT6360_PMU_QC30_CONTROL2             (0x26)
>> > +#define MT6360_PMU_USB_STATUS1                       (0x27)
>> > +#define MT6360_PMU_QC_STATUS1                        (0x28)
>> > +#define MT6360_PMU_QC_STATUS2                        (0x29)
>> > +#define MT6360_PMU_CHG_PUMP                  (0x2A)
>> > +#define MT6360_PMU_CHG_CTRL17                        (0x2B)
>> > +#define MT6360_PMU_CHG_CTRL18                        (0x2C)
>> > +#define MT6360_PMU_CHRDET_CTRL1                      (0x2D)
>> > +#define MT6360_PMU_CHRDET_CTRL2                      (0x2E)
>> > +#define MT6360_PMU_DPDN_CTRL                 (0x2F)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL1          (0x30)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL2          (0x31)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL3          (0x32)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL4          (0x33)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL5          (0x34)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL6          (0x35)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL7          (0x36)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL8          (0x37)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL9          (0x38)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL10         (0x39)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL11         (0x3A)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL12         (0x3B)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL13         (0x3C)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL14         (0x3D)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL15         (0x3E)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL16         (0x3F)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL17         (0x40)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL18         (0x41)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL19         (0x42)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL20         (0x43)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL21         (0x44)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL22         (0x45)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL23         (0x46)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL24         (0x47)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL25         (0x48)
>> > +#define MT6360_PMU_BC12_CTRL                 (0x49)
>> > +#define MT6360_PMU_CHG_STAT                  (0x4A)
>> > +#define MT6360_PMU_RESV1                     (0x4B)
>> > +#define MT6360_PMU_TYPEC_OTP_TH_SEL_CODEH    (0x4E)
>> > +#define MT6360_PMU_TYPEC_OTP_TH_SEL_CODEL    (0x4F)
>> > +#define MT6360_PMU_TYPEC_OTP_HYST_TH         (0x50)
>> > +#define MT6360_PMU_TYPEC_OTP_CTRL            (0x51)
>> > +#define MT6360_PMU_ADC_BAT_DATA_H            (0x52)
>> > +#define MT6360_PMU_ADC_BAT_DATA_L            (0x53)
>> > +#define MT6360_PMU_IMID_BACKBST_ON           (0x54)
>> > +#define MT6360_PMU_IMID_BACKBST_OFF          (0x55)
>> > +#define MT6360_PMU_ADC_CONFIG                        (0x56)
>> > +#define MT6360_PMU_ADC_EN2                   (0x57)
>> > +#define MT6360_PMU_ADC_IDLE_T                        (0x58)
>> > +#define MT6360_PMU_ADC_RPT_1                 (0x5A)
>> > +#define MT6360_PMU_ADC_RPT_2                 (0x5B)
>> > +#define MT6360_PMU_ADC_RPT_3                 (0x5C)
>> > +#define MT6360_PMU_ADC_RPT_ORG1                      (0x5D)
>> > +#define MT6360_PMU_ADC_RPT_ORG2                      (0x5E)
>> > +#define MT6360_PMU_BAT_OVP_TH_SEL_CODEH              (0x5F)
>> > +#define MT6360_PMU_BAT_OVP_TH_SEL_CODEL              (0x60)
>> > +#define MT6360_PMU_CHG_CTRL19                        (0x61)
>> > +#define MT6360_PMU_VDDASUPPLY                        (0x62)
>> > +#define MT6360_PMU_BC12_MANUAL                       (0x63)
>> > +#define MT6360_PMU_CHGDET_FUNC                       (0x64)
>> > +#define MT6360_PMU_FOD_CTRL                  (0x65)
>> > +#define MT6360_PMU_CHG_CTRL20                        (0x66)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL26         (0x67)
>> > +#define MT6360_PMU_CHG_HIDDEN_CTRL27         (0x68)
>> > +#define MT6360_PMU_RESV2                     (0x69)
>> > +#define MT6360_PMU_USBID_CTRL1                       (0x6D)
>> > +#define MT6360_PMU_USBID_CTRL2                       (0x6E)
>> > +#define MT6360_PMU_USBID_CTRL3                       (0x6F)
>> > +#define MT6360_PMU_FLED_CFG                  (0x70)
>> > +#define MT6360_PMU_RESV3                     (0x71)
>> > +#define MT6360_PMU_FLED1_CTRL                        (0x72)
>> > +#define MT6360_PMU_FLED_STRB_CTRL            (0x73)
>> > +#define MT6360_PMU_FLED1_STRB_CTRL2          (0x74)
>> > +#define MT6360_PMU_FLED1_TOR_CTRL            (0x75)
>> > +#define MT6360_PMU_FLED2_CTRL                        (0x76)
>> > +#define MT6360_PMU_RESV4                     (0x77)
>> > +#define MT6360_PMU_FLED2_STRB_CTRL2          (0x78)
>> > +#define MT6360_PMU_FLED2_TOR_CTRL            (0x79)
>> > +#define MT6360_PMU_FLED_VMIDTRK_CTRL1                (0x7A)
>> > +#define MT6360_PMU_FLED_VMID_RTM             (0x7B)
>> > +#define MT6360_PMU_FLED_VMIDTRK_CTRL2                (0x7C)
>> > +#define MT6360_PMU_FLED_PWSEL                        (0x7D)
>> > +#define MT6360_PMU_FLED_EN                   (0x7E)
>> > +#define MT6360_PMU_FLED_Hidden1                      (0x7F)
>> > +#define MT6360_PMU_RGB_EN                    (0x80)
>> > +#define MT6360_PMU_RGB1_ISNK                 (0x81)
>> > +#define MT6360_PMU_RGB2_ISNK                 (0x82)
>> > +#define MT6360_PMU_RGB3_ISNK                 (0x83)
>> > +#define MT6360_PMU_RGB_ML_ISNK                       (0x84)
>> > +#define MT6360_PMU_RGB1_DIM                  (0x85)
>> > +#define MT6360_PMU_RGB2_DIM                  (0x86)
>> > +#define MT6360_PMU_RGB3_DIM                  (0x87)
>> > +#define MT6360_PMU_RESV5                     (0x88)
>> > +#define MT6360_PMU_RGB12_Freq                        (0x89)
>> > +#define MT6360_PMU_RGB34_Freq                        (0x8A)
>> > +#define MT6360_PMU_RGB1_Tr                   (0x8B)
>> > +#define MT6360_PMU_RGB1_Tf                   (0x8C)
>> > +#define MT6360_PMU_RGB1_TON_TOFF             (0x8D)
>> > +#define MT6360_PMU_RGB2_Tr                   (0x8E)
>> > +#define MT6360_PMU_RGB2_Tf                   (0x8F)
>> > +#define MT6360_PMU_RGB2_TON_TOFF             (0x90)
>> > +#define MT6360_PMU_RGB3_Tr                   (0x91)
>> > +#define MT6360_PMU_RGB3_Tf                   (0x92)
>> > +#define MT6360_PMU_RGB3_TON_TOFF             (0x93)
>> > +#define MT6360_PMU_RGB_Hidden_CTRL1          (0x94)
>> > +#define MT6360_PMU_RGB_Hidden_CTRL2          (0x95)
>> > +#define MT6360_PMU_RESV6                     (0x97)
>> > +#define MT6360_PMU_SPARE1                    (0x9A)
>> > +#define MT6360_PMU_SPARE2                    (0xA0)
>> > +#define MT6360_PMU_SPARE3                    (0xB0)
>> > +#define MT6360_PMU_SPARE4                    (0xC0)
>> > +#define MT6360_PMU_CHG_IRQ1                  (0xD0)
>> > +#define MT6360_PMU_CHG_IRQ2                  (0xD1)
>> > +#define MT6360_PMU_CHG_IRQ3                  (0xD2)
>> > +#define MT6360_PMU_CHG_IRQ4                  (0xD3)
>> > +#define MT6360_PMU_CHG_IRQ5                  (0xD4)
>> > +#define MT6360_PMU_CHG_IRQ6                  (0xD5)
>> > +#define MT6360_PMU_QC_IRQ                    (0xD6)
>> > +#define MT6360_PMU_FOD_IRQ                   (0xD7)
>> > +#define MT6360_PMU_BASE_IRQ                  (0xD8)
>> > +#define MT6360_PMU_FLED_IRQ1                 (0xD9)
>> > +#define MT6360_PMU_FLED_IRQ2                 (0xDA)
>> > +#define MT6360_PMU_RGB_IRQ                   (0xDB)
>> > +#define MT6360_PMU_BUCK1_IRQ                 (0xDC)
>> > +#define MT6360_PMU_BUCK2_IRQ                 (0xDD)
>> > +#define MT6360_PMU_LDO_IRQ1                  (0xDE)
>> > +#define MT6360_PMU_LDO_IRQ2                  (0xDF)
>> > +#define MT6360_PMU_CHG_STAT1                 (0xE0)
>> > +#define MT6360_PMU_CHG_STAT2                 (0xE1)
>> > +#define MT6360_PMU_CHG_STAT3                 (0xE2)
>> > +#define MT6360_PMU_CHG_STAT4                 (0xE3)
>> > +#define MT6360_PMU_CHG_STAT5                 (0xE4)
>> > +#define MT6360_PMU_CHG_STAT6                 (0xE5)
>> > +#define MT6360_PMU_QC_STAT                   (0xE6)
>> > +#define MT6360_PMU_FOD_STAT                  (0xE7)
>> > +#define MT6360_PMU_BASE_STAT                 (0xE8)
>> > +#define MT6360_PMU_FLED_STAT1                        (0xE9)
>> > +#define MT6360_PMU_FLED_STAT2                        (0xEA)
>> > +#define MT6360_PMU_RGB_STAT                  (0xEB)
>> > +#define MT6360_PMU_BUCK1_STAT                        (0xEC)
>> > +#define MT6360_PMU_BUCK2_STAT                        (0xED)
>> > +#define MT6360_PMU_LDO_STAT1                 (0xEE)
>> > +#define MT6360_PMU_LDO_STAT2                 (0xEF)
>> > +#define MT6360_PMU_CHG_MASK1                 (0xF0)
>> > +#define MT6360_PMU_CHG_MASK2                 (0xF1)
>> > +#define MT6360_PMU_CHG_MASK3                 (0xF2)
>> > +#define MT6360_PMU_CHG_MASK4                 (0xF3)
>> > +#define MT6360_PMU_CHG_MASK5                 (0xF4)
>> > +#define MT6360_PMU_CHG_MASK6                 (0xF5)
>> > +#define MT6360_PMU_QC_MASK                   (0xF6)
>> > +#define MT6360_PMU_FOD_MASK                  (0xF7)
>> > +#define MT6360_PMU_BASE_MASK                 (0xF8)
>> > +#define MT6360_PMU_FLED_MASK1                        (0xF9)
>> > +#define MT6360_PMU_FLED_MASK2                        (0xFA)
>> > +#define MT6360_PMU_FAULTB_MASK                       (0xFB)
>> > +#define MT6360_PMU_BUCK1_MASK                        (0xFC)
>> > +#define MT6360_PMU_BUCK2_MASK                        (0xFD)
>> > +#define MT6360_PMU_LDO_MASK1                 (0xFE)
>> > +#define MT6360_PMU_LDO_MASK2                 (0xFF)
>> > +#define MT6360_PMU_MAXREG                    (MT6360_PMU_LDO_MASK2)
>> > +
>> > +
>> > +/* MT6360_PMU_IRQ_SET */
>> > +#define MT6360_PMU_IRQ_REGNUM        (MT6360_PMU_LDO_IRQ2 -
>> > MT6360_PMU_CHG_IRQ1 + 1)
>> > +#define MT6360_IRQ_RETRIG    BIT(2)
>> > +
>> > +#define CHIP_VEN_MASK                                (0xF0)
>> > +#define CHIP_VEN_MT6360                              (0x50)
>> > +#define CHIP_REV_MASK                                (0x0F)
>> > +
>> > +/* IRQ definitions */
>>
>> Remove this please.
>>
>> > +struct mt6360_pmu_irq_desc {
>> > +     const char *name;
>> > +     irq_handler_t irq_handler;
>> > +};
>>
>> Where is this used?
>>
>> > +#define  MT6360_DT_VALPROP(name, type) \
>> > +                     {#name, offsetof(type, name)}
>>
>> Where is this used?
>>
>> > +struct mt6360_val_prop {
>> > +     const char *name;
>> > +     size_t offset;
>> > +};
>> > +
>> > +static inline void mt6360_dt_parser_helper(struct device_node *np, vo=
id
>> > *data,
>> > +                                        const struct mt6360_val_prop
>> > *props,
>> > +                                        int prop_cnt)
>> > +{
>> > +     int i;
>> > +
>> > +     for (i =3D 0; i < prop_cnt; i++) {
>> > +             if (unlikely(!props[i].name))
>> > +                     continue;
>> > +             of_property_read_u32(np, props[i].name, data +
>> > props[i].offset);
>> > +     }
>> > +}
>>
>> What are you using this for?  Why is the standard API not sufficient?
>>
>> > +#define MT6360_PDATA_VALPROP(name, type, reg, shift, mask, func, base=
)
>> > \
>> > +                     {offsetof(type, name), reg, shift, mask, func,
>> > base}
>>
>> Where is this used?
>>
>> > +struct mt6360_pdata_prop {
>> > +     size_t offset;
>> > +     u8 reg;
>> > +     u8 shift;
>> > +     u8 mask;
>> > +     u32 (*transform)(u32 val);
>> > +     u8 base;
>> > +};
>> > +
>> > +static inline int mt6360_pdata_apply_helper(void *context, void
>> > *pdata,
>> > +                                        const struct mt6360_pdata_pro=
p
>> > *prop,
>> > +                                        int prop_cnt)
>> > +{
>> > +     int i, ret;
>> > +     u32 val;
>> > +
>> > +     for (i =3D 0; i < prop_cnt; i++) {
>> > +             val =3D *(u32 *)(pdata + prop[i].offset);
>> > +             if (prop[i].transform)
>> > +                     val =3D prop[i].transform(val);
>> > +             val +=3D prop[i].base;
>> > +             ret =3D regmap_update_bits(context,
>> > +                          prop[i].reg, prop[i].mask, val <<
>> > prop[i].shift);
>> > +             if (ret < 0)
>> > +                     return ret;
>> > +     }
>> > +     return 0;
>> > +}
>>
>> Where is this used?  What does it do?
>>
>> > +#endif /* __MT6360_PRIVATE_H__ */
>> > diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
>> > new file mode 100644
>> > index 0000000..ba2e80a
>> > --- /dev/null
>> > +++ b/include/linux/mfd/mt6360.h
>> > @@ -0,0 +1,33 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> > +/*
>> > + * Copyright (c) 2019 MediaTek Inc.
>> > + */
>> > +
>> > +#ifndef __MT6360_H__
>> > +#define __MT6360_H__
>> > +
>> > +#include <linux/regmap.h>
>> > +
>> > +enum {
>> > +     MT6360_SLAVE_PMU =3D 0,
>> > +     MT6360_SLAVE_PMIC,
>> > +     MT6360_SLAVE_LDO,
>> > +     MT6360_SLAVE_TCPC,
>> > +     MT6360_SLAVE_MAX,
>> > +};
>> > +
>> > +#define MT6360_PMU_SLAVEID   (0x34)
>> > +#define MT6360_PMIC_SLAVEID  (0x1A)
>> > +#define MT6360_LDO_SLAVEID   (0x64)
>> > +#define MT6360_TCPC_SLAVEID  (0x4E)
>>
>> What kind of slave ID?  I2C address?
>>
>> > +struct mt6360_pmu_info {
>> > +     struct i2c_client *i2c[MT6360_SLAVE_MAX];
>> > +     struct device *dev;
>>
>> > +     struct regmap *regmap;
>> > +     struct regmap_irq_chip_data *irq_data;
>> > +     struct regmap_irq_chip irq_chip;
>> > +     unsigned int chip_rev;
>>
>> Why are you saving these?
>>
>> Where do you reuse them?
>>
>> > +};
>> > +
>> > +#endif /* __MT6360_H__ */
>>
>> --
>> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>> Linaro Services Technical Lead
>> Linaro.org =E2=94=82 Open source software for ARM SoCs
>> Follow Linaro: Facebook | Twitter | Blog
>
