Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75142AFEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 16:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfIKOcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 10:32:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfIKOcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:32:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA41930C0630;
        Wed, 11 Sep 2019 14:32:53 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-72.ams2.redhat.com [10.36.112.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4817A60C18;
        Wed, 11 Sep 2019 14:32:41 +0000 (UTC)
Date:   Wed, 11 Sep 2019 15:32:13 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2] fork: check exit_signal passed in clone3() call
Message-ID: <20190911143213.GB21600@asgard.redhat.com>
References: <20190910175852.GA15572@asgard.redhat.com>
 <20190911064852.9f236d4c201b50e14d717c14@linux-foundation.org>
 <20190911135236.73l6icwxqff7fkw5@wittgenstein>
 <20190911141635.lafrcjwvbhjm3ezy@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911141635.lafrcjwvbhjm3ezy@wittgenstein>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 11 Sep 2019 14:32:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 04:16:36PM +0200, Christian Brauner wrote:
> On Wed, Sep 11, 2019 at 03:52:36PM +0200, Christian Brauner wrote:
> > On Wed, Sep 11, 2019 at 06:48:52AM -0700, Andrew Morton wrote:
> > > What are the user-visible runtime effects of this bug?

The userspace can set -1 as an exit_signal, and that will break process
signalling and reaping.

> > > Relatedly, should this fix be backported into -stable kernels?  If so, why?
> > 
> > No, as I said in my other mail clone3() is not in any released kernel
> > yet. clone3() is going to be released in v5.3.
> 
> Sigh, I spoke to soon... Hm, this is placed in _do_fork(). There's a
> chance that this might be visible in legacy clone if anyone passes in an
> invalid signal greater than NSIG right now somehow, they'd now get
> EINVAL if I'm seeing this right.
> 
> So an alternative might be to only fix this in clone3() only right now
> and get this patch into 5.3 to not release clone3() with this bug from
> legacy clone duplicated.
> And we defer the actual legacy clone fix until after next merge window
> having it stew in linux-next for a couple of rcs. Distros often pull in
> rcs so if anyone notices a regression for legacy clone we'll know about
> it... valid_signal() checks at process exit time when the parent is
> supposed to be notifed will catch faulty signals anyway so it's not that
> big of a deal.

As the patch is written, only copy_clone_args_from_user is touched (which
is used only by clone3 and not legacy clone), and the check added
replicates legacy clone behaviour: userspace can set 0..CSIGNAL
as an exit_signal.   Having ability to set exit_signal in NSIG..CSIGNAL
renge seems to be a bug, but at least it seems to be harmless one
and indeed may be addressed separately in the future.
