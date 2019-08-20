Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1855795E18
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 14:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfHTMIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 08:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfHTMIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:08:48 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AE732082F;
        Tue, 20 Aug 2019 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566302927;
        bh=ujsmgxgo7zeJJNLlcsG0pBsDui9E8Kq5ruXxXHHtNZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wgcxwkkEJ8ZJ4BYFpTnzMHrSfSrWAfAGv4W1WfwgjDqI+Iq0FmtUyQy0DokU2Be4Y
         gF8ramVgWMQNl7eii2sZdtsWfKmgAInykhNjBfuVMsVUYHDEOpbPJyG3UMYXojhOPa
         49JXL+Fq1zIL+lLEuQUyKFvHe7U3kpic7iPxTTy8=
Date:   Tue, 20 Aug 2019 14:08:45 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH -rcu dev 1/3] rcu/tree: tick_dep_set/clear_cpu should
 accept bits instead of masks
Message-ID: <20190820120843.GA2093@lenoir>
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190819123837.GC27088@lenoir>
 <20190819144632.GW28441@linux.ibm.com>
 <20190819163226.GE27088@lenoir>
 <20190819164420.GA28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819164420.GA28441@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 09:44:20AM -0700, Paul E. McKenney wrote:
> On Mon, Aug 19, 2019 at 06:32:27PM +0200, Frederic Weisbecker wrote:
> > > But would the following patch make sense?  This would not help for (say)
> > > use of TICK_MASK_BIT_POSIX_TIMER instead of TICK_DEP_BIT_POSIX_TIMER, but
> > > would help for any new values that might be added later on.  And currently
> > > for TICK_DEP_MASK_CLOCK_UNSTABLE and TICK_DEP_MASK_RCU.
> > 
> > I'd rather make the TICK_DEP_MASK_* values private to kernel/time/tick-sched.c but
> > that means I need to re-arrange a bit include/trace/events/timer.h
> 
> That would be even better!  For one thing, it would detect misuse of
> -all- of the _MASK_ values.  ;-)

:o)

> 
> > I'm looking into it. Meanwhile, your below patch that checks for the max value is
> > still valuable.
> 
> If I were to push it, it would be v5.5 before it showed up.  My guess
> is therefore that I should keep it for my own internal use in the near
> term, but not push it.  If you would like to take it, feel free to use
> my Signed-off-by.

Ok, applying.

Thanks!
