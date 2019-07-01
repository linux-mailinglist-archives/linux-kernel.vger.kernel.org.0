Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713E3E1FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 14:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfD2MLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 08:11:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34765 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfD2MLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:11:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id n15so2301729ota.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 05:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofP7tq1gg7jAEonEpyu80KP1hiIc7q/XbvypK5YmGvM=;
        b=Fe45meDRPvHqqreHOcs9kzoqmPv0MbzhH32LvkjxYKjfeijNDzQb5YWfVyvA6tDpNB
         RVgYApWhjqmNyQFWgb5O845vEX5+ap0y+gWk/UEay9mOWPnR0u6zHNvlO1T9fJkjiFuS
         A9Voe2gg9A9il2P+JLohr/FtfFAETMqCtJRXRPoEDGNCTkAaERKm9Z8PzX6jAjPxYKLU
         /lhZWK22AjlCEV3SsqmhoCXh1GZZmc+R23HgVdpl6liH6rl2PQQn/wnJFWMACHLWT2Ks
         Oc5uX2lUl9oD29Pq4YqDVZrCm9TeKWUrP2WLJ1PTqDrqJvJKaF+FZE3JWzvhPYivd52N
         bHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofP7tq1gg7jAEonEpyu80KP1hiIc7q/XbvypK5YmGvM=;
        b=t2FiblVY1aku6nNvnjZzDJk0L1RguMlQxVsYlfxXi1Zm24E9h3z6q+xkQaMvJUP10Q
         zjW+NX+zJrdQiCr7H5ppGsxo3Ac4Xe29k6nBHzuDJtgGz2RryRUcBHnCY08m96cvyYXN
         AKhSn62FDL+0VOECt1AnWastqxeE0+jZ41UAoNg82wU16fAXNW6slRE+xdF5E52i3+xi
         A1yuSSy3AzOctFZ1iFsdxMC+bMirjI9pLtkyMkOBpXGveCxz8SyaRcPX0XjeyuVZ4Un2
         4vwzjI2Bt0Ol180ZeldPSJtaEz44Fnv6ebUcu0LHSmuMRIAzBD57U91RbxUqCPtWvxLY
         rfQw==
X-Gm-Message-State: APjAAAWK3CuJXDuY+zafEdXOGOUaskuLZ+YWlgg88flarkQo7ZIkdTzG
        vPBPRsjFujuAUxyoSP8vmRKdHvDTImnKrBBXIqf+Mw==
X-Google-Smtp-Source: APXvYqwUqePkcaYnW+26PBNkBwHIHt4YRj0lQa0cGh5pe1KoTnwjh5MPkgz6q0G63XHqG37Io2LNOjdle6n3Ke12hfk=
X-Received: by 2002:a05:6830:b:: with SMTP id c11mr7523807otp.281.1556539899231;
 Mon, 29 Apr 2019 05:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555330115.git.baolin.wang@linaro.org> <07c070b4397296a4500d04abe16dfd8a71a2f211.1555330115.git.baolin.wang@linaro.org>
 <20190429120108.GL3845@vkoul-mobl.Dlink>
In-Reply-To: <20190429120108.GL3845@vkoul-mobl.Dlink>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 29 Apr 2019 20:11:27 +0800
Message-ID: <CAMz4kuJB2+6HziyDep4ctfmjFYpmZ-v_vrFQsJ9tHvwYzSJeKA@mail.gmail.com>
Subject: Re: [PATCH 7/7] dmaengine: sprd: Add interrupt support for 2-stage transfer
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, eric.long@unisoc.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019 at 20:01, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 15-04-19, 20:15, Baolin Wang wrote:
> > For 2-stage transfer, some users like Audio still need transaction interrupt
> > to notify when the 2-stage transfer is completed. Thus we should enable
> > 2-stage transfer interrupt to support this feature.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/dma/sprd-dma.c |   22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > index cc9c24d..4c18f44 100644
> > --- a/drivers/dma/sprd-dma.c
> > +++ b/drivers/dma/sprd-dma.c
> > @@ -62,6 +62,8 @@
> >  /* SPRD_DMA_GLB_2STAGE_GRP register definition */
> >  #define SPRD_DMA_GLB_2STAGE_EN               BIT(24)
> >  #define SPRD_DMA_GLB_CHN_INT_MASK    GENMASK(23, 20)
> > +#define SPRD_DMA_GLB_DEST_INT                BIT(22)
> > +#define SPRD_DMA_GLB_SRC_INT         BIT(20)
> >  #define SPRD_DMA_GLB_LIST_DONE_TRG   BIT(19)
> >  #define SPRD_DMA_GLB_TRANS_DONE_TRG  BIT(18)
> >  #define SPRD_DMA_GLB_BLOCK_DONE_TRG  BIT(17)
> > @@ -135,6 +137,7 @@
> >  /* define DMA channel mode & trigger mode mask */
> >  #define SPRD_DMA_CHN_MODE_MASK               GENMASK(7, 0)
> >  #define SPRD_DMA_TRG_MODE_MASK               GENMASK(7, 0)
> > +#define SPRD_DMA_INT_TYPE_MASK               GENMASK(7, 0)
> >
> >  /* define the DMA transfer step type */
> >  #define SPRD_DMA_NONE_STEP           0
> > @@ -190,6 +193,7 @@ struct sprd_dma_chn {
> >       u32                     dev_id;
> >       enum sprd_dma_chn_mode  chn_mode;
> >       enum sprd_dma_trg_mode  trg_mode;
> > +     enum sprd_dma_int_type  int_type;
> >       struct sprd_dma_desc    *cur_desc;
> >  };
> >
> > @@ -429,6 +433,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
> >               val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> >               val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
> >               val |= SPRD_DMA_GLB_2STAGE_EN;
> > +             if (schan->int_type != SPRD_DMA_NO_INT)
>
> Who configure int_type?

The int_type is configured through the flags of
sprd_dma_prep_slave_sg() by users, see:
https://elixir.bootlin.com/linux/v5.1-rc6/source/include/linux/dma/sprd-dma.h#L9

>
> > +                     val |= SPRD_DMA_GLB_SRC_INT;
> > +
> >               sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
> >               break;
> >
> > @@ -436,6 +443,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
> >               val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> >               val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
> >               val |= SPRD_DMA_GLB_2STAGE_EN;
> > +             if (schan->int_type != SPRD_DMA_NO_INT)
> > +                     val |= SPRD_DMA_GLB_SRC_INT;
> > +
> >               sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
> >               break;
> >
> > @@ -443,6 +453,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
> >               val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> >                       SPRD_DMA_GLB_DEST_CHN_MASK;
> >               val |= SPRD_DMA_GLB_2STAGE_EN;
> > +             if (schan->int_type != SPRD_DMA_NO_INT)
> > +                     val |= SPRD_DMA_GLB_DEST_INT;
> > +
> >               sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
> >               break;
> >
> > @@ -450,6 +463,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
> >               val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> >                       SPRD_DMA_GLB_DEST_CHN_MASK;
> >               val |= SPRD_DMA_GLB_2STAGE_EN;
> > +             if (schan->int_type != SPRD_DMA_NO_INT)
> > +                     val |= SPRD_DMA_GLB_DEST_INT;
> > +
> >               sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
> >               break;
> >
> > @@ -911,11 +927,15 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
> >               schan->linklist.virt_addr = 0;
> >       }
> >
> > -     /* Set channel mode and trigger mode for 2-stage transfer */
> > +     /*
> > +      * Set channel mode, interrupt mode and trigger mode for 2-stage
> > +      * transfer.
> > +      */
> >       schan->chn_mode =
> >               (flags >> SPRD_DMA_CHN_MODE_SHIFT) & SPRD_DMA_CHN_MODE_MASK;
> >       schan->trg_mode =
> >               (flags >> SPRD_DMA_TRG_MODE_SHIFT) & SPRD_DMA_TRG_MODE_MASK;
> > +     schan->int_type = flags & SPRD_DMA_INT_TYPE_MASK;
> >
> >       sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
> >       if (!sdesc)
> > --
> > 1.7.9.5
>
> --
> ~Vinod



-- 
Baolin Wang
Best Regards
