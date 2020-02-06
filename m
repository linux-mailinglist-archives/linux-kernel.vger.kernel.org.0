Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB184153C14
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 00:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgBEXph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 18:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgBEXph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:45:37 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 780C220730;
        Wed,  5 Feb 2020 23:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580946337;
        bh=Dy+Zl0jHCWeMC+twP1mM7y3kBKtfYbo8vc8x6q/EVVw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SjcMUL4uh2K+5y9yfC+Hn2fqOjIvrb+kLB4xf+74v++OtbjyVo2VR0hsDUb/NzlWZ
         jGedht6uE+p7VsPtZ6L/Mjoqc2nDugvHXwZ0m+bho9q4q6nIQ7rYhSCtaCsFkokAN+
         lNPKHgAAa5kwi/i5nCWyN3D65KOihAxZcgksOqF4=
Date:   Thu, 6 Feb 2020 08:45:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tracing/kprobe: Fix uninitialized variable bug
Message-Id: <20200206084533.14d4f105e2d45e6a0dcf6527@kernel.org>
In-Reply-To: <20200205223404.GA3379@embeddedor>
References: <20200205223404.GA3379@embeddedor>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2020 16:34:04 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> There is a potential execution path in which variable *ret* is returned
> without being properly initialized, previously.
> 
> Fix this by initializing variable *ret* to 0.

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Addresses-Coverity-ID: 1491142 ("Uninitialized scalar variable")
> Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation functions")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  kernel/trace/trace_kprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index d8264ebb9581..362cca52f5de 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1012,7 +1012,7 @@ int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...)
>  {
>  	struct dynevent_arg arg;
>  	va_list args;
> -	int ret;
> +	int ret = 0;
>  
>  	if (cmd->type != DYNEVENT_TYPE_KPROBE)
>  		return -EINVAL;
> -- 
> 2.25.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
