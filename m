Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5146717E76D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 19:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgCISob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 14:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbgCISoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:44:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5724920873;
        Mon,  9 Mar 2020 18:44:29 +0000 (UTC)
Date:   Mon, 9 Mar 2020 14:44:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: Instrumentation and RCU
Message-ID: <20200309144427.0ce0eabc@gandalf.local.home>
In-Reply-To: <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
        <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Mar 2020 14:37:40 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> So I think we could go back to plain RCU for rcuidle tracepoints if we do
> the cheaper "rcu_is_watching()" check rather than invoking
> rcu_irq_{enter,exit}_irqson() unconditionally.

You mean something like this?

-- Steve

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 5f4de82ffa0f..1904dbb3a921 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -164,7 +164,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
 		void *__data;						\
-		int __maybe_unused __idx = 0;				\
+		int __maybe_unused __idx = -1;				\
 									\
 		if (!(cond))						\
 			return;						\
@@ -179,8 +179,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		 * For rcuidle callers, use srcu since sched-rcu	\
 		 * doesn't work from the idle path.			\
 		 */							\
-		if (rcuidle)						\
-			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
+		if (rcuidle && !rcu_is_watching())			\
+			__idx = srcu_read_lock_notrace(&tracepoint_srcu); \
 									\
 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
 									\
@@ -199,7 +199,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			} while ((++it_func_ptr)->func);		\
 		}							\
 									\
-		if (rcuidle)						\
+		if (rcuidle && __idx != -1)				\
 			rcu_irq_exit_irqson();				\
 									\
 		preempt_enable_notrace();				\
