Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40467148C29
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 17:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgAXQb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 11:31:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgAXQb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:31:59 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F0E620704;
        Fri, 24 Jan 2020 16:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579883518;
        bh=T30SbOKAVRrOSFOKA806InKz9B0prg0FQYuGuNv8ZKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W6JUzXn3N5SdTHeQUr8cLi1l/qYUUMKTW/0eGhSmljNNq4nd3CMGTHNbkAm6Ko44w
         hF/4wYaCLLCZNLF17IdRojXZoRMB4kgkCOZtttMeFLcVAF0Nr9xBe3McaEApUxJJko
         H9KqrUJrqpAt2q25AyBsnUX04zsvR66wo7EgX1mY=
Date:   Sat, 25 Jan 2020 01:31:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, mhiramat@kernel.org, borntraeger@de.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent
 issue)
Message-Id: <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
In-Reply-To: <20200124100742.4050c15e@gandalf.local.home>
References: <20200124073941.39119-1-tmricht@linux.ibm.com>
        <20200124100742.4050c15e@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven and Thomas,

On Fri, 24 Jan 2020 10:07:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> This looks like a kernel bug, not a libtraceevent parsing bug.

Totally agreed. It was my fault to update the print format.
Even if still there is a problem on s390, this patch must be
applied.

Fixes: 88903c464321 ("tracing/probe: Add ustring type for user-space string")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> 
> > +		}
> >  		str = malloc(len + 1);
> >  		if (!str) {
> >  			do_warning_event(event, "%s: not enough memory!",
> 
> Does this patch fix it for you?
> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 905b10af5d5c..d3309fceb480 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -876,7 +876,8 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
>  	for (i = 0; i < tp->nr_args; i++) {
>  		parg = tp->args + i;
>  		if (parg->count) {
> -			if (strcmp(parg->type->name, "string") == 0)
> +			if ((strcmp(parg->type->name, "string") == 0) ||
> +			    (strcmp(parg->type->name, "ustring") == 0))
>  				fmt = ", __get_str(%s[%d])";
>  			else
>  				fmt = ", REC->%s[%d]";
> @@ -884,7 +885,8 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
>  				pos += snprintf(buf + pos, LEN_OR_ZERO,
>  						fmt, parg->name, j);
>  		} else {
> -			if (strcmp(parg->type->name, "string") == 0)
> +			if ((strcmp(parg->type->name, "string") == 0) ||
> +			    (strcmp(parg->type->name, "ustring") == 0))
>  				fmt = ", __get_str(%s)";
>  			else
>  				fmt = ", REC->%s";


Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
