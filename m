Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C460F9C71B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 04:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfHZCFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 22:05:51 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:51042 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfHZCFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 22:05:51 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x7Q25aWY001059;
        Mon, 26 Aug 2019 11:05:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x7Q25aWY001059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566785137;
        bh=Y6CSk1yG6UDaWDZc7YQfg16zRcI7iqnK0vjwzjH84CE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JrLOZI9kH1Un3GiyFdXqn27TVvjSOjiidP2JwisE3275p53TA1+juNlIJGqES+aIC
         lrhvsFFvrhgL+1Rn9JCZ7k+c70nDmLE9fC7PnhBQLEE0jo7QN9bGBGc7oExOoy7for
         xHeUDd1uEQHdcLNFkxyi0ExMx/70zDfeQav8I367gxPlmG/U+1smys2aflDCOwWxdP
         NLg3LqorANPMl0GsubTQCVuUvRbnMmq1qJ2yzwdQ+1ip5opdKfo/Pr1JjxayJHGH3S
         5fd2t0J7tqoz4JVukTyDGxALZ7luGmDjzkXmkcLORZXjDZaXCALpBRJSXsc0ULITxJ
         TGKastNgBwoYQ==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id f9so5192402uaj.4;
        Sun, 25 Aug 2019 19:05:37 -0700 (PDT)
X-Gm-Message-State: APjAAAVSGSaK4IXHWaE8o5IZDrnJlFuPIeW7cBhkNbQob+qaHCb1EZs7
        caX9Sq2HXz1F6yLAgJYTARhBXk/2aqPs71p1gFU=
X-Google-Smtp-Source: APXvYqxTTMLLHvl8ZQ3KknXXOxUMTC3Y3hppkNTfIGAtnJsgB3ydviER0RL9pfJ3r191gBIB66pQqdIW5M4t3FT5soQ=
X-Received: by 2002:ab0:442:: with SMTP id 60mr1079956uav.109.1566785136210;
 Sun, 25 Aug 2019 19:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190506223334.1834-1-nicoleotsuka@gmail.com> <20190506223334.1834-3-nicoleotsuka@gmail.com>
 <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
 <CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com> <20190825011025.GA23410@lst.de>
In-Reply-To: <20190825011025.GA23410@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 26 Aug 2019 11:05:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
Message-ID: <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for
 single pages
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, vdumpa@nvidia.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thierry Reding <treding@nvidia.com>,
        Kees Cook <keescook@chromium.org>, iamjoonsoo.kim@lge.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

On Sun, Aug 25, 2019 at 10:10 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Aug 23, 2019 at 09:56:52PM +0900, Masahiro Yamada wrote:
> > + linux-mmc, Ulf Hansson, Adrian Hunter,
> >
> >
> > ADMA of SDHCI is not working
> > since bd2e75633c8012fc8a7431c82fda66237133bf7e
>
> Does it work for you with this commit:
>
> http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/90ae409f9eb3bcaf38688f9ec22375816053a08e


This is included in v5.3-rc6
so I tested it.

No, it did not fix the problem.


--
Best Regards
Masahiro Yamada
