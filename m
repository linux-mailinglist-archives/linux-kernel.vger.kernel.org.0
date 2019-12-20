Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE6A1274E5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 06:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfLTFKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 00:10:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37203 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLTFKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:10:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so6686052qky.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 21:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ntKHp8be8MgVI2s2eVNC29AikwQBJmgjfDyjOV2J6Js=;
        b=nxZX0SaYLy6siw1Z52AO6P4CNlGoN0ffJHzMUraIHho1PAnjU0gEVBEjkXNvFEM6pO
         hifzQSpk5jZgVhsXTX/VW0ByEzO/cp1gJ9sx2meyCukivk/DH+113v1ijYjGAmOKJZ/4
         nKaWnQzkhuW1MUQig+cFfWWz+eiVgpn0Gu+Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ntKHp8be8MgVI2s2eVNC29AikwQBJmgjfDyjOV2J6Js=;
        b=clDLRsDbq0mof88MkyZ527sxhBjur8Lf4R2l9pY+YJpx85u1ITly9KpmZ2VHKEdXW1
         JevtNcd1iDkK+Kk38lx+18tShEdSiZNiKinMkATyoeZVk4j6D2bMPjzmZPnE5dH/h+17
         Q/ngkD5Qymihwqo5p314VRyhGGSNn7fCwimF+Vf7B44qRFJC81t24OgUvQ94/loYbIYz
         0OCjLbrLYYDtz+pftfVRiIn7u66OUA/v56o+TEZyYNtiMR7LrbGBkWi3w6JC00eSGQl2
         cXtc2fAxibf1Xy1jQUECGR7RAtxDQUbupHlVeWE/2BgXHPqynjNqniLY9S2hb9U/BfF7
         mdLQ==
X-Gm-Message-State: APjAAAXLI7xn4IjeIQA32b+1K02OKHGJKO8TGeJGOUlKXdA29uLW8NSw
        +5RdJFNxQdi/sHJ+T5DrgjVpuNpdTtzZiqkHMqnt5Q==
X-Google-Smtp-Source: APXvYqxtXszs5D+1NIYItqKHVvomxV2wPLGpnwbnDvZpCUBW2GIgLh+zNpJJA+SZgpRhZ5uZoGVLqRge9+ZD1bw8olY=
X-Received: by 2002:a37:4bc6:: with SMTP id y189mr11718397qka.18.1576818610250;
 Thu, 19 Dec 2019 21:10:10 -0800 (PST)
MIME-Version: 1.0
References: <1576813564-23927-1-git-send-email-weiyi.lu@mediatek.com>
 <1576813564-23927-6-git-send-email-weiyi.lu@mediatek.com> <CANMq1KBLuugcoWb1o=rUkBR7oY5Cf5rX=DCvpVP5D_6FJ8jipw@mail.gmail.com>
 <1576818001.8410.16.camel@mtksdaap41>
In-Reply-To: <1576818001.8410.16.camel@mtksdaap41>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 20 Dec 2019 13:09:59 +0800
Message-ID: <CANMq1KBUbUHZdZz6qWOyJvdWAi+YVOPgRY0gjsPLN9YCgYMh=A@mail.gmail.com>
Subject: Re: [PATCH v11 05/10] soc: mediatek: Remove infracfg misc driver support
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 1:00 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> On Fri, 2019-12-20 at 12:11 +0800, Nicolas Boichat wrote:
> > On Fri, Dec 20, 2019 at 11:46 AM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> > >
> > > In previous patches, we introduce scpsys-ext driver that covers
> > > the functions which infracfg misc driver provided.
> > > And then replace bus_prot_mask with bp_table of all compatibles.
> > > Now, we're going to remove infracfg misc drvier which is no longer
> > > being used.
> > >
> > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > ---
> > >  drivers/soc/mediatek/Kconfig          | 10 -----
> > >  drivers/soc/mediatek/Makefile         |  3 +-
> > >  drivers/soc/mediatek/mtk-infracfg.c   | 79 -----------------------------------
> > >  include/linux/soc/mediatek/infracfg.h | 39 -----------------
> > >  4 files changed, 1 insertion(+), 130 deletions(-)
> > >  delete mode 100644 drivers/soc/mediatek/mtk-infracfg.c
> > >  delete mode 100644 include/linux/soc/mediatek/infracfg.h
> > > [snip]
> > > diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> > > deleted file mode 100644
> > > index fd25f01..0000000
> > > --- a/include/linux/soc/mediatek/infracfg.h
> > > +++ /dev/null
> > > @@ -1,39 +0,0 @@
> > > -/* SPDX-License-Identifier: GPL-2.0 */
> > > -#ifndef __SOC_MEDIATEK_INFRACFG_H
> > > -#define __SOC_MEDIATEK_INFRACFG_H
> > > -
> > > -#define MT8173_TOP_AXI_PROT_EN_MCI_M2          BIT(0)
> > > -#define MT8173_TOP_AXI_PROT_EN_MM_M0           BIT(1)
> > > -#define MT8173_TOP_AXI_PROT_EN_MM_M1           BIT(2)
> > > -#define MT8173_TOP_AXI_PROT_EN_MMAPB_S         BIT(6)
> > > -#define MT8173_TOP_AXI_PROT_EN_L2C_M2          BIT(9)
> > > -#define MT8173_TOP_AXI_PROT_EN_L2SS_SMI                BIT(11)
> > > -#define MT8173_TOP_AXI_PROT_EN_L2SS_ADD                BIT(12)
> > > -#define MT8173_TOP_AXI_PROT_EN_CCI_M2          BIT(13)
> > > -#define MT8173_TOP_AXI_PROT_EN_MFG_S           BIT(14)
> > > -#define MT8173_TOP_AXI_PROT_EN_PERI_M0         BIT(15)
> > > -#define MT8173_TOP_AXI_PROT_EN_PERI_M1         BIT(16)
> > > -#define MT8173_TOP_AXI_PROT_EN_DEBUGSYS                BIT(17)
> > > -#define MT8173_TOP_AXI_PROT_EN_CQ_DMA          BIT(18)
> > > -#define MT8173_TOP_AXI_PROT_EN_GCPU            BIT(19)
> > > -#define MT8173_TOP_AXI_PROT_EN_IOMMU           BIT(20)
> > > -#define MT8173_TOP_AXI_PROT_EN_MFG_M0          BIT(21)
> > > -#define MT8173_TOP_AXI_PROT_EN_MFG_M1          BIT(22)
> > > -#define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT   BIT(23)
> > > -
> > > -#define MT2701_TOP_AXI_PROT_EN_MM_M0           BIT(1)
> > > -#define MT2701_TOP_AXI_PROT_EN_CONN_M          BIT(2)
> > > -#define MT2701_TOP_AXI_PROT_EN_CONN_S          BIT(8)
> > > -
> > > -#define MT7622_TOP_AXI_PROT_EN_ETHSYS          (BIT(3) | BIT(17))
> > > -#define MT7622_TOP_AXI_PROT_EN_HIF0            (BIT(24) | BIT(25))
> > > -#define MT7622_TOP_AXI_PROT_EN_HIF1            (BIT(26) | BIT(27) | \
> > > -                                                BIT(28))
> > > -#define MT7622_TOP_AXI_PROT_EN_WB              (BIT(2) | BIT(6) | \
> > > -                                                BIT(7) | BIT(8))
> >
> > Err wait, don't you need these values in patch 04/10?
> >
>
> Actually I already duplicated those being used into scpsys-ext.h and
> then replace the header file in patch 04/10

Oh, missed that, SGTM then.

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -11,7 +11,7 @@
> -#include <linux/soc/mediatek/infracfg.h>
> +#include "scpsys-ext.h"
>
> so I remove the infracfg.h directly in this patch and add those new for
> MT8183 in scpsys-ext.h
>
> > > -
> > > -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> > > -               bool reg_update);
> > > -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> > > -               bool reg_update);
> > > -#endif /* __SOC_MEDIATEK_INFRACFG_H */
> > > --
> > > 1.8.1.1.dirty
>
