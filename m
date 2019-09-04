Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC792A8146
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 13:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfIDLmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 07:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfIDLmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:42:43 -0400
Received: from oasis.local.home (bl11-233-114.dsl.telepac.pt [85.244.233.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF70E20820;
        Wed,  4 Sep 2019 11:42:18 +0000 (UTC)
Date:   Wed, 4 Sep 2019 07:42:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 2/4] preemptirq_delay_test: Add the burst feature and
 a sysfs trigger
Message-ID: <20190904074212.4c7d17dc@oasis.local.home>
In-Reply-To: <20190903132602.3440-3-viktor.rosendahl@gmail.com>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
        <20190903132602.3440-3-viktor.rosendahl@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Sep 2019 15:26:00 +0200
Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:
> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
> index d8765c952fab..dc281fa75198 100644
> --- a/kernel/trace/preemptirq_delay_test.c
> +++ b/kernel/trace/preemptirq_delay_test.c
> @@ -3,6 +3,7 @@
>   * Preempt / IRQ disable delay thread to test latency tracers
>   *
>   * Copyright (C) 2018 Joel Fernandes (Google) <joel@joelfernandes.org>
> + * Copyright (C) 2018, 2019 BMW Car IT GmbH

A name and what you did should also be attached here. Ideally, we leave
these out as git history is usually enough.

-- Steve

>   */
>  
>  #include <linux/trace_clock.h>
> @@ -10,18 +11,25 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
> +#include <linux/kobject.h>
>  #include <linux/kthread.h>
>  #include <linux/module.h>
>  #include <linux/printk.h>
>  #include <linux/string.h>
> +#include <linux/sysfs.h>
>  
>
