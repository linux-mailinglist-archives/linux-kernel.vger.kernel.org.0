Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA79591617
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 12:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfHRKQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 06:16:12 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58488 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfHRKQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 06:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eI80pY+n2LcdriTG3iXes2m396KdvY2t7uB/aQuv8IQ=; b=T+Qa2ujMwImGwBV5ZZMW9QElR
        1ROMsPYIUnKSa+03tQv+hatImsj6huflHU8bLfJIQwoRHvzHjCMNunJsIvGelUlR/7Ecyx2MIyQpJ
        F1gSPC9chPx22jkcvTJiLw5SHMad/lR6ywCcPVrovZoJ8Sh0e7y3TiNFxpukHBxV9F+T6VFjxVOQY
        n3yRQOaLfcVL/Ta45RL7l3Qz7kOwt/HMIdQ+dEYoQrT7ksdUB8RKmO6YwSAhw7jhwRJ+Qh1CE77JP
        +OYV+E9PTgQ5uT9PFDO5AG6a+jc3akEdA2YJytBqc8sqS61sHF7kbqw30r6PQ/C/WTgzY3zsWN46M
        ZBxl/JVng==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58052)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hzIEA-0005Dq-HY; Sun, 18 Aug 2019 11:15:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hzIE3-0003m6-7B; Sun, 18 Aug 2019 11:15:51 +0100
Date:   Sun, 18 Aug 2019 11:15:51 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Berger <opendmb@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch : arm : add a criteria for pfn_valid
Message-ID: <20190818101551.GN13294@shell.armlinux.org.uk>
References: <1566010813-27219-1-git-send-email-huangzhaoyang@gmail.com>
 <20190817183240.GM13294@shell.armlinux.org.uk>
 <CAGWkznEvHE6B+eLnCn=s8Hgm3FFbbXcEdj_OxCM4NOj0u61FGA@mail.gmail.com>
 <20190818082035.GD10627@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818082035.GD10627@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 11:20:35AM +0300, Mike Rapoport wrote:
> On Sun, Aug 18, 2019 at 03:46:51PM +0800, Zhaoyang Huang wrote:
> > On Sun, Aug 18, 2019 at 2:32 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Sat, Aug 17, 2019 at 11:00:13AM +0800, Zhaoyang Huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > pfn_valid can be wrong while the MSB of physical address be trimed as pfn
> > > > larger than the max_pfn.
> > >
> > > What scenario are you addressing here?  At a guess, you're addressing
> > > the non-LPAE case with PFNs that correspond with >= 4GiB of memory?
> > Please find bellowing for the callstack caused by this defect. The
> > original reason is a invalid PFN passed from userspace which will
> > introduce a invalid page within stable_page_flags and then kernel
> > panic.

Thanks.

> Yeah, arm64 hit this issue a while ago and it was fixed with commit
> 5ad356eabc47 ("arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()").
> 
> IMHO, the check 
> 
> 	if ((addr >> PAGE_SHIFT) != pfn)
> 
> is more robust than comparing pfn to max_pfn.

Yep, I'd prefer to see:

	phys_addr_t addr = __pfn_to_phys(pfn);

	if (__pfn_to_phys(addr) != pfn)
		return 0;

	return memblock_is_map_memory(addr);

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
