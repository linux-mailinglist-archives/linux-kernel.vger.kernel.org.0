Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9752BAFFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfIKPJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 11:09:00 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:60684 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbfIKPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:09:00 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2BB5D72CC6C;
        Wed, 11 Sep 2019 18:08:58 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id E60E17CCB47; Wed, 11 Sep 2019 18:08:57 +0300 (MSK)
Date:   Wed, 11 Sep 2019 18:08:57 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2] fork: check exit_signal passed in clone3() call
Message-ID: <20190911150857.GA23868@altlinux.org>
References: <20190910175852.GA15572@asgard.redhat.com>
 <20190911064852.9f236d4c201b50e14d717c14@linux-foundation.org>
 <20190911135236.73l6icwxqff7fkw5@wittgenstein>
 <20190911141635.lafrcjwvbhjm3ezy@wittgenstein>
 <20190911143213.GB21600@asgard.redhat.com>
 <20190911145446.vkcqy2shldi5ibb5@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911145446.vkcqy2shldi5ibb5@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 04:54:47PM +0200, Christian Brauner wrote:
> On Wed, Sep 11, 2019 at 03:32:13PM +0100, Eugene Syromiatnikov wrote:
> > On Wed, Sep 11, 2019 at 04:16:36PM +0200, Christian Brauner wrote:
> > > On Wed, Sep 11, 2019 at 03:52:36PM +0200, Christian Brauner wrote:
> > > > On Wed, Sep 11, 2019 at 06:48:52AM -0700, Andrew Morton wrote:
> > > > > What are the user-visible runtime effects of this bug?
> > 
> > The userspace can set -1 as an exit_signal, and that will break process
> > signalling and reaping.
> > 
> > > > > Relatedly, should this fix be backported into -stable kernels?  If so, why?
> > > > 
> > > > No, as I said in my other mail clone3() is not in any released kernel
> > > > yet. clone3() is going to be released in v5.3.
> > > 
> > > Sigh, I spoke to soon... Hm, this is placed in _do_fork(). There's a
> > > chance that this might be visible in legacy clone if anyone passes in an
> > > invalid signal greater than NSIG right now somehow, they'd now get
> > > EINVAL if I'm seeing this right.
> > > 
> > > So an alternative might be to only fix this in clone3() only right now
> > > and get this patch into 5.3 to not release clone3() with this bug from
> > > legacy clone duplicated.
> > > And we defer the actual legacy clone fix until after next merge window
> > > having it stew in linux-next for a couple of rcs. Distros often pull in
> > > rcs so if anyone notices a regression for legacy clone we'll know about
> > > it... valid_signal() checks at process exit time when the parent is
> > > supposed to be notifed will catch faulty signals anyway so it's not that
> > > big of a deal.
> > 
> > As the patch is written, only copy_clone_args_from_user is touched (which
> > is used only by clone3 and not legacy clone), and the check added
> 
> Great!
> 
> > replicates legacy clone behaviour: userspace can set 0..CSIGNAL
> > as an exit_signal.   Having ability to set exit_signal in NSIG..CSIGNAL
> 
> Hm. The way I see it for clone3() it would make sense to only have <
> NSIG right away. valid_signal() won't let through anything else
> anyway... Since clone3() isn't out yet it doesn't make sense to
> replicate the (buggy) behavior of legacy clone, right?

I agree, let's have a proper exit_signal check in the new syscall
from the beginning.

It should be as simple as
	if (unlikely((args.exit_signal & ~((u64)CSIGNAL)) ||
		     !valid_signal(args.exit_signal)))
		return -EINVAL;
shouldn't it?


-- 
ldv
