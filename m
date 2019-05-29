Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96782D5B0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 08:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfE2Grr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 02:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfE2Grq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 02:47:46 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B5621670;
        Wed, 29 May 2019 06:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559112465;
        bh=xY1iAw/2N4nKPDxFqUZ+osggFL15pR2wiUbf/oD2RJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w+twq5wTNZfl465wcH4n7a5RMmightjumKr9p8BTphVOKp9KUxlJgWOXG/gDiayIf
         ZlKk8OU+2oZat/FweumICAtZTk3F6og/XJlgpovEvLTGoCSf9t0duNxsWgH2qHZ3i7
         xzetlptWYSWG0g3Km8R4pndBXghTAxZ08x/ZZ3WU=
Date:   Wed, 29 May 2019 15:47:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC][PATCH 00/14 v2] function_graph: Rewrite to allow multiple
 users
Message-Id: <20190529154740.016517ff9225680f64961097@kernel.org>
In-Reply-To: <20190522104027.1b2aabd8@gandalf.local.home>
References: <20190520142001.270067280@goodmis.org>
        <20190522231955.72899b0d606adb919e8716ff@kernel.org>
        <20190522104027.1b2aabd8@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 10:40:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 22 May 2019 23:19:55 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > >  void *fgraph_reserve_data(int size_in_bytes)
> > > 
> > >     Allows the entry function to reserve up to 4 words of data on
> > >     the shadow stack. On success, a pointer to the contents is returned.
> > >     This may be only called once per entry function.
> > > 
> > >  void *fgraph_retrieve_data(void)
> > > 
> > >     Allows the return function to retrieve the reserved data that was
> > >     allocated by the entry function.  
> > 
> > Nice! this seems good for kretprobe too. I'll review and try to port
> > kretprobe on this framework.
> 
> If you rather pull from my git repo and not download all the patches,
> they are currently available in my ftrace/fgraph-multi branch.

Hi Steve,

I found that these interfaces seem tightly coupled with fgraph_ops. But that
cause a problem when I'm using it from kretprobe.

kretprobe has 2 handlers, entry handler and return handler, and both need
pt_regs. But fgraph_ops's entryfunc and retfunc do not pass the pt_regs.
That is the biggest issue for me on these APIs.
Can we expand fgraph_ops with regs parameter?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
