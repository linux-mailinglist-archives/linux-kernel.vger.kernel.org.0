Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB4FAEAC7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 14:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405173AbfIJMmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 08:42:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43910 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfIJMmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:42:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so15220662wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 05:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ub4SnTSb6gIhX0nmNU7ISH0G8O7vugmWfe28Zf8iviI=;
        b=pEwdeA+6eJ8v3UkA9Jzqd5hUweTKn/5vjQBsphWKp3lGezCEmdxB0gkbJnCOEKhGrz
         od2fxEWrNAXGFXdzA33ye3zBGBOj/TLNpu8qryAqCl36Q8YrMxPchxUjjH/s6iaAskST
         nG14v8Olaqg4c72biCSQvDGbqyDto7+ftndjhrijahjXqLbo57GqwAN8Tu7vSi6kOGXL
         dv6Mz5F+83dIbK/Fc3+of/C+73aiioDMEJ/03ccEPHtQpdIUlIxBolLpu6aWQe/SbT09
         lz7f3H58FD/0HQqJttinWByYSGkebP5i289Jmv9hiLHi+8LDCuWuizCnIIOfEnizaqIK
         tEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ub4SnTSb6gIhX0nmNU7ISH0G8O7vugmWfe28Zf8iviI=;
        b=NLKc2UZOUL7cmu4sa0A5mqa6KWzMT5rUmExcVIsJ4LHESCfs1NgYOduKrXRzYZdy6j
         4aVDVVY9wA9o8E2J11tt4LTTxn/XikRpft8r2DRgINMzsKvN/PhuIKoaSXnSKmurgj1X
         Any1CYNPBN+jq0uDZhpuEUL7STGNLasf9rq9w8XgC+llOe016cvszg9z9qHP6K2NCDVQ
         zOwX2CvEdi3Xlo7e8Dgo3CDgv/gN9LeswkQKQ0sskRMjsBOVzciyYVfxcDrKA6ZBJeBh
         5ma2CLKzPAb7OqFpbDh2Hn6Q/HSe2Aw/bSrcbXaOywiC79HSZH0rb+ezABKh+VQhdYHC
         iGFQ==
X-Gm-Message-State: APjAAAWVAsdjZ4dkPjpMBrOg8twtpuaZwsTnPympAS1HSvO+NwtAAI9i
        4EuZwMvj1sJzbQxNsV99KIjkXg==
X-Google-Smtp-Source: APXvYqxFgL8FIlOMUuSCgraQ22g8Zjq1m1xa+tcRMBGgUky84S5wpONFoqDvxPucL2VbgiLpgWRkng==
X-Received: by 2002:a05:6000:12d1:: with SMTP id l17mr25805559wrx.91.1568119372913;
        Tue, 10 Sep 2019 05:42:52 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id h5sm13118486wrr.10.2019.09.10.05.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 05:42:52 -0700 (PDT)
Date:   Tue, 10 Sep 2019 13:42:50 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     mpm@selenic.com, herbert@gondor.apana.org.au,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>, sumit.garg@linaro.org,
        jens.wiklander@linaro.org, vkoul@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v2 1/2] dt-binding: hwrng: add NPCM RNG documentation
Message-ID: <20190910124250.2i5muqjt5c35kvgb@holly.lan>
References: <20190909123840.154745-1-tmaimon77@gmail.com>
 <20190909123840.154745-2-tmaimon77@gmail.com>
 <20190910102505.vgyomi575ldrk2lq@holly.lan>
 <CAP6Zq1igPJ5PvaA2YaC-=ngQOnatt4PFJj-QzaJCueDf6KA19A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6Zq1igPJ5PvaA2YaC-=ngQOnatt4PFJj-QzaJCueDf6KA19A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 02:55:44PM +0300, Tomer Maimon wrote:
> Hi Daniel,
> 
> Sorry but I have probably miss it, thanks a lot for your comment
> 
> On Tue, 10 Sep 2019 at 13:25, Daniel Thompson <daniel.thompson@linaro.org>
> wrote:
> 
> > On Mon, Sep 09, 2019 at 03:38:39PM +0300, Tomer Maimon wrote:
> > > Added device tree binding documentation for Nuvoton BMC
> > > NPCM Random Number Generator (RNG).
> > >
> > > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > > ---
> > >  .../bindings/rng/nuvoton,npcm-rng.txt           | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >  create mode 100644
> > Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt
> > b/Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt
> > > new file mode 100644
> > > index 000000000000..a697b4425fb3
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt
> > > @@ -0,0 +1,17 @@
> > > +NPCM SoC Random Number Generator
> > > +
> > > +Required properties:
> > > +- compatible  : "nuvoton,npcm750-rng" for the NPCM7XX BMC.
> > > +- reg         : Specifies physical base address and size of the
> > registers.
> > > +
> > > +Optional property:
> > > +- quality : estimated number of bits of true entropy per 1024 bits
> > > +                     read from the rng.
> > > +                     If this property is not defined, it defaults to
> > 1000.
> >
> > There are pending unreplied review comments about this property (my own
> > as it happens):
> > https://patchwork.kernel.org/patch/11119371/
> >
> > No, there isn't different SoCs.
> we had checked the quality of the hwrng and the results we got are set as
> default.
> we been asked from one of our client to have a dynamic quality, they will
> like to be more strict when using the hwrng.
> is it problematic to add it?

It's a slightly grey area but in general the role of devicetree is to
describe the hardware. This parameter is not doing that.

If you view the quality assessment of this RNG to be a user preference
it is better set the quality to zero which is what the vast majority of
hwrng devices do. When the driver sets the quality to zero then the
kernel does not stir the entropy pool automatically... instead it
relies on the userspace rngd to do that. If the user wants the kernel
to stir the pool automatically then the quality can be set using the
default_quality kernel parameter.


Daniel.

> 
> Having a controllable quality implies that the numeric quality of the
> peripheral changes when it is stamped out on different SoCs (otherwise
> the driver can confidently set the quality without needing any hint
> from the DT). Is that really true here?
> 
> 
> > Daniel.
> >
> > > +
> > > +Example:
> > > +
> > > +rng: rng@f000b000 {
> > > +     compatible = "nuvoton,npcm750-rng";
> > > +     reg = <0xf000b000 0x8>;
> > > +};
> > > --
> > > 2.18.0
> > >
> >
