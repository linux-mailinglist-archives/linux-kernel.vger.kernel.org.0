Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B5764BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 20:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfGJSCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 14:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbfGJSCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:02:45 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3456F20844;
        Wed, 10 Jul 2019 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562781765;
        bh=KFGaAqqNpUWmU9c47f997s7PEzdV9jbLos0AqkAsUVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwFFK4pGoZCSPrz+JNDCvPgIycc256Op50N1bPJzN5YbJf/EkSvOMyLjkWgzzor3j
         E2XooU0qpWDyO/rPFNvKyblb8x6qsAQsbpmBSCdPfscjMCyf5gPXFu5u1B5DE3e+8S
         xwjxYVEMGHv+LiQhi/zwX0In2Otdyo7XJt/pFFwA=
Date:   Wed, 10 Jul 2019 11:02:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
Message-ID: <20190710180242.GA193819@gmail.com>
Mail-Followup-To: Bart Van Assche <bvanassche@acm.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <00000000000089a718058556e1d8@google.com>
 <f71aaffa-ecf4-1def-fe50-91f37c677537@acm.org>
 <20190710053030.GB2152@sol.localdomain>
 <b378a903-d0fc-a137-e6b9-dec55277cf16@acm.org>
 <20190710170057.GB801@sol.localdomain>
 <20190710172123.GC801@sol.localdomain>
 <f498d8cc-ba82-d3dc-7557-142a1b35976a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f498d8cc-ba82-d3dc-7557-142a1b35976a@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 10:46:00AM -0700, Bart Van Assche wrote:
> On 7/10/19 10:21 AM, Eric Biggers wrote:
> > With my simplified reproducer, on commit 669de8bda87b ("kernel/workqueue: Use
> > dynamic lockdep keys for workqueues") I see:
> > 
> > 	WARNING: CPU: 3 PID: 189 at kernel/locking/lockdep.c:747 register_lock_class+0x4f6/0x580
> > 
> > and then somewhat later:
> > 
> > 	BUG: MAX_LOCKDEP_KEYS too low!
> > 
> > If on top of that I cherry pick commit 28d49e282665 ("locking/lockdep: Shrink
> > struct lock_class_key"), I see instead:
> > 
> > 	BUG: MAX_STACK_TRACE_ENTRIES too low!
> > 
> > I also see that on mainline.
> > 
> > Alternatively, if I check out 669de8bda87b and revert it, I don't see anything.
> 
> Hi Eric,
> 
> Is the rdma_ucm code the only code that triggers the "BUG:
> MAX_STACK_TRACE_ENTRIES too low!" complaint or is this complaint also
> triggered by other kernel code? I'm asking this because I think that
> fixing this would require to implement garbage collection for the
> stack_trace[] array in the lockdep code. That would make the lockdep
> code slower. I don't think that making the lockdep code slower would be
> welcome.
> 
> Bart.

I already mentioned that io_uring triggers it too.

Those are just 2 cases that syzbot happened to generate reproducers for.  I
expect there are many others too, since many places in the kernel allocate
workqueues.  AFAICS most are placed in static or global variables which avoids
this issue, but there are still many cases where a workqueue is owned by some
dynamic structure that can have a much shorter lifetime.

You can also check the other syzbot reports that look similar
(https://lore.kernel.org/lkml/20190710055838.GC2152@sol.localdomain/).
Two of them have C reproducers too.

- Eric
