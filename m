Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1EA116871
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 09:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfLIIlU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Dec 2019 03:41:20 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35994 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfLIIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:41:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id j17so11966630edp.3;
        Mon, 09 Dec 2019 00:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2kW38B0cuYpIKkhvAIys+E2QTBK5Yh5SHGBkdoRtsZ8=;
        b=U/doeb0ASSeLccIJVyuKbb14cdUxK+NMzI2y90TfR7K3CZwcVjYwkvNnO5Rw3QGWGE
         Zum0Y67eA2gRY8/0VR9U3KOBRBqWkNgYCiLUlqBFcOgDH/pnPT1OJLhmIIkAMxSMVRmb
         HmXWsLh67esThZGiT3KpWIYDWC3OMkFaZ1gz3VTqwzwB6R/fy5mazUrJoem9J37zncAi
         Izh9SzhCN6IQdmCJaKXlMJNZ0WTFgVi4Q29Jrw9vpTAcHdFOEe99MhOy/uFDPUu2GvbZ
         NQDZdw/mVtrDUTvvmipdM7vw40EImRgmK5viRm8+77NQLRyozrbbx3TifCX3VUIVCzJU
         a6Pw==
X-Gm-Message-State: APjAAAWiP69oileIM5fG9hkeZS9/X/lElHQ9S8J9Um2hA6jG+L1SqDds
        ht3ivArDIdrxBv5QiJiztiM=
X-Google-Smtp-Source: APXvYqxnmfRBujpXQ+VU19W08DbV8Aj87ESy1oEsbFuJ+8f1z5uvtmn43KkwiQePVPVKDlPT9/CHWg==
X-Received: by 2002:a17:906:2db1:: with SMTP id g17mr13034085eji.240.1575880877907;
        Mon, 09 Dec 2019 00:41:17 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id f13sm703065edq.26.2019.12.09.00.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 00:41:17 -0800 (PST)
Date:   Mon, 9 Dec 2019 09:41:15 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@gmail.com>
Cc:     linux@armlinux.org.uk, kgene@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Hyunki Koo <hyunki00.koo@samsung.com>
Subject: Re: [PATCH 1/2] irqchip: define EXYNOS_IRQ_COMBINER
Message-ID: <20191209084115.GA6375@pi3>
References: <20191207130049.27533-1-hyunki00.koo@gmail.com>
 <20191207130049.27533-2-hyunki00.koo@gmail.com>
 <20191207132855.GA4384@kozik-lap>
 <CAJKOXPcUXRGa7+ZgSYomo5v_eh=GjqyWYBkzsXUJi0zAPHcOjg@mail.gmail.com>
 <e6c3661e-36df-5ae8-eedb-1961063bcabb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <e6c3661e-36df-5ae8-eedb-1961063bcabb@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2019 at 07:24:49AM +0900, Hyunki Koo wrote:
> 
> On 19. 12. 7. 오후 10:37, Krzysztof Kozlowski wrote:
> > On Sat, 7 Dec 2019 at 14:28, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > On Sat, Dec 07, 2019 at 10:00:48PM +0900, Hyunki Koo wrote:
> > > > From: Hyunki Koo <hyunki00.koo@samsung.com>
> > > > 
> > > > Not all exynos device have IRQ_COMBINER.
> > > > Thus add the config for EXYNOS_IRQ_COMBINER.
> > > > 
> > > > Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> > > > ---
> > > >   drivers/irqchip/Kconfig  | 7 +++++++
> > > >   drivers/irqchip/Makefile | 2 +-
> > > >   2 files changed, 8 insertions(+), 1 deletion(-)
> > > > 
> > > Hi,
> > > 
> > > There is no changelog and versioning of this patch so I do not
> > > understand how it differs with previous. It's a resend? v2? It brings
> > > the confusion and looks like you're ignoring previous comments.
> > > 
> > > Looks the same and looks like breaking Exynos platforms in the same way.
> > > 
> > > If you not want to skip combiner on ARMv8, it makes sense, then please
> > > follow the approach we did for Pinctrl drivers (PINCTRL_EXYNOS_ARM and
> > > PINCTRL_EXYNOS_ARM64).
> > > 
> > > Best regards,
> > > Krzysztof
> > Ah, now I see the second patch. Still you break bisect which requires
> > specific ordering of patches or squashing them into one. Optionally
> > this could be default=y if ARCH_EXYNOS && ARM. I prefer just squashing
> > both into one patch in this case.
> 
> you mean squashing two files arch/arm/mach-exynos/Kconfig and
> arch/arm/mach-exynos/Kconfig into one patch
> 
> or squashing into only one file like blow?
> 
> +config EXYNOS_IRQ_COMBINER
> +       bool "Samsung Exynos IRQ combiner support"
> +       depends on (ARCH_EXYNOS  && ARM) || COMPILE_TEST
> +       default y
> 
> I prefer first one (squashing two files into one patch)

Squashing two patches into one.

> 
> > 
> > > > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > > > index ba152954324b..3ed7b7f2ae26 100644
> > > > --- a/drivers/irqchip/Kconfig
> > > > +++ b/drivers/irqchip/Kconfig
> > > > @@ -499,4 +499,11 @@ config SIFIVE_PLIC
> > > > 
> > > >           If you don't know what to do here, say Y.
> > > > 
> > > > +config EXYNOS_IRQ_COMBINER
> > > > +     bool "Samsung Exynos IRQ combiner support"
> > Now point it to be visible. Only for COMPILE_TEST

Typo from my side. I wanted to say "No point" - this should not be
selectable by user.

> > 
> > > > +     depends on ARCH_EXYNOS
> > Since you make it a separate option, make it COMPILE_TEST.
> 
> Is this  good ?

Not entirely. The bool should be also with "if COMPILE TEST" so:

config EXYNOS_IRQ_COMBINER
	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST


Best regards,
Krzysztof

