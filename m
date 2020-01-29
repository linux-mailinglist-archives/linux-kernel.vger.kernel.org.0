Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5D314CF58
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 18:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgA2RNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 12:13:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbgA2RM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:12:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC11206D4;
        Wed, 29 Jan 2020 17:12:58 +0000 (UTC)
Date:   Wed, 29 Jan 2020 12:12:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.com>, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH 3/7] t_next should increase position index
Message-ID: <20200129121257.3cf9c2d6@gandalf.local.home>
In-Reply-To: <8681248a-da16-5448-31fe-26df9e7cfc25@virtuozzo.com>
References: <8681248a-da16-5448-31fe-26df9e7cfc25@virtuozzo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 10:02:51 +0300
Vasily Averin <vvs@virtuozzo.com> wrote:

> if seq_file .next fuction does not change position index,
> read after some lseek can generate unexpected output.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  kernel/trace/ftrace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 9bf1f2c..ca25210 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3442,8 +3442,10 @@ static void *t_mod_start(struct seq_file *m, loff_t *pos)
>  	loff_t l = *pos; /* t_probe_start() must use original pos */
>  	void *ret;
>  
> -	if (unlikely(ftrace_disabled))
> +	if (unlikely(ftrace_disabled)) {
> +		(*pos)++;
>  		return NULL;
> +	}

This isn't needed. If ftrace_disabled is set, we shouldn't be printing
anything. This case isn't the same as the report in the bugzilla.

-- Steve

>  
>  	if (iter->flags & FTRACE_ITER_PROBE)
>  		return t_probe_next(m, pos);

