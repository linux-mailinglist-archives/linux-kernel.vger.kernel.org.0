Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED106E1665
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 11:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404032AbfJWJkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 05:40:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39543 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbfJWJkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:40:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id a11so5208313wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=T1vZzFViZyMkNTAaMLcRtzCAcI3MmnDKFouAR6APmLw=;
        b=baqvOwE4akmVAZoKsYSgsHLHqy6z2Ogz6Fh2kYLnw+faVDaGNCl83nolJogzWCqyP5
         W0zBf5tSZqoPFjZUkouxLd9gDLNMjFaTkSlQlE6ZdoVRV3DewMuf3jI7i1g2KDITYfCF
         BxvupF/D4ssQasSWtotBkG/uwDB68xzfxuI09jr63uOP+1B5+rbI3cweZ8Kt0keGj7RT
         WZEprvrNLFm8fCHsK1g55qBu9NKRQCGsWJP+YyKFU/1Mi+x0VGHnzgdO0pLNX9ZUTxFt
         5OlGNAMlbAEQG6gENZoOXxfQnaQzwcRwLr83wcDXelInl6p8ZeLiBdX85bjfQjEiwHUE
         KFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T1vZzFViZyMkNTAaMLcRtzCAcI3MmnDKFouAR6APmLw=;
        b=H67hpYxUeFrG7pcn4VJe6ewEenRvbwqHyiDxHJSnsSaJ/31YhIGhlZZExK0ItlotK3
         98tlE+ZJF4phawM+kdRngbiLmr38CZncurT1V0tsgGBNKGsVHDdpKqDRCfs+9PLlBeEo
         gHSbgEyflB8ShPmhmLBmYTkGs2ZOCodbvi2HfITowhEk+nKboQwrzIGQjJEi5fyRgqkq
         eR+gpdUTav5HuHdaegLRXjIOZVUEGsu5bhgN1XaZycHc63r6dWIiiUb0Gzhrm4m8vqDM
         9rwzhNCuJRu/2kg5D6uQgGd2vW/PZFCwBseU+mX9Fij6MHU5UCPVvXSQl3noAg46aT+I
         vjZQ==
X-Gm-Message-State: APjAAAWw0PUyAqAD1ELGiKEaxE6GLWYrEsyBxJ8UBUeIwsy6mYmkwgXE
        RfGkVO4st1O71ok4l6U9panwPA==
X-Google-Smtp-Source: APXvYqycXcyw31uAAhWTtIQ5erAv+53zHhtWrf7wMIsRejx/pwbJLyNDcoWiQ9gT5mZGlllhEUK4wg==
X-Received: by 2002:adf:978a:: with SMTP id s10mr7889652wrb.264.1571823645654;
        Wed, 23 Oct 2019 02:40:45 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id r5sm3650011wrs.57.2019.10.23.02.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 02:40:45 -0700 (PDT)
Date:   Wed, 23 Oct 2019 10:40:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v3] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20191023094043.GB19477@dell>
References: <1569338741-2784-1-git-send-email-gene.chen.richtek@gmail.com>
 <20191004133324.GE18429@dell>
 <CAE+NS37bQyWknxy+bXYZqyHH_3RbhTQJc5fVd=ibjV6QMz_rew@mail.gmail.com>
 <CAE+NS37TEcfxOy97WL0kQ2u8zM9sbROaEr-1b81hX2eoqh-sfg@mail.gmail.com>
 <20191016100438.GF4365@dell>
 <CAE+NS36Pdc8zutu=GpNQkREyEu07iLF8NDMtSQcUJE3RuuT2VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS36Pdc8zutu=GpNQkREyEu07iLF8NDMtSQcUJE3RuuT2VQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019, Gene Chen wrote:

> 2019-10-16 18:04 GMT+08:00, Lee Jones <lee.jones@linaro.org>:
> > On Tue, 15 Oct 2019, Gene Chen wrote:
> >
> >> Hi Lee,
> >>
> >> we find OF_MFD_CELL is not defined in mfd/core.h, which is ready to
> >> merge to next kernel version
> >> https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next-history/+/master/Next/merge.log
> >
> > It's here:
> >
> > Merging mfd/for-mfd-next (38a6fc63a3ea mfd: db8500-prcmu: Example using new
> > OF_MFD_CELL/MFD_CELL_BASIC MACROs)
> > $ git merge mfd/for-mfd-next
> > Merge made by the 'recursive' strategy.
> >  drivers/mfd/ab8500-core.c    | 138
> > +++++++++++++------------------------------
> >  drivers/mfd/db8500-prcmu.c   |  21 +++----
> >  drivers/mfd/intel-lpss-pci.c |  28 ++++++---
> >  drivers/mfd/ipaq-micro.c     |   6 +-
> >  drivers/mfd/rk808.c          |  22 ++-----
> >  include/linux/mfd/core.h     |  29 +++++++++                <===== [THIS
> > ONE]
> >  include/linux/mfd/rk808.h    |   2 +-
> >  7 files changed, 105 insertions(+), 141 deletions(-)
> >
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next-history/+/master/Next/merge.log#4470
> >
> 
> I thought i need to wait this "mfd/for-mfd-next" patch merge to latest
> codebase, but we can't actually get the date or version (e.g. Linux
> 5.4-rc4) landing
> and i try command "git merge mfd/for-mfd-next" which also can't work
> may i ask how to pull this patch for temporarily build pass?

Rebase onto for-mfd-next or cherry-pick the commit you need.

The tree is located here:

  https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
