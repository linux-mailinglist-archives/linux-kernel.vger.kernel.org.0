Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 265365CC14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfGBIft convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Jul 2019 04:35:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44033 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfGBIft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:35:49 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hiEGG-0002yj-OP; Tue, 02 Jul 2019 10:35:36 +0200
Date:   Tue, 2 Jul 2019 10:35:36 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Corey Minyard <cminyard@mvista.com>,
        Corey Minyard <minyard@acm.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190702083536.vt346ysqmq6q23iz@linutronix.de>
References: <20190509193320.21105-1-minyard@acm.org>
 <20190510103318.6cieoifz27eph4n5@linutronix.de>
 <20190628214903.6f92a9ea@oasis.local.home>
 <20190701190949.GB4336@minyard.net>
 <20190701161840.1a53c9e4@gandalf.local.home>
 <20190701204325.GD5041@minyard.net>
 <20190701170602.2fdb35c2@gandalf.local.home>
 <20190701171333.37cc0567@gandalf.local.home>
 <20190701172825.7d861e85@gandalf.local.home>
 <20190702070418.h6ynkkgk6v6s3aii@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190702070418.h6ynkkgk6v6s3aii@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-02 09:04:18 [+0200], Kurt Kanzenbach wrote:
> > In fact, my system doesn't boot with this commit in 5.0-rt.
> >
> > If I revert 90e1b18eba2ae4a729 ("swait: Delete the task from after a
> > wakeup occured") the machine boots again.
> >
> > Sebastian, I think that's a bad commit, please revert it.
> 
> I'm having the same problem on a Cyclone V based ARM board. Reverting
> this commit solves the boot issue for me as well.

Okay. So the original Corey fix as in v5.0.14-rt9 works for everyone.
Peter's version as I picked it up for v5.0.21-rt14 is causing problems
for two persons now.

I'm leaning towards reverting it back to old version for now…

> Thanks,
> Kurt

Sebastian
