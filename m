Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC72143F49
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 15:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAUOTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 09:19:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbgAUOTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:19:24 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 763F02087E;
        Tue, 21 Jan 2020 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579616363;
        bh=es0Pkse8eWBu3dyEGSJg1DKtzsKELcYDoDjvA1HrvEQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nbjIT4sZsmS+T8V62ilhv/+lAGTFFopFhVNCnDbCqRyXhl4WNu4tJIn2XIyM2wdsa
         nNm5l+Q/SBYhrKGlAIfTAQ1sJqrMWta73pJNkZEAnyJu08JaAbrzuOUiaBS4Jv1zct
         2CGK4vUS6EAaH7OlP9WeVdJorUdx35Zn7/WlWuKc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4A76035227E4; Tue, 21 Jan 2020 06:19:23 -0800 (PST)
Date:   Tue, 21 Jan 2020 06:19:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Boot warning at rcu_check_gp_start_stall()
Message-ID: <20200121141923.GP2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200121050941.GO2935@paulmck-ThinkPad-P72>
 <D7FEEB19-B519-4AC6-ABA4-250200E2A4E9@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7FEEB19-B519-4AC6-ABA4-250200E2A4E9@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 06:45:32AM -0500, Qian Cai wrote:
> 
> 
> > On Jan 21, 2020, at 12:09 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > This is what you get when a grace period has been requested, but does
> > not start within 21 seconds or so.  The "->state: 0x1ffff" is a new one
> > on me -- that normally happens only before RCU's grace-period kthread
> > has been spawned.  But by 97 seconds after boot, it should definitely
> > already be up and running.
> > 
> > Is the system responsive at this point?
> 
> Yes, it works fine.
> 
> > Except...  Why is it taking 96 seconds for the system to get to the point
> > where it prints "Dentry cache hash table entries:"?  That happens at 0.139
> > seconds on my laptop.  And at about the same time on a much larger system.
> > 
> > I could easily imagine that all sorts of things would break when boot
> > takes that long.
> 
> I suppose the kernel has CONFIG_EFI_PGT_DUMP=y, so it takes a while to run just before rcu_check_gp_start_stall().

New one on me!

One approach would be to boot with rcupdate.rcu_cpu_stall_timeout=300,
which would allow more time.

Longer term, I could suppress this warning during boot when
CONFIG_EFI_PGT_DUMP=y, but that sounds quite specific.  Alternatively,
I could provide a Kconfig option that suppressed this during boot
that was selected by whatever long-running boot-time Kconfig option
needed it.  Yet another approach would be for long-running operations
like efi_dump_pagetable() to suppress stalls on entry and re-enable them
upon exit.

Thoughts?

							Thanx, Paul
