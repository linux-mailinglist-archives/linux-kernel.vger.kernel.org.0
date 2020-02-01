Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9019514F71D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 08:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgBAHsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Feb 2020 02:48:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgBAHsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 02:48:52 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB416206D3;
        Sat,  1 Feb 2020 07:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580543331;
        bh=89+8KamrDyLQ4gkj73NBh7LDEXdmOCuFSYa/4IYAbX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s6oj8etRHrhklMug6rU4AHTNuX2WUpbgWg7kFzgA5jkJYzth1ZQgXYCi+2QJS5eOc
         2QS4d59kiHF6MZYzdbjhyHd2QR4HOyxDtf6KIMCmZCET5LlrDzRH3wpddjUqcPTOkD
         TmmRuoJnouUL2z0ipVK5seSxviZEnSlVfAc8jMtA=
Date:   Sat, 1 Feb 2020 16:48:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4/4] tracing: Use seq_buf for building dynevent_cmd
 string
Message-Id: <20200201164847.0bcc61a1cdd8b7c2019783f6@kernel.org>
In-Reply-To: <eb8a6e835c964d0ab8a38cbf5ffa60746b54a465.1580506712.git.zanussi@kernel.org>
References: <cover.1580506712.git.zanussi@kernel.org>
        <eb8a6e835c964d0ab8a38cbf5ffa60746b54a465.1580506712.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 15:55:34 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> The dynevent_cmd commands that build up the command string don't need
> to do that themselves - there's a seq_buf facility that does pretty
> much the same thing those command are doing manually, so use it
> instead.

Looks so neat :)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  include/linux/trace_events.h     |  4 +---
>  kernel/trace/trace_dynevent.c    | 48 +++++++++++-----------------------------
>  kernel/trace/trace_events_hist.c |  2 +-
>  kernel/trace/trace_kprobe.c      |  2 +-
>  4 files changed, 16 insertions(+), 40 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 7c307a7c9c6a..67f528ecb9e5 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -367,10 +367,8 @@ struct dynevent_cmd;
>  typedef int (*dynevent_create_fn_t)(struct dynevent_cmd *cmd);
>  
>  struct dynevent_cmd {
> -	char			*buf;
> +	struct seq_buf		seq;
>  	const char		*event_name;
> -	int			maxlen;
> -	int			remaining;
>  	unsigned int		n_fields;
>  	enum dynevent_type	type;
>  	dynevent_create_fn_t	run_command;
> diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> index 204275ec8d71..9f2e8520b748 100644
> --- a/kernel/trace/trace_dynevent.c
> +++ b/kernel/trace/trace_dynevent.c
> @@ -247,8 +247,6 @@ int dynevent_arg_add(struct dynevent_cmd *cmd,
>  		     dynevent_check_arg_fn_t check_arg)
>  {
>  	int ret = 0;
> -	int delta;
> -	char *q;
>  
>  	if (check_arg) {
>  		ret = check_arg(arg);
> @@ -256,14 +254,11 @@ int dynevent_arg_add(struct dynevent_cmd *cmd,
>  			return ret;
>  	}
>  
> -	q = cmd->buf + (cmd->maxlen - cmd->remaining);
> -
> -	delta = snprintf(q, cmd->remaining, " %s%c", arg->str, arg->separator);
> -	if (delta >= cmd->remaining) {
> -		pr_err("String is too long: %s\n", arg->str);
> +	ret = seq_buf_printf(&cmd->seq, " %s%c", arg->str, arg->separator);
> +	if (ret) {
> +		pr_err("String is too long: %s%c\n", arg->str, arg->separator);
>  		return -E2BIG;
>  	}
> -	cmd->remaining -= delta;
>  
>  	return ret;
>  }
> @@ -297,8 +292,6 @@ int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
>  			  dynevent_check_arg_fn_t check_arg)
>  {
>  	int ret = 0;
> -	int delta;
> -	char *q;
>  
>  	if (check_arg) {
>  		ret = check_arg(arg_pair);
> @@ -306,23 +299,15 @@ int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
>  			return ret;
>  	}
>  
> -	q = cmd->buf + (cmd->maxlen - cmd->remaining);
> -
> -	delta = snprintf(q, cmd->remaining, " %s%c", arg_pair->lhs,
> -			 arg_pair->operator);
> -	if (delta >= cmd->remaining) {
> -		pr_err("field string is too long: %s\n", arg_pair->lhs);
> -		return -E2BIG;
> -	}
> -	cmd->remaining -= delta; q += delta;
> -
> -	delta = snprintf(q, cmd->remaining, "%s%c", arg_pair->rhs,
> -			 arg_pair->separator);
> -	if (delta >= cmd->remaining) {
> -		pr_err("field string is too long: %s\n", arg_pair->rhs);
> +	ret = seq_buf_printf(&cmd->seq, " %s%c%s%c", arg_pair->lhs,
> +			     arg_pair->operator, arg_pair->rhs,
> +			     arg_pair->separator);
> +	if (ret) {
> +		pr_err("field string is too long: %s%c%s%c\n", arg_pair->lhs,
> +		       arg_pair->operator, arg_pair->rhs,
> +		       arg_pair->separator);
>  		return -E2BIG;
>  	}
> -	cmd->remaining -= delta;
>  
>  	return ret;
>  }
> @@ -340,17 +325,12 @@ int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
>  int dynevent_str_add(struct dynevent_cmd *cmd, const char *str)
>  {
>  	int ret = 0;
> -	int delta;
> -	char *q;
> -
> -	q = cmd->buf + (cmd->maxlen - cmd->remaining);
>  
> -	delta = snprintf(q, cmd->remaining, "%s", str);
> -	if (delta >= cmd->remaining) {
> +	ret = seq_buf_puts(&cmd->seq, str);
> +	if (ret) {
>  		pr_err("String is too long: %s\n", str);
>  		return -E2BIG;
>  	}
> -	cmd->remaining -= delta;
>  
>  	return ret;
>  }
> @@ -381,9 +361,7 @@ void dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen,
>  {
>  	memset(cmd, '\0', sizeof(*cmd));
>  
> -	cmd->buf = buf;
> -	cmd->maxlen = maxlen;
> -	cmd->remaining = cmd->maxlen;
> +	seq_buf_init(&cmd->seq, buf, maxlen);
>  	cmd->type = type;
>  	cmd->run_command = run_command;
>  }
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index a566f5d290c1..6dc3078a6d02 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1762,7 +1762,7 @@ static int synth_event_run_command(struct dynevent_cmd *cmd)
>  	struct synth_event *se;
>  	int ret;
>  
> -	ret = trace_run_command(cmd->buf, create_or_delete_synth_event);
> +	ret = trace_run_command(cmd->seq.buffer, create_or_delete_synth_event);
>  	if (ret)
>  		return ret;
>  
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index fe183d4045d2..51efc790aea8 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -903,7 +903,7 @@ static int create_or_delete_trace_kprobe(int argc, char **argv)
>  
>  static int trace_kprobe_run_command(struct dynevent_cmd *cmd)
>  {
> -	return trace_run_command(cmd->buf, create_or_delete_trace_kprobe);
> +	return trace_run_command(cmd->seq.buffer, create_or_delete_trace_kprobe);
>  }
>  
>  /**
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
