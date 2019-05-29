Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50EEE2D901
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 11:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfE2JZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 05:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfE2JZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:25:26 -0400
Received: from oasis.local.home (rrcs-24-39-165-138.nys.biz.rr.com [24.39.165.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1042320B1F;
        Wed, 29 May 2019 09:25:23 +0000 (UTC)
Date:   Wed, 29 May 2019 05:25:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20190529052521.6623ae7b@oasis.local.home>
In-Reply-To: <20190529154740.016517ff9225680f64961097@kernel.org>
References: <20190520142001.270067280@goodmis.org>
        <20190522231955.72899b0d606adb919e8716ff@kernel.org>
        <20190522104027.1b2aabd8@gandalf.local.home>
        <20190529154740.016517ff9225680f64961097@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 15:47:40 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> Hi Steve,
> 
> I found that these interfaces seem tightly coupled with fgraph_ops. But that
> cause a problem when I'm using it from kretprobe.

I was thinking that the kretprobes could use the fgraph_ops like
kprobes uses ftrace_ops.

> 
> kretprobe has 2 handlers, entry handler and return handler, and both need
> pt_regs. But fgraph_ops's entryfunc and retfunc do not pass the pt_regs.
> That is the biggest issue for me on these APIs.
> Can we expand fgraph_ops with regs parameter?

Ug. Yeah, of course you need that :-/

OK, so this series isn't enough to allow kretprobes to use it yet. OK,
I plan on still keeping it because it does allow for placing function
graph tracer into instances with their own filters.

I'll look into adding a REGS flag like we do with ftrace_ops.

Does the return need all regs? Or is just the return code good enough?

-- Steve

