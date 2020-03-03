Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB76517747B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 11:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgCCKrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 05:47:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbgCCKrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:47:05 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2350E20637;
        Tue,  3 Mar 2020 10:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583232425;
        bh=7n/Rf8JqcQS1JpijhNzF28rBSFA8a0NvojUZvKIQ24k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B1re0zzoQUpSaSE3eSHY4t/rrebhCaAFzP6mRfhvwKGJfeR/vLa7F3nrNKaKrltov
         rJOF7Wak5ZMKpA2oc2QxJetrmB2JOZAkOmDtd/ROriAbG0CU3G+VVcYbSOoR0t4nrJ
         Oy1PJFZe+o1fXtF47ohscrWC6dSTkqI+gBUKyma4=
Date:   Tue, 3 Mar 2020 19:47:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [OT] Pseudo module name in kallsyms (Re: [PATCH V3 03/13] kprobes:
 Add symbols for kprobe insn pages)
Message-Id: <20200303194700.5810cbaf49bc6eacdffa7fa4@kernel.org>
In-Reply-To: <20200302144307.GD204976@krava>
References: <20200228135125.567-1-adrian.hunter@intel.com>
        <20200228135125.567-4-adrian.hunter@intel.com>
        <20200228233600.5f5c733584eac08b8a4a2b70@kernel.org>
        <20200228172004.GI5451@krava>
        <20200229134947.839096dbc8321cfdca980edb@kernel.org>
        <20200229184913.4e13e516@oasis.local.home>
        <20200302144307.GD204976@krava>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2 Mar 2020 15:43:07 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> On Sat, Feb 29, 2020 at 06:49:13PM -0500, Steven Rostedt wrote:
> > On Sat, 29 Feb 2020 13:49:47 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > On Fri, 28 Feb 2020 18:20:04 +0100
> > > Jiri Olsa <jolsa@redhat.com> wrote:
> > > 
> > > > > BTW, it seems to pretend to be a module, but is there no concern of
> > > > > confusing users? Shouldn't it be [*kprobes] so that it is non-exist
> > > > > module name?  
> > > > 
> > > > note we already have bpf symbols as [bpf] module  
> > > 
> > > Yeah, and this series adds [kprobe(s)] and [ftrace] too.
> > > I simply concern that the those module names implicitly become
> > > special word (rule) and embedded in the code. If such module names
> > > are not exposed to users, it is OK (but I hope to have some comments).
> > > However, it is under /proc, which means users can notice it.
> > 
> > I share Masami's concerns. It would be good to have something
> > differentiate local functions that are not modules. That's one way I
> > look to see if something is a module or built in, is to see if kallsyms
> > has it as a [].
> > 
> > Perhaps prepend with: '&' ?

Yeah, '*' may not good from the filename point of view.

> 
> that would break some of the perf code.. IMO Arnaldo's explanation
> makes sense and we could keep it as it is

 From the in-kernel API/coding point of view,

+static int get_ksymbol_kprobe(struct kallsym_iter *iter)
+{
+	strlcpy(iter->module_name, "kprobe", MODULE_NAME_LEN);
+	iter->exported = 0;
+	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
+				  &iter->value, &iter->type,
+				  iter->name) < 0 ? 0 : 1;
 }

This clearly shows that is a iter->module_name.

And also, if someone make a module names "kprobes.ko", it will also
have [kprobes] in kallsyms. That is also confusing.


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
