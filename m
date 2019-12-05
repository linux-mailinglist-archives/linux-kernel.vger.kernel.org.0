Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9512113ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 05:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfLEEUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 23:20:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbfLEEUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 23:20:01 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED9842073B;
        Thu,  5 Dec 2019 04:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575519601;
        bh=i2PIqlRJ7sQMFV6ii943yJLdx+iIcnR8GRR57prfsxw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IFhU+OVdep6Oru3Q3sqJPA9ZGxPVPlzywpRQHl1c3Yaw19nIQf+CLtTTArePS9hvQ
         1XxiSzS2m6BVTgy+5EiXZNjN1Cb+OV6v5W8AnLk33ztTiU2jawo8ihutjJmRvm3KGs
         0vNnxWXcgjJ/1N6ov3GG2CIRhlS4SpFQ5Y8Mpb1o=
Date:   Thu, 5 Dec 2019 13:19:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching
 kprobe
Message-Id: <20191205131956.5465722a947ff41ea22cbdf1@kernel.org>
In-Reply-To: <20191204161239.GL2889@paulmck-ThinkPad-P72>
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
        <20191202210854.GD17234@google.com>
        <20191203071329.GC115767@gmail.com>
        <20191203175712.GI2889@paulmck-ThinkPad-P72>
        <20191204100549.GB114697@gmail.com>
        <20191204161239.GL2889@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Wed, 4 Dec 2019 08:12:39 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Wed, Dec 04, 2019 at 11:05:50AM +0100, Ingo Molnar wrote:
> > 
> > * Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > > >  * This list-traversal primitive may safely run concurrently with
> > > >  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> > > >  * as long as the traversal is guarded by rcu_read_lock().
> > > >  */
> > > > #define hlist_for_each_entry_rcu(pos, head, member, cond...)            \
> > > > 
> > > > is actively harmful. Why is it there?
> > > 
> > > For cases where common code might be invoked both from the reader
> > > (with RCU protection) and from the updater (protected by some
> > > lock).  This common code can then use the optional argument to
> > > hlist_for_each_entry_rcu() to truthfully tell lockdep that it might be
> > > called with either form of protection in place.
> > > 
> > > This also combines with the __rcu tag used to mark RCU-protected
> > > pointers, in which case sparse complains when a non-RCU API is applied
> > > to these pointers, to get back to your earlier question about use of
> > > hlist_for_each_entry_rcu() within the update-side lock.
> > > 
> > > But what are you seeing as actively harmful about all of this?
> > > What should we be doing instead?
> > 
> > Yeah, so basically in the write-locked path hlist_for_each_entry() 
> > generates (slightly) more efficient code than hlist_for_each_entry_rcu(), 
> > correct?
> 
> Potentially yes, if the READ_ONCE() constrains the compiler.  Or not,
> depending of course on the compiler and the surrounding code.

For this kprobes case, I can introduce get_kprobe_locked() which uses
 hlist_for_each_entry() instead of hlist_for_each_entry_rcu().

However, this sounds like a bit strange choice, because get_kprobe
(RCU version) should be used on "hot" paths (because it is lock-free),
and get_kprobe_locked() is used on slow paths.
If hlist_for_each_entry() can be more efficient, we will keep unefficient
API for hot paths, but use the efficient one for slow paths.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
