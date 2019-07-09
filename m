Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DED363635
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 14:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfGIMv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 08:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfGIMv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:51:29 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC70B21707;
        Tue,  9 Jul 2019 12:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562676688;
        bh=Wvi5s3WedjqogbAaNrsX5TXkPhLeMsvF5uGn/Uxzsh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bmqEUr9FMEgK8+zus9QgRNDCy93aL8OTIYxXlb0UfCR6NSUTRs4zdUA60wBy/3Gwz
         9AUUKgm0xofbU+KyMZXtDsCFJ8Z/GsR0kawkhq1Kmbp5HO+vH76+fqbanZGMhlxtSq
         VJIAAPKxS2WhSzdDde7GkTJtq/BxKqWDk0eFlBM4=
Date:   Tue, 9 Jul 2019 21:51:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 12/16] kprobes: Initialize kprobes at
 postcore_initcall
Message-Id: <20190709215124.979ef648aabbae2fc0cd91d3@kernel.org>
In-Reply-To: <20190703102504.13344555@gandalf.local.home>
References: <20190526191828.466305460@goodmis.org>
        <20190526191848.266163206@goodmis.org>
        <20190702165008.GC34718@lakrids.cambridge.arm.com>
        <20190703100205.0b58f3bf@gandalf.local.home>
        <20190703140832.GD48312@arrakis.emea.arm.com>
        <20190703102402.1319b928@gandalf.local.home>
        <20190703102504.13344555@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 10:25:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 3 Jul 2019 10:24:02 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 3 Jul 2019 15:08:32 +0100
> > Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > 
> > > > +static int __init run_init_test_probes(void)
> > > > +{
> > > > +	if (run_kprobe_tests)
> > > > +		init_test_probes();    
> > > 
> > > A return 0 here.  
> > 
> > Will update (would have triggered a failure on my test suite anyway ;-)
> > 
> > >   
> > > > +}
> > > > +module_init(run_init_test_probes);    
> > > 
> > > This does the trick. I prefer your fix as it leaves the arch code
> > > unchanged. In case you need it:
> > > 
> > > Tested-by: Catalin Marinas <catalin.marinas@arm.com>
> > >   
> >
> 
> Masami,
> 
> If you give me an Acked-by, I'll add it to my tree.

Sorry for late reply, but I want to keep the test running right after
initialization as the first user of kprobes at that timing, since
other user can start using kprobes right after init_kprobes().
So this issue must be fixed in moving the init_kprobes() itself
right after arch_initcall() (and that is subsys_initcall)

Catalin, Mark, could you ensure the below patch can fix your issue?

https://lore.kernel.org/lkml/20190625191545.245259106@goodmis.org/

And if so, Steve, could you push above one (which seems already in your
tree) to next as a fix?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
