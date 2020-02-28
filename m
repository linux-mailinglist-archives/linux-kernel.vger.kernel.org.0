Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 418D2173B11
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 16:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgB1PLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 10:11:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgB1PLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:11:21 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0BD224699;
        Fri, 28 Feb 2020 15:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582902680;
        bh=FL56FfxPEHq8DH15fr9hQdoUBI4/bSb/FIPDDMqUk7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nSVYnNnVenc0MDCIh5bg5BGH26klmPDL1c4A5fQHNztk9uxx3sL7zTJlFgnd8+A1u
         V0nV6nSxZHENLUGYm7lmvrH7rcdVzvLcYhpJU1hSoGj7C7xzHMq6WI9Gp47/7fLy1i
         jBkhH/Dm8loMA/YMDIR8Hsu6YIS26LptcLaerDO8=
Date:   Sat, 29 Feb 2020 00:11:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 04/13] kprobes: Add perf ksymbol events for kprobe
 insn pages
Message-Id: <20200229001114.91f010e8683418b0dc133837@kernel.org>
In-Reply-To: <20200228135125.567-5-adrian.hunter@intel.com>
References: <20200228135125.567-1-adrian.hunter@intel.com>
        <20200228135125.567-5-adrian.hunter@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 15:51:16 +0200
Adrian Hunter <adrian.hunter@intel.com> wrote:

> Symbols are needed for tools to describe instruction addresses. Pages
> allocated for kprobe's purposes need symbols to be created for them.
> Add such symbols to be visible via perf ksymbol events.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  include/uapi/linux/perf_event.h |  5 +++++
>  kernel/kprobes.c                | 12 ++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index bae9e9d2d897..9b38ac04c110 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1031,6 +1031,11 @@ enum perf_event_type {
>  enum perf_record_ksymbol_type {
>  	PERF_RECORD_KSYMBOL_TYPE_UNKNOWN	= 0,
>  	PERF_RECORD_KSYMBOL_TYPE_BPF		= 1,
> +	/*
> +	 * Out of line code such as kprobe-replaced instructions or optimized
> +	 * kprobes.
> +	 */
> +	PERF_RECORD_KSYMBOL_TYPE_OOL		= 2,
>  	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
>  };
>  
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 229d1b596690..f880eb2189c0 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -35,6 +35,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/cpu.h>
>  #include <linux/jump_label.h>
> +#include <linux/perf_event.h>
>  
>  #include <asm/sections.h>
>  #include <asm/cacheflush.h>
> @@ -184,6 +185,10 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
>  	kip->cache = c;
>  	list_add_rcu(&kip->list, &c->pages);
>  	slot = kip->insns;
> +
> +	/* Record the perf ksymbol register event after adding the page */
> +	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL, (u64)kip->insns,
> +			   PAGE_SIZE, false, c->sym);
>  out:
>  	mutex_unlock(&c->mutex);
>  	return slot;
> @@ -202,6 +207,13 @@ static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
>  		 * next time somebody inserts a probe.
>  		 */
>  		if (!list_is_singular(&kip->list)) {
> +			/*
> +			 * Record perf ksymbol unregister event before removing
> +			 * the page.
> +			 */
> +			perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
> +					   (u64)kip->insns, PAGE_SIZE, true,
> +					   kip->cache->sym);
>  			list_del_rcu(&kip->list);
>  			synchronize_rcu();

If you think this event should happen after unused the page,
here is the best position to do that.

Thank you,

>  			kip->cache->free(kip->insns);
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
