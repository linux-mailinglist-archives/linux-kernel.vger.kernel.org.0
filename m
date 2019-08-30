Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 845C7A4090
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 00:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfH3W3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 18:29:40 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41070 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbfH3W3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BWWRszBDY8GYUUZj497FcR9Z0dm6vMXF/gAZdr1ItkU=; b=folcv0CYTG/fwfjtFT9od8gVs
        LmEkdhrber88LNPUMfbnmY4rZ5fcd6bEa4DdOxmDoMu8xDExn/Ah5NsTeoI67i87J4KX+zvMgMHIb
        Ws9JXOfrWIwDKAxjHZQtmgeB4RYPXtOCted2vh317YUbPEILBPMVpm3trknP9hAJMv6/Y2wgPA+WP
        wNCmXpqm4dfbnsqB6hRtF87ZAG3KuEF6wLqrmulnjvI4Q/59G99z2HxGzlO9ADkFfPthetXTJumhD
        23Mnjr5oNCzxiwqoWuV2HZnjQQPp2jL64KL9cYbdk5DXvRG6sWjdB3OTqaVm3UT3YlCBvws4YFgZW
        XWmelzPCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39464)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i3pOJ-00013m-HY; Fri, 30 Aug 2019 23:29:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i3pOE-0000Tw-MP; Fri, 30 Aug 2019 23:29:06 +0100
Date:   Fri, 30 Aug 2019 23:29:06 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jing Xiangfeng <jingxiangfeng@huawei.com>,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, bhelgaas@google.com, tglx@linutronix.de,
        sakari.ailus@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] arm: fix page faults in do_alignment
Message-ID: <20190830222906.GH13294@shell.armlinux.org.uk>
References: <1567171877-101949-1-git-send-email-jingxiangfeng@huawei.com>
 <20190830133522.GZ13294@shell.armlinux.org.uk>
 <87d0gmwi73.fsf@x220.int.ebiederm.org>
 <20190830203052.GG13294@shell.armlinux.org.uk>
 <87y2zav01z.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2zav01z.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 04:02:48PM -0500, Eric W. Biederman wrote:
> Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:
> 
> > On Fri, Aug 30, 2019 at 02:45:36PM -0500, Eric W. Biederman wrote:
> >> Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:
> >> 
> >> > On Fri, Aug 30, 2019 at 09:31:17PM +0800, Jing Xiangfeng wrote:
> >> >> The function do_alignment can handle misaligned address for user and
> >> >> kernel space. If it is a userspace access, do_alignment may fail on
> >> >> a low-memory situation, because page faults are disabled in
> >> >> probe_kernel_address.
> >> >> 
> >> >> Fix this by using __copy_from_user stead of probe_kernel_address.
> >> >> 
> >> >> Fixes: b255188 ("ARM: fix scheduling while atomic warning in alignment handling code")
> >> >> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> >> >
> >> > NAK.
> >> >
> >> > The "scheduling while atomic warning in alignment handling code" is
> >> > caused by fixing up the page fault while trying to handle the
> >> > mis-alignment fault generated from an instruction in atomic context.
> >> >
> >> > Your patch re-introduces that bug.
> >> 
> >> And the patch that fixed scheduling while atomic apparently introduced a
> >> regression.  Admittedly a regression that took 6 years to track down but
> >> still.
> >
> > Right, and given the number of years, we are trading one regression for
> > a different regression.  If we revert to the original code where we
> > fix up, we will end up with people complaining about a "new" regression
> > caused by reverting the previous fix.  Follow this policy and we just
> > end up constantly reverting the previous revert.
> >
> > The window is very small - the page in question will have had to have
> > instructions read from it immediately prior to the handler being entered,
> > and would have had to be made "old" before subsequently being unmapped.
> 
> > Rather than excessively complicating the code and making it even more
> > inefficient (as in your patch), we could instead retry executing the
> > instruction when we discover that the page is unavailable, which should
> > cause the page to be paged back in.
> 
> My patch does not introduce any inefficiencies.  It onlys moves the
> check for user_mode up a bit.  My patch did duplicate the code.
> 
> > If the page really is unavailable, the prefetch abort should cause a
> > SEGV to be raised, otherwise the re-execution should replace the page.
> >
> > The danger to that approach is we page it back in, and it gets paged
> > back out before we're able to read the instruction indefinitely.
> 
> I would think either a little code duplication or a function that looks
> at user_mode(regs) and picks the appropriate kind of copy to do would be
> the best way to go.  Because what needs to happen in the two cases for
> reading the instruction are almost completely different.

That is what I mean.  I'd prefer to avoid that with the large chunk of
code.  How about instead adding a local replacement for
probe_kernel_address() that just sorts out the reading, rather than
duplicating all the code to deal with thumb fixup. 

> > However, as it's impossible for me to contact the submitter, anything
> > I do will be poking about in the dark and without any way to validate
> > that it does fix the problem, so I think apart from reviewing of any
> > patches, there's not much I can do.
> 
> I didn't realize your emails to him were bouncing.  That is odd.  Mine
> don't appear to be.

Hmm, so the fact I posted publically in reply to my reply with the MTA
bounce message didn't give you a clue?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
