Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38FA3A260
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 00:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfFHW1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 18:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfFHW1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 18:27:24 -0400
Received: from oasis.local.home (unknown [12.156.218.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F6EF214C6;
        Sat,  8 Jun 2019 21:51:44 +0000 (UTC)
Date:   Sat, 8 Jun 2019 17:51:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: Re: [PATCH 3/3] tracing: Add 2 new funcs. for kernel access to
 Ftrace instances.
Message-ID: <20190608175142.1a4444a4@oasis.local.home>
In-Reply-To: <1559695325-17155-4-git-send-email-divya.indi@oracle.com>
References: <1559695325-17155-1-git-send-email-divya.indi@oracle.com>
        <1559695325-17155-2-git-send-email-divya.indi@oracle.com>
        <1559695325-17155-3-git-send-email-divya.indi@oracle.com>
        <1559695325-17155-4-git-send-email-divya.indi@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Jun 2019 17:42:05 -0700
Divya Indi <divya.indi@oracle.com> wrote:

> Adding 2 new functions -
> 1) trace_array_lookup : Look up and return a trace array, given its
> name.
> 2) trace_array_set_clr_event : Enable/disable event recording to the
> given trace array.
> 
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> ---
>  include/linux/trace_events.h |  3 +++
>  kernel/trace/trace.c         | 11 +++++++++++
>  kernel/trace/trace_events.c  | 22 ++++++++++++++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index d7b7d85..0cc99a8 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -545,7 +545,10 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
>  struct trace_array *trace_array_create(const char *name);
>  int trace_array_destroy(struct trace_array *tr);
>  int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
> +struct trace_array *trace_array_lookup(const char *name);
>  int trace_set_clr_event(const char *system, const char *event, int set);
> +int trace_array_set_clr_event(struct trace_array *tr, const char *system,
> +		const char *event, int set);
>  
>  /*
>   * The double __builtin_constant_p is because gcc will give us an error
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a60dc13..1d171fd 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8465,6 +8465,17 @@ static int instance_rmdir(const char *name)
>  	return ret;
>  }
>  
> +struct trace_array *trace_array_lookup(const char *name)
> +{
> +	struct trace_array *tr;
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {

Accessing the ftrace_trace_arrays requires taking the trace_types_lock.
It should also probably increment the ref counter too, and then
trace_array_put() needs to be called.

This prevents the trace array from being freed while something has
access to it.

-- Steve


> +		if (tr->name && strcmp(tr->name, name) == 0)
> +			return tr;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(trace_array_lookup);
> +
>  static __init void create_trace_instances(struct dentry *d_tracer)
>  {
>  	trace_instance_dir = tracefs_create_instance_dir("instances", d_tracer,
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 445b059..c126d2c 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -859,6 +859,28 @@ int trace_set_clr_event(const char *system, const char *event, int set)
>  }
>  EXPORT_SYMBOL_GPL(trace_set_clr_event);
>  
> +/**
> + * trace_array_set_clr_event - enable or disable an event for a trace array
> + * @system: system name to match (NULL for any system)
> + * @event: event name to match (NULL for all events, within system)
> + * @set: 1 to enable, 0 to disable
> + *
> + * This is a way for other parts of the kernel to enable or disable
> + * event recording to instances.
> + *
> + * Returns 0 on success, -EINVAL if the parameters do not match any
> + * registered events.
> + */
> +int trace_array_set_clr_event(struct trace_array *tr, const char *system,
> +		const char *event, int set)
> +{
> +	if (!tr)
> +		return -ENODEV;
> +
> +	return __ftrace_set_clr_event(tr, NULL, system, event, set);
> +}
> +EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
> +
>  /* 128 should be much more than enough */
>  #define EVENT_BUF_SIZE		127
>  

