Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBAA415AC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 17:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBLQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 11:03:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLQD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:03:27 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A19D42082F;
        Wed, 12 Feb 2020 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581523407;
        bh=GgQY7ZaZhtEOuvcoDyLDV8sSYVstp3cSHDoUNqYh8F8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J32RPReRl5bmptQJigmJxVdzaw6zo6EvozBcNpH9ydCsdv7VK7N1216VAs9StTW9t
         hFjeCBiRoEr696NXGpbTPGAwZK0Wl2Tcx5d/7HnYEva6jqMNGHgaNdKgRJRomfUfZQ
         Qh9E1ZEWvR1j2kzV2XoNLfPNxUrZ0d62i5Qw20A8=
Message-ID: <1581523405.8740.10.camel@kernel.org>
Subject: Re: [PATCH] tracing: Skip software disabled event at
 __synth_event_trace_end()
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 12 Feb 2020 10:03:25 -0600
In-Reply-To: <158148685911.20407.3538292497442671878.stgit@devnote2>
References: <158148685911.20407.3538292497442671878.stgit@devnote2>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

You're right, this is a bug, thanks for sending the patch to fix it.

Tom

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


On Wed, 2020-02-12 at 14:54 +0900, Masami Hiramatsu wrote:
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
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index 483b3fd1094f..781e4b55e117 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1847,6 +1847,9 @@ __synth_event_trace_start(struct
> trace_event_file *file,
>  static inline void
>  __synth_event_trace_end(struct synth_event_trace_state *trace_state)
>  {
> +	if (trace_state->disabled)
> +		return;
> +
>  	trace_event_buffer_commit(&trace_state->fbuffer);
>  
>  	ring_buffer_nest_end(trace_state->buffer);
> 
