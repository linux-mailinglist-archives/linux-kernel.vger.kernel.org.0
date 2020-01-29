Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED42D14CFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 18:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgA2RxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 12:53:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbgA2Rw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:52:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08BB20716;
        Wed, 29 Jan 2020 17:52:56 +0000 (UTC)
Date:   Wed, 29 Jan 2020 12:52:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH v3 02/12] tracing: Add trace_get/put_event_file()
Message-ID: <20200129125255.57159f85@gandalf.local.home>
In-Reply-To: <ec82da7de7689bdebbb447c83d9182c05efb0ba6.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
        <ec82da7de7689bdebbb447c83d9182c05efb0ba6.1579904761.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 16:56:13 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> +/**
> + * trace_put_event_file - Release a file from trace_get_event_file()
> + * @file: The trace event file
> + *
> + * If a file was retrieved using trace_get_event_file(), this should
> + * be called when it's no longer needed.  It will cancel the previous
> + * trace_array_get() called by that function, and decrement the
> + * event's module refcount.
> + */
> +void trace_put_event_file(struct trace_event_file *file)
> +{
> +	trace_array_put(file->tr);
> +
> +	mutex_lock(&event_mutex);
> +	module_put(file->event_call->mod);
> +	mutex_unlock(&event_mutex);

I believe the trace_array_put() needs to be at the end. Otherwise, I
believe the file could be freed before the event_mutex is taken.

I'll swap it, as I'm trying to get this into the merge window.

-- Steve

> +}
> +EXPORT_SYMBOL_GPL(trace_put_event_file);
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  
>  /* Avoid typos */

