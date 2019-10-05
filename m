Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0D9CCAFE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 18:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfJEQK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 12:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729081AbfJEQK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:10:57 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 545AF222C0;
        Sat,  5 Oct 2019 16:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570291856;
        bh=WXNltNNWDTjVjLox2ShheQ4T2u/cba37UPIwcEQB5pA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=reL/miNeY8vHXFnVf3Dyl/cPcyVVc1HFr56p6dVX2qXPTtjWaliyVdCeOS5GUX5em
         U+ai/lY5hnHfEf2fNZT9iDRHFAtVinp4+Eh74c97WWMHtLvhUiuq1fcx6iDACwDOA0
         3RLFVrTmA2J6NO56yF10+TsyQb/XmHUzpYQS7mT8=
Date:   Sat, 5 Oct 2019 09:10:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH tip/core/rcu 5/9] fs/afs: Replace rcu_swap_protected()
 with rcu_replace()
Message-ID: <20191005161055.GE2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191003014310.13262-5-paulmck@kernel.org>
 <20191003014153.GA13156@paulmck-ThinkPad-P72>
 <25322.1570091894@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25322.1570091894@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 09:38:14AM +0100, David Howells wrote:
> paulmck@kernel.org wrote:
> 
> > This commit replaces the use of rcu_swap_protected() with the more
> > intuitively appealing rcu_replace() as a step towards removing
> > rcu_swap_protected().
> 
> Yay!
> 
> > Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: <linux-afs@lists.infradead.org>
> > Cc: <linux-kernel@vger.kernel.org>
> 
> Acked-by: David Howells <dhowells@redhat.com>

Applied, thank you David!

							Thanx, Paul
