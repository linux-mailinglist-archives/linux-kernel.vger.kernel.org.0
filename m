Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D364F7B1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbfG3STW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:19:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34909 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387845AbfG3STT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:19:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so30286874pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WYV3lJkZz1M8QFLTNcbisKstq4q45qxIoF6vMekR4Ik=;
        b=mZqGk/cUp6ZNJEsrEHgluVspbQqD/bx8uYW6vGDU/FpCW5W4GoxK+4/b1HjJ4bSDCq
         xyW3ZS0uf0DfYXzWcHQIeKMfCqgFrRDayoLgDTv4QOWbhe8Raxi6hVsR1bQ6j1+njf6I
         kMOQ/nc0tCcPOfurVrxe/F1hJnYiinkBApcH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WYV3lJkZz1M8QFLTNcbisKstq4q45qxIoF6vMekR4Ik=;
        b=LUn5vnIrWKYxfxpg+DQdV2hdhbcPS52kBHQQ1cPczd+sRoUm61wUMkUWfcRCpMDFSa
         nGKMKigDTAdpT46jndITriPMG9argZryU+9OKRkvfwY+D59y4RmkksbcAp7mxK1PkBue
         RLPARFlN8+IjxluXvriSQjSDMfyTXa1YevZeswBTuJzgmn+VqmYrDYh7iRHXKS6iLlC5
         U02cWyhXPO68MqlBot3F9ICun5o05a6ruDxymfqefimMIe6DZTZfnY4bnA71iVYCaFCJ
         klZnV8CGVokc3yo/qaFM9uKRHTu1TmnywLPFUKk14UX8vFPb3Lxt/XqTXkDb10uBXynL
         bjGQ==
X-Gm-Message-State: APjAAAVu8TlrbTl6wnsAG0sAQWRGm7z/gKmRiIlSB+XYaF1Ffl+WvJbf
        beKIkKI0p9QPcgnFKvN6ei7jQg==
X-Google-Smtp-Source: APXvYqw4/yqmb0Rlt+53Fv5Ar1d4LMo3nzvzPjOQ1bEXUP20GHFA0n4fefD4ezGXYZ/+3e25mhoUqg==
X-Received: by 2002:a17:90a:360c:: with SMTP id s12mr120028251pjb.30.1564510759254;
        Tue, 30 Jul 2019 11:19:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id h12sm79833057pje.12.2019.07.30.11.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 11:19:18 -0700 (PDT)
Date:   Tue, 30 Jul 2019 11:19:16 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: rockchip: A few fixes for veyron-{fievel,tiger}
Message-ID: <20190730181916.GJ250418@google.com>
References: <20190730173444.56741-1-mka@chromium.org>
 <CAD=FV=Wub9Wkc5t4iQRjBK8R_d_oh4PoHPwLHb4T5+Meij7sSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=Wub9Wkc5t4iQRjBK8R_d_oh4PoHPwLHb4T5+Meij7sSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:01:42AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jul 30, 2019 at 10:34 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > @@ -130,12 +138,13 @@
> >                         regulator-max-microvolt = <1800000>;
> >                         regulator-name = "vdd18_lcdt";
> >                         regulator-state-mem {
> > -                               regulator-on-in-suspend;
> > +                               regulator-off-in-suspend;
> >                                 regulator-suspend-microvolt = <1800000>;
> 
> Please remove "regulator-suspend-microvolt = <1800000>;" which doesn't
> make sense once you have "regulator-off-in-suspend".

will remove all instances

> >                         };
> >                 };
> >
> > -               /* This is not a pwren anymore, but the real power supply,
> > +               /*
> > +                * This is not a pwren anymore, but the real power supply,
> >                  * vdd10_lcd for HDMI_AVDD_1V0
> >                  */
> >                 vdd10_lcd: LDO_REG7 {
> > @@ -145,7 +154,7 @@
> >                         regulator-max-microvolt = <1000000>;
> >                         regulator-name = "vdd10_lcd";
> >                         regulator-state-mem {
> > -                               regulator-on-in-suspend;
> > +                               regulator-off-in-suspend;
> >                                 regulator-suspend-microvolt = <1000000>;
> 
> Please remove "regulator-suspend-microvolt = <1000000>;" which doesn't
> make sense once you have "regulator-off-in-suspend".
> 
> 
> >                         };
> >
> > @@ -159,7 +168,7 @@
> >                         regulator-max-microvolt = <3300000>;
> >                         regulator-name = "vcc33_ccd";
> >                         regulator-state-mem {
> > -                               regulator-on-in-suspend;
> > +                               regulator-off-in-suspend;
> >                                 regulator-suspend-microvolt = <3300000>;
> 
> Please remove "regulator-suspend-microvolt = <3300000>;" which doesn't
> make sense once you have "regulator-off-in-suspend".
> 
> 
> Other than those things, this patch looks good to me and feel free to
> add my Reviewed-by.

Thanks for your review!

> NOTE: when I tried applying this to my tree git
> complained and I had to apply manually.  Could you try sending this
> patch atop Heiko's for-next tree?  The yell I got:
> 
> error: sha1 information is lacking or useless
> (arch/arm/boot/dts/rk3288-veyron-fievel.dts).
> error: could not build fake ancestor

Ok, I'll rebase v2 on Heiko's for-next
