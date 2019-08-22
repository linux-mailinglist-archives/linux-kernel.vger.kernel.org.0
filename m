Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E97899974
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 18:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbfHVQmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 12:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731880AbfHVQmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:42:51 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30ED8233FD;
        Thu, 22 Aug 2019 16:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566492170;
        bh=6hJ/e3xsqheFfKXl0ThuhFz0zaP+4lSo12cfTf5ujTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9yC86KdtbTDhtmXrGJkrRDtj2LuZoeTwJAfnEzocp45KdnBE7VwF7eow4cB/FxPT
         swE72HSNQtx7gvwkPrw2CIUvjxiaXT6nTosKZidfwtFGDjEmhogqBtDgMjeGW7E8zU
         6Qi2H2bf4Of0ia9DCJ+oknvegUItmZpxlaEeFu4M=
Date:   Thu, 22 Aug 2019 09:42:49 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
Message-ID: <20190822164249.GA12551@kroah.com>
References: <20190820222403.GB8120@kroah.com>
 <201908220959.x7M9xP8r011133@www262.sakura.ne.jp>
 <20190822133538.GA16793@kroah.com>
 <e8d3ce30-8c61-048e-2606-f8a4e8f08d87@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8d3ce30-8c61-048e-2606-f8a4e8f08d87@i-love.sakura.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 11:00:59PM +0900, Tetsuo Handa wrote:
> On 2019/08/22 22:35, Greg Kroah-Hartman wrote:
> > On Thu, Aug 22, 2019 at 06:59:25PM +0900, Tetsuo Handa wrote:
> >> Tetsuo Handa wrote:
> >>> Greg Kroah-Hartman wrote:
> >>>> Oh, nice!  This shouldn't break anything that is assuming that the read
> >>>> will complete before a signal is delivered, right?
> >>>>
> >>>> I know userspace handling of "short" reads is almost always not there...
> >>>
> >>> Since this check will give up upon SIGKILL, userspace won't be able to see
> >>> the return value from read(). Thus, returning 0 upon SIGKILL will be safe. ;-)
> >>> Maybe we also want to add cond_resched()...
> >>>
> >>> By the way, do we want similar check on write_mem() side?
> >>> If aborting "write to /dev/mem" upon SIGKILL (results in partial write) is
> >>> unexpected, we might want to ignore SIGKILL for write_mem() case.
> >>> But copying data from killed threads (especially when killed by OOM killer
> >>> and userspace memory is reclaimed by OOM reaper before write_mem() returns)
> >>> would be after all unexpected. Then, it might be preferable to check SIGKILL
> >>> on write_mem() side...
> >>>
> >>
> >> Ha, ha. syzbot reported the same problem using write_mem().
> >> https://syzkaller.appspot.com/text?tag=CrashLog&x=1018055a600000
> >> We want fatal_signal_pending() check on both sides.
> > 
> > Ok, want to send a patch for that?
> 
> Yes. But before sending a patch, I'm trying to dump values using debug printk().
> 
> > 
> > And does anything use /dev/mem anymore?  I think X stopped using it a
> > long time ago.
> > 
> >> By the way, write_mem() worries me whether there is possibility of replacing
> >> kernel code/data with user-defined memory data supplied from userspace.
> >> If write_mem() were by chance replaced with code that does
> >>
> >>    while (1);
> >>
> >> we won't be able to return from write_mem() even if we added fatal_signal_pending() check.
> >> Ditto for replacing local variables with unexpected values...
> > 
> > I'm sorry, I don't really understand what you mean here, but I haven't
> > had my morning coffee...  Any hints as to an example?
> 
> Probably similar idea: "lockdown: Restrict /dev/{mem,kmem,port} when the kernel is locked down"
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/char/mem.c?h=next-20190822&id=9b9d8dda1ed72e9bd560ab0ca93d322a9440510e
> 
> Then, syzbot might want to blacklist writing to /dev/mem .

syzbot should probably blacklist that now, you can do a lot of bad
things writing to that device node :(
