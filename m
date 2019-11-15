Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D39FE214
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 16:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfKOPy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 10:54:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727520AbfKOPy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:54:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDEF1206D3;
        Fri, 15 Nov 2019 15:54:57 +0000 (UTC)
Date:   Fri, 15 Nov 2019 10:54:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ftrace: fix spelling mistake "wakeing" ->
 "waking"
Message-ID: <20191115105456.29444b06@gandalf.local.home>
In-Reply-To: <20191115085938.38947-1-colin.king@canonical.com>
References: <20191115085938.38947-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 08:59:38 +0000
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a trace_printk message. Fix it.

As this breaks the selftests, I'm folding this patch into the one that
you sent that updates the selftests as well.

-- Steve

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  samples/ftrace/ftrace-direct.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
> index 1483f067b000..a2e3063bd306 100644
> --- a/samples/ftrace/ftrace-direct.c
> +++ b/samples/ftrace/ftrace-direct.c
> @@ -6,7 +6,7 @@
>  
>  void my_direct_func(struct task_struct *p)
>  {
> -	trace_printk("wakeing up %s-%d\n", p->comm, p->pid);
> +	trace_printk("waking up %s-%d\n", p->comm, p->pid);
>  }
>  
>  extern void my_tramp(void *);

