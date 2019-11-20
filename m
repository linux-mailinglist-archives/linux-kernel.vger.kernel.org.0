Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C303F10365C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 10:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfKTJHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 04:07:52 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37242 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfKTJHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DSCUinPNKai22HW1JHW+/dL4VKgNpCZryvn5/wZYgtE=; b=MZi5cqw4EjoPe1UaPXozRB3n9
        Gd5YhBXNyzUKki7Bu+X07b00jfUws///Oewg7+7tM0/fTcGtTeZs4zITQXs/+6Cy2/fkmto/LDFTX
        UBDbvUm/IrV+Q81Zb1URl6mgMvcgjesfD5TACLxHZ0hq40UXhdZbVKOp9Llz8YflxqxtaeQVkBWn9
        qrohdiEcF9bUVOVeWsnieqwU3H+VgLaGyP+A9IqgkHow+T12ieVRibjE/l6csKbMsX7sfFLxnY+YT
        7yAGuRtit6niemo7/lzOmw3LNZPKdvxja6XLt90Vam6X9pLahnGxZOQTlz7oaQ5znVS2x3A/CrdYI
        yf3JYjxuA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:58688)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iXLxj-0007KX-6m; Wed, 20 Nov 2019 09:07:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iXLxh-0001ac-3A; Wed, 20 Nov 2019 09:07:45 +0000
Date:   Wed, 20 Nov 2019 09:07:45 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: don't export unused return_address()
Message-ID: <20191120090744.GH25745@shell.armlinux.org.uk>
References: <20190906154706.2449696-1-arnd@arndb.de>
 <CAMuHMdUMgDBo1gkvQ_Bd8mjMiPjdWWY=9AU6K1S7NcJy5jhvGQ@mail.gmail.com>
 <CAK7LNASNp4jPYHmh3e4QYwenYbVrK69tvB_LLyK_ew1eqBNrEw@mail.gmail.com>
 <20191113114517.GO25745@shell.armlinux.org.uk>
 <CAMuHMdXk9sWBpYWC-X6V3rp2e0+f5ebdRFFXn8Heuy0qkLq0GQ@mail.gmail.com>
 <20191113170058.GP25745@shell.armlinux.org.uk>
 <CAK7LNARiQnc+A0j4ORC-M8ZcbtDYdRF7tU1Zv8Lbst-g8dqmVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARiQnc+A0j4ORC-M8ZcbtDYdRF7tU1Zv8Lbst-g8dqmVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 06:02:13PM +0900, Masahiro Yamada wrote:
> Hi Arnd,
> 
> 
> 
> On Thu, Nov 14, 2019 at 2:01 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Nov 13, 2019 at 02:15:00PM +0100, Geert Uytterhoeven wrote:
> > > Hi Russell,
> > >
> > > On Wed, Nov 13, 2019 at 12:45 PM Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> > > > On Wed, Nov 13, 2019 at 08:40:39PM +0900, Masahiro Yamada wrote:
> > > > > On Tue, Oct 1, 2019 at 11:31 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > On Fri, Sep 6, 2019 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > Without the frame pointer enabled, return_address() is an inline
> > > > > > > function and does not need to be exported, as shown by this warning:
> > > > > > >
> > > > > > > WARNING: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL
> > > > > > >
> > > > > > > Move the EXPORT_SYMBOL_GPL() into the #ifdef as well.
> > > > > > >
> > > > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > >
> > > > > > Thanks for your patch!
> > > > > >
> > > > > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > >
> > > > > > > --- a/arch/arm/kernel/return_address.c
> > > > > > > +++ b/arch/arm/kernel/return_address.c
> > > > > > > @@ -53,6 +53,7 @@ void *return_address(unsigned int level)
> > > > > > >                 return NULL;
> > > > > > >  }
> > > > > > >
> > > > > >
> > > > > > Checkpatch doesn't like the empty line above:
> > > > > >
> > > > > > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > > > > >
> > > > > > > +EXPORT_SYMBOL_GPL(return_address);
> > > > > > > +
> > > > > > >  #endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
> > > > > > >
> > > > > > > -EXPORT_SYMBOL_GPL(return_address);
> > >
> > > > > What has happened to this patch?
> > > > >
> > > > > I still see this warning.
> > > >
> > > > Simple - it got merged, it caused build regressions, it got dropped.
> > > > A new version is pending me doing another round of patch merging.
> > >
> > > I believe that was not Arnd's patch, but Ben Dooks' alternative solution[*]?
> >
> > I don't keep track of who did what, sorry.
> 
> 
> Arnd,
> 
> I believe this patch is the correct fix.
> Could you please put it into Russell's patch tracker?
> (patches@arm.linux.org.uk)

Is there something wrong with:

fb033c95c94c ARM: 8918/2: only build return_address() if needed

I haven't seen any build issues with that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
