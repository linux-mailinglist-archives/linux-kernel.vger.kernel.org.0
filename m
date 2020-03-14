Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8B185348
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Mar 2020 01:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgCNA0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 20:26:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48302 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCNA0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:26:12 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jCucv-0005We-5Z; Sat, 14 Mar 2020 01:26:05 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7655B101115; Sat, 14 Mar 2020 01:26:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4/9] sched/swait: Prepare usage in completions
In-Reply-To: <20200313174701.148376-5-bigeasy@linutronix.de>
References: <20200313174701.148376-1-bigeasy@linutronix.de> <20200313174701.148376-5-bigeasy@linutronix.de>
Date:   Sat, 14 Mar 2020 01:26:04 +0100
Message-ID: <87pndfeq8z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>  
> +void swake_up_all_locked(struct swait_queue_head *q)
> +{
> +	while (!list_empty(&q->task_list))
> +		swake_up_locked(q);
> +}

This one wants a big fat comment along with the usage site in the
completions.

Yes, it's my fault that I forgot to double check this. Will send a delta
patch when brain is more awake.

Thanks,

        tglx
