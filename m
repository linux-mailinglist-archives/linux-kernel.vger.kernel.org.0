Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F925644D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 12:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfGJKCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 06:02:14 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45324 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfGJKCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 06:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zblxB+iVfb9FLiCBbkBYMri8q4AqXRvs6Ywv9o/5Rqo=; b=rDfFFK3SXpPlFtSdWkR0y+toF
        qfKmQRCwn2mnd3Ev4B+mSw7jcfHGvP1kVsRmFqTbTiCYpzqPTvHI8Lvb9pEdG6VU81WAxDavas5kh
        BVEQFPWlZKBH3RLHLQ7VV4hE6QYFGYdW+zrMWdfpPOoLrO0xpNSF9BfBq91O/ieUJbm2bc3Ce5cGE
        5c2WtrAMR4XqhIjxdmb9zcJdNCxrY5LJ5a5WVktWI1GEtCs7tB1ZTrF2G4s0maBBUJrjlf6H8WZjC
        vNAQxpmNZaRk0tJURIDrrp8PZILiXQiR8OQWPp7aGT7uvjGxtSkmhfQvKmE7lh6Nr96tL4ce+HeeT
        aLnd7PoOw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:59428)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hl9QN-00060D-V4; Wed, 10 Jul 2019 11:02:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hl9QM-0003o7-6B; Wed, 10 Jul 2019 11:02:06 +0100
Date:   Wed, 10 Jul 2019 11:02:06 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question about ARM FASTFPE
Message-ID: <20190710100206.yls4piu36wciefbz@shell.armlinux.org.uk>
References: <CAK7LNASSCvLSXVikR7GenXyb8KywpWKVc1Z=5v3c93rxJ+G73w@mail.gmail.com>
 <20190710082335.uzusesefimzpjd3f@shell.armlinux.org.uk>
 <CAK7LNAQpiY4CBawEFhQHeTPSrbrRkNoYCtK4jBak+skyyMqESA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQpiY4CBawEFhQHeTPSrbrRkNoYCtK4jBak+skyyMqESA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 06:54:06PM +0900, Masahiro Yamada wrote:
> On Wed, Jul 10, 2019 at 5:23 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Jul 10, 2019 at 01:30:24PM +0900, Masahiro Yamada wrote:
> > > Hi.
> > >
> > > I have a question about the following code
> > > in arch/arm/Makefile:
> > >
> > >
> > > # Do we have FASTFPE?
> > > FASTFPE :=arch/arm/fastfpe
> > > ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
> > > FASTFPE_OBJ :=$(FASTFPE)/
> > > endif
> > >
> > >
> > > Since arch/arm/fastfpe does not exist in the upstream tree,
> > > I guess this is a hook to compile downstream source code.
> > >
> > > If a user puts arch/arm/fastfpe/ into their local source tree,
> > > Kbuild is supposed to compile the files in it.
> > >
> > > Is this correct?
> > >
> > >
> > > If so, I am afraid this would not work for O= building.
> > >
> > > $(wildcard ...) checks if this directory exists in the *objtree*,
> > > while scripts/Makefile.build needs to include
> > > arch/arm/fastfpe/Makefile from *srctree*.
> > >
> > > I think the correct code should be like follows:
> > >
> > > # Do we have FASTFPE?
> > > FASTFPE :=arch/arm/fastfpe
> > > ifneq ($(wildcard $(srctree)/$(FASTFPE)),)
> > > FASTFPE_OBJ :=$(FASTFPE)/
> > > endif
> > >
> > >
> > > Having said that, I am not sure this code is worth fixing.
> > >
> > > This code was added around v2.5.1.9,
> >
> > ... as a _result_ of a discussion and deciding not to upstream it,
> > but to still allow its use.  Fastfpe is faster than nwfpe (so has
> > a definite advantage for FP intensive applications) but we decided
> > we didn't want two FP emulation codes in the kernel.  However, if
> > someone wants to use it, it has to be built into the kernel, it
> > can't be modular.
> 
> 
> IMHO, the entry in Makefile and Kconfig should be removed
> from upstream, then moved to a part of the fastfpe local patch.

Nope.  It means that rather than it being merely a drop-in, it has
to be maintained against changes to both these files.  Sorry, that's
more work.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
