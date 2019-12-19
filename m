Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1B1263FC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 14:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLSNuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 08:50:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfLSNup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:50:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C9182467E;
        Thu, 19 Dec 2019 13:50:44 +0000 (UTC)
Date:   Thu, 19 Dec 2019 08:50:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] sched: Micro optimization in pick_next_task() and
 in check_preempt_curr()
Message-ID: <20191219085042.0a29437b@gandalf.local.home>
In-Reply-To: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 15:39:14 +0300
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> @@ -6569,6 +6558,11 @@ void __init sched_init(void)
>  	unsigned long ptr = 0;
>  	int i;
>  
> +	BUG_ON(&idle_sched_class > &fair_sched_class ||
> +		&fair_sched_class > &rt_sched_class ||
> +		&rt_sched_class > &dl_sched_class ||
> +		&dl_sched_class > &stop_sched_class);
> +

Can this be a BUILD_BUG_ON? These address should all be constants.

-- Steve



>  	wait_bit_init();
>  
