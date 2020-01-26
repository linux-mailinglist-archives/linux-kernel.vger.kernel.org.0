Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1202149CDE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 21:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgAZUkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 15:40:02 -0500
Received: from smtprelay0186.hostedemail.com ([216.40.44.186]:44314 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgAZUkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 15:40:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 872C818029128;
        Sun, 26 Jan 2020 20:40:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:2:41:355:379:599:800:960:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1606:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:2899:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3874:4117:4321:4385:5007:6119:7576:8603:9040:10004:10848:11026:11232:11473:11658:11914:12043:12294:12296:12297:12438:12555:12740:12760:12895:12986:13255:13439:14093:14097:14659:21080:21325:21451:21627:21990:30012:30029:30034:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sign60_1d0aeddd8281f
X-Filterd-Recvd-Size: 6260
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Jan 2020 20:39:59 +0000 (UTC)
Message-ID: <e70ff75e9712478704fad44ac6b66c86a45df6a6.camel@perches.com>
Subject: Re: [for-next][PATCH 7/7] tracing: Use pr_err() instead of WARN()
 for memory failures
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 26 Jan 2020 12:38:55 -0800
In-Reply-To: <20200126192021.350763989@goodmis.org>
References: <20200126191932.984391723@goodmis.org>
         <20200126192021.350763989@goodmis.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-01-26 at 14:19 -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> As warnings can trigger panics, especially when "panic_on_warn" is set,
> memory failure warnings can cause panics and fail fuzz testers that are
> stressing memory.
> 
> Create a MEM_FAIL() macro to use instead of WARN() in the tracing code
> (perhaps this should be a kernel wide macro?), and use that for memory
> failure issues. This should stop failing fuzz tests due to warnings.

It looks as if most of these could just be removed instead
as there is an existing dump_stack() on failure.

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
[]
> @@ -5459,7 +5459,7 @@ static void __init set_ftrace_early_graph(char *buf, int enable)
>  	struct ftrace_hash *hash;
>  
>  	hash = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> -	if (WARN_ON(!hash))
> +	if (MEM_FAIL(!hash, "Failed to allocate hash\n"))
>  		return;

has dump_stack()
 
>  	while (buf) {
> @@ -6591,7 +6591,7 @@ static void add_to_clear_hash_list(struct list_head *clear_list,
>  
>  	func = kmalloc(sizeof(*func), GFP_KERNEL);
>  	if (!func) {
> -		WARN_ONCE(1, "alloc failure, ftrace filter could be stale\n");
> +		MEM_FAIL(1, "alloc failure, ftrace filter could be stale\n");

has dump_stack()

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
[]
> @@ -3126,7 +3126,7 @@ static int alloc_percpu_trace_buffer(void)
>  	struct trace_buffer_struct *buffers;
>  
>  	buffers = alloc_percpu(struct trace_buffer_struct);
> -	if (WARN(!buffers, "Could not allocate percpu trace_printk buffer"))
> +	if (MEM_FAIL(!buffers, "Could not allocate percpu trace_printk buffer"))
>  		return -ENOMEM;

has dump_stack()

>  
>  	trace_percpu_buffer = buffers;
> @@ -7932,7 +7932,7 @@ static struct dentry *tracing_dentry_percpu(struct trace_array *tr, int cpu)
>  
>  	tr->percpu_dir = tracefs_create_dir("per_cpu", d_tracer);
>  
> -	WARN_ONCE(!tr->percpu_dir,
> +	MEM_FAIL(!tr->percpu_dir,
>  		  "Could not create tracefs directory 'per_cpu/%d'\n", cpu);

keep?
 
>  	return tr->percpu_dir;
> @@ -8253,7 +8253,7 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
>  	for (cnt = 0; opts[cnt].name; cnt++) {
>  		create_trace_option_file(tr, &topts[cnt], flags,
>  					 &opts[cnt]);
> -		WARN_ONCE(topts[cnt].entry == NULL,
> +		MEM_FAIL(topts[cnt].entry == NULL,
>  			  "Failed to create trace option: %s",
>  			  opts[cnt].name);
>  	}
> @@ -8437,7 +8437,7 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
>  #ifdef CONFIG_TRACER_MAX_TRACE
>  	ret = allocate_trace_buffer(tr, &tr->max_buffer,
>  				    allocate_snapshot ? size : 1);
> -	if (WARN_ON(ret)) {
> +	if (MEM_FAIL(ret, "Failed to allocate trace buffer\n")) {
>  		ring_buffer_free(tr->array_buffer.buffer);
>  		tr->array_buffer.buffer = NULL;
>  		free_percpu(tr->array_buffer.data);
> @@ -8726,7 +8726,7 @@ static __init void create_trace_instances(struct dentry *d_tracer)
>  	trace_instance_dir = tracefs_create_instance_dir("instances", d_tracer,
>  							 instance_mkdir,
>  							 instance_rmdir);
> -	if (WARN_ON(!trace_instance_dir))
> +	if (MEM_FAIL(!trace_instance_dir, "Failed to create instances directory\n"))
>  		return;
>  }
>  
> @@ -8796,7 +8796,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  #endif
>  
>  	if (ftrace_create_function_files(tr, d_tracer))
> -		WARN(1, "Could not allocate function filter files");
> +		MEM_FAIL(1, "Could not allocate function filter files");
>  
>  #ifdef CONFIG_TRACER_SNAPSHOT
>  	trace_create_file("snapshot", 0644, d_tracer,
> @@ -9348,8 +9348,7 @@ __init static int tracer_alloc_buffers(void)
>  
>  	/* TODO: make the number of buffers hot pluggable with CPUS */
>  	if (allocate_trace_buffers(&global_trace, ring_buf_size) < 0) {
> -		printk(KERN_ERR "tracer: failed to allocate ring buffer!\n");
> -		WARN_ON(1);
> +		MEM_FAIL(1, "tracer: failed to allocate ring buffer!\n");

has dump_stack()

>  		goto out_free_savedcmd;
>  	}
>  
> @@ -9422,7 +9421,8 @@ void __init early_trace_init(void)
>  	if (tracepoint_printk) {
>  		tracepoint_print_iter =
>  			kmalloc(sizeof(*tracepoint_print_iter), GFP_KERNEL);
> -		if (WARN_ON(!tracepoint_print_iter))
> +		if (MEM_FAIL(!tracepoint_print_iter,
> +			     "Failed to allocate trace iterator\n"))

has dump_stack()

>  			tracepoint_printk = 0;
>  		else
>  			static_key_enable(&tracepoint_printk_key.key);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 4812a36affac..6bb64d89c321 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -94,6 +94,18 @@ enum trace_type {
>  
>  #include "trace_entries.h"
>  
> +/* Use this for memory failure errors */
> +#define MEM_FAIL(condition, fmt, ...) ({			\
> +	static bool __section(.data.once) __warned;		\
> +	int __ret_warn_once = !!(condition);			\
> +								\
> +	if (unlikely(__ret_warn_once && !__warned)) {		\
> +		__warned = true;				\
> +		pr_err("ERROR: " fmt, ##__VA_ARGS__);		\
> +	}							\
> +	unlikely(__ret_warn_once);				\
> +})
> +
>  /*
>   * syscalls are special, and need special handling, this is why
>   * they are not included in trace_entries.h

