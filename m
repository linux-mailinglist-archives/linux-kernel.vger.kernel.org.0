Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD0F160EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 10:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgBQJdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 04:33:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbgBQJdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:33:44 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 516AF20679;
        Mon, 17 Feb 2020 09:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581932024;
        bh=Hva1VYTaIHTinRbcAfWrHrtqtw1QHqKCZCklauDBsBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KVCfI1p92V+a5wkQ6qbcBjhOl+fBTlbHuw5LKN+Wi6VfGjdJoZGNZWtPu6ZlEHgdQ
         L/6c2PFz0aqK0k7FrFbBcdIwRogvEZyMbGE/CaisaRZXyyQvqi1hGdzRLYCzKfJL93
         mzMz9gu/1RgTFuU16LAFV3pwjaAZBvPGqzbyrGSw=
Date:   Mon, 17 Feb 2020 18:33:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <zanussi@kernel.org>,
        artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] tracing: Skip software disabled event at
 __synth_event_trace_end()
Message-Id: <20200217183340.121fed47e680584c4ca6dd93@kernel.org>
In-Reply-To: <158148685911.20407.3538292497442671878.stgit@devnote2>
References: <158148685911.20407.3538292497442671878.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 14:54:19 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> When the synthetic event is software disabled,
> __synth_event_trace_start() does not allocate an event buffer.
> In this case __synth_event_trace_end() also should not commit
> the buffer.
> 
> Check the trace_state->disabled at __synth_event_trace_end()
> and if it is disabled, skip it.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_events_hist.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 483b3fd1094f..781e4b55e117 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1847,6 +1847,9 @@ __synth_event_trace_start(struct trace_event_file *file,
>  static inline void
>  __synth_event_trace_end(struct synth_event_trace_state *trace_state)
>  {
> +	if (trace_state->disabled)
> +		return;
> +

Aah, I assumed that trace_state should be initialized with 0, but
in really, it could be just allocated on the stack.
We has to set trace_state->disabled = false in __synth_event_trace_start().

Thank you,

>  	trace_event_buffer_commit(&trace_state->fbuffer);
>  
>  	ring_buffer_nest_end(trace_state->buffer);
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
