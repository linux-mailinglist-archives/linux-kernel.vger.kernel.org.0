Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3171159F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 04:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgBLDYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 22:24:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbgBLDYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:24:17 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FBCD2082F;
        Wed, 12 Feb 2020 03:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581477857;
        bh=mBWVEBG2jTxD+zdNGdiJ9jwLnAWUmNwN96Qt1ATXxMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2Z/nr1hJvBKn/UFlGu1nNbTvndgpqmllyLnspyObsXgwGY2DHe8+QUbeY9EBXx8aA
         axXIYMlFHBP29/zapP+8/mdMqyskSX4SaPos79xOdGPPFbQalPAfi2F4dHl7CvByyr
         aYV4I1UCO8w2joypRL/08/YUwIibZ0ohJwIzA40I=
Date:   Wed, 12 Feb 2020 12:24:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/3] tracing: Add missing nest end to
 synth_event_trace_start() error case
Message-Id: <20200212122412.9666e6fd30c8d5d48ea5a2d8@kernel.org>
In-Reply-To: <20abc444b3eeff76425f895815380abe7aa53ff8.1581374549.git.zanussi@kernel.org>
References: <cover.1581374549.git.zanussi@kernel.org>
        <20abc444b3eeff76425f895815380abe7aa53ff8.1581374549.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 17:06:48 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> If the ring_buffer reserve in synth_event_trace_start() fails, the
> matching ring_buffer_nest_end() should be called in the error code,
> since nothing else will ever call it in this case.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace_events_hist.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index b3bcfd8c7332..a546ffa14785 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -2043,6 +2043,7 @@ int synth_event_trace_start(struct trace_event_file *file,
>  	entry = trace_event_buffer_reserve(&trace_state->fbuffer, file,
>  					   sizeof(*entry) + fields_size);
>  	if (!entry) {
> +		ring_buffer_nest_end(trace_state->buffer);
>  		ret = -EINVAL;
>  		goto out;
>  	}
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
