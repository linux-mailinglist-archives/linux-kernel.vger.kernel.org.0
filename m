Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92385C123A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 23:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfI1VZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 17:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfI1VZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 17:25:10 -0400
Received: from oasis.local.home (unknown [12.174.139.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 425982082F;
        Sat, 28 Sep 2019 21:25:09 +0000 (UTC)
Date:   Sat, 28 Sep 2019 17:25:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ivan Safonov <insafonov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] genirq: replace notify with old_notify in
 irq_set_affinity_notifier()
Message-ID: <20190928172507.6698545f@oasis.local.home>
In-Reply-To: <20190928151921.29268-1-insafonov@gmail.com>
References: <20190928151921.29268-1-insafonov@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2019 18:19:20 +0300
Ivan Safonov <insafonov@gmail.com> wrote:

> This patch is for Linux 4.19 with a RT patch.
> 
> The second 'if' block does not check notify for NULL,
> this leads to a system crash.
> 
> Most likely, there is a typo here.
> 
> With old_notify system works as expected.
> 
> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
> ---
>  kernel/irq/manage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 290cd520dba1..79a7072dfb3c 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -412,7 +412,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
>  
>  	if (old_notify) {
>  #ifdef CONFIG_PREEMPT_RT_BASE
> -		kthread_cancel_work_sync(&notify->work);
> +		kthread_cancel_work_sync(&old_notify->work);

Thanks for the patch, but I currently have an RFC out that rewrites all
this code. I'm hoping to apply the RFC patch next week.

-- Steve


>  #else
>  		cancel_work_sync(&old_notify->work);
>  #endif

