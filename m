Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4A5E92B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 18:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGCQdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 12:33:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40513 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfGCQdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:33:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so3535939wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AWfKUBqVWZzAawswGY+ZSjKKRhaQkfyUJM16meMSkPo=;
        b=SqQC20u2dDoRyp5jcv3M6XGoifJsMIxnNea7QFL8/kVvb2UCAA8flUyKrqI9ejZsxZ
         kU2lTzUeRu2H0DRUt9A/+YcW0WKC5DXZvqhA47BbU1PJov63d4B7xFHu0rxghzEBubbZ
         fkMx1vyy/KTqcrRxJ+wHbzR2RcWI1bsuYQcvYx643PjJlTEsXtRRS7kMcAVARcFXauGR
         aiyn9SU9SWjPsZCxZay9+2jPSeswBVq0FudAScZpXG6CCQBNvCRRCMx6Rv+uQbeWlscd
         Okt/CDrAd7xyJqLMP7lTdjQCS5owlIquNQtdAenesffTZrDbAuwzfwfl/va0He7LjOa8
         g+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AWfKUBqVWZzAawswGY+ZSjKKRhaQkfyUJM16meMSkPo=;
        b=Uxiv87HW8hyE5W3zuxEaSqgodNIhu2HJ0OBmb1jN/cAn6KL58kU4ZA6SLM/G+DIVQK
         gVMbnK2FgkOsHQCtW9my9OIkWJI/smWBOFsAWMkKAPp9pTIS9Dm4uf6lFzDclVnLVDYs
         XOJIO5yHukwu1X1k5OwD7EXOgQClX3kgLr2bL1TS8FxOUZO6E+OeNTyCb9tjyfUKc22y
         HYauPPPAwa+YZOOKopAu71U6+TSXivbvFARDrCm2POtH5+OD/t8GWE6cMX4LMZqLK1Hs
         l4/DlZiOrwo7J2onW6jMnMj0A5PV+IMhfhDfjk9hDdaZK5i9JCxiyHEEPwhLhkfePLDo
         PDVw==
X-Gm-Message-State: APjAAAWFymECCkgj13LcK42pCalZLHijaPVXJgXHHxcpux3eKRhJI5cZ
        whbMqLVsfrjCynZrLvrTOx+aPA==
X-Google-Smtp-Source: APXvYqzyUKfEjD5zZwvYgn+6s0isuDDnar2rnm433earCTxIt7v2XJpN1VkPtyIJdyIZ37VlPS+lgw==
X-Received: by 2002:a5d:438f:: with SMTP id i15mr24566996wrq.37.1562171594030;
        Wed, 03 Jul 2019 09:33:14 -0700 (PDT)
Received: from bivouac.eciton.net (bivouac.eciton.net. [2a00:1098:0:86:1000:23:0:2])
        by smtp.gmail.com with ESMTPSA id x11sm1849858wmi.26.2019.07.03.09.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 09:33:13 -0700 (PDT)
Date:   Wed, 3 Jul 2019 17:33:11 +0100
From:   Leif Lindholm <leif.lindholm@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Julien Thierry <julien.thierry@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] efi/libstub: detect panel-id
Message-ID: <20190703163311.gtbo72dzpkpjvpi5@bivouac.eciton.net>
References: <20190630203614.5290-1-robdclark@gmail.com>
 <20190630203614.5290-3-robdclark@gmail.com>
 <CAKv+Gu_8BOt+f8RTspHo+se-=igZba1zL0+jWLV2HuuUXCKYpA@mail.gmail.com>
 <CAKv+Gu-KhPJxxJA3+J813OPcnoAD4nHq6MhiRTJSd_5y1dPNnw@mail.gmail.com>
 <CAF6AEGv+uAXVV6Q78n=jP0YRDjYn9OS=Xec9MU0+_7EBirxF5w@mail.gmail.com>
 <20190702215953.wdqges66hx3ge4jr@bivouac.eciton.net>
 <CAF6AEGvm62rcm4Lp4a+QmqFweVQ0QWXLDoN2CP8=40BdwiiVbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGvm62rcm4Lp4a+QmqFweVQ0QWXLDoN2CP8=40BdwiiVbQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 03:48:48PM -0700, Rob Clark wrote:
> > > There is one kernel, and there
> > > are N distro's, so debugging a users "I don't get a screen at boot"
> > > problem because their distro missed some shim patch really just
> > > doesn't seem like a headache I want to have.
> >
> > The distros should not need to be aware *at all* of the hacks required
> > to disguise these platforms as DT platforms.
> >
> > If they do, they're already device-specific installers and have
> > already accepted the logistical/support nightmare.
> 
> I guess I'm not *against* a DT loader shim populating the panel-id
> over into /chosen.. I had it in mind as a backup plan.  Ofc still need
> to get dt folks to buy into /chosen/panel-id but for DT boot I think
> that is the best option.  (At least the /chosen/panel-id approach
> doesn't require the shim to be aware of how the panel is wired up to
> dsi controller and whether their is a bridge in between, and that
> short of thing, so the panel-id approach seems more maintainable that
> other options.)

I am leaning like Ard towards preferring a configuration table though.

That removes the question of no runtime services (needing to manually
cache things, at least until EBBR 1.2 (?) is out and in use), and
means we don't have to use different paths for DT and ACPI. Now we
have UEFI in U-Boot, do we really need to worry about the non-UEFI
case?

> I am a bit fearful of problems arising from different distros and
> users using different versions of shim, and how to manage that.  I
> guess if somehow "shim thing" was part of the kernel, there would by
> one less moving part...

Sure, but that's insurance against bindings changing
non-backwards-compatibly - which there are ways to prevent, and which
streamlining the design for really isn't the way to discourage...

Distros have no need to worry about the DT loader - the whole point of
it is to remove the need for the distro to worry about anything other
than getting the required drivers in.

> I'd know if user had kernel vX.Y.Z they'd be
> good to go vs not.  But *also* depending on a new-enough version of a
> shim, where the version # is probably not easily apparent to the end
> user, sounds a bit scary from the "all the things that can go wrong"
> point of view.  Maybe I'm paranoid, but I'm a bit worried about how to
> manage that.

Until the hardware abstractions provided by the system firmware (ACPI)
is supported, these platforms are not going to be appropriate for
end users anyway. No matter how many not-quite-upstream hacks distros
include, they won't be able to support the next minor spin that comes
off the production line and is no longer compatible with existing DTs.

/
    Leif
