Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8251560A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 22:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBGVSR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Feb 2020 16:18:17 -0500
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:48245 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727005AbgBGVSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:18:17 -0500
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Feb 2020 16:18:16 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 895D518033D25
        for <linux-kernel@vger.kernel.org>; Fri,  7 Feb 2020 21:08:22 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id AFA81837F252;
        Fri,  7 Feb 2020 21:08:21 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,rostedt@goodmis.org,:::::::::::::::::::::,RULES_HIT:41:152:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1513:1515:1516:1518:1521:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:3138:3139:3140:3141:3142:3353:3865:3868:3873:5007:6120:7652:7875:7903:10004:10400:10450:10455:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12663:12895:12986:13069:13255:13311:13357:14721:14777:19904:19999:21080:21324:21433:21627:21740:21990:30026:30039:30054:30090,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:16,LUA_SUMMARY:none
X-HE-Tag: fuel06_65ff284cde013
X-Filterd-Recvd-Size: 3182
Received: from [100.68.140.46] (unknown [206.121.37.170])
        (Authenticated sender: rostedt@goodmis.org)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri,  7 Feb 2020 21:08:20 +0000 (UTC)
Date:   Fri, 07 Feb 2020 16:07:58 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <20200207205656.61938-2-joel@joelfernandes.org>
References: <20200207205656.61938-1-joel@joelfernandes.org> <20200207205656.61938-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [RFC 1/3] Revert "tracepoint: Use __idx instead of idx in DO_TRACE macro to make it unique"
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
From:   Steven Rostedt <rostedt@goodmis.org>
Message-ID: <13EE7A4B-38E7-4A41-AE42-C03B1898E947@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Top posting as I'm replying from an airport gate, from my phone ]

Although you have a cover letter explaining the revert, each patch must be standalone, otherwise looking at git history won't have any explanation for the revert.

-- Steve


On February 7, 2020 3:56:54 PM EST, "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
>This reverts commit 0c7a52e4d4b5c4d35b31f3c3ad32af814f1bf491.
>
>Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>---
> include/linux/tracepoint.h | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
>index 1fb11daa5c533..59463c90fdc3d 100644
>--- a/include/linux/tracepoint.h
>+++ b/include/linux/tracepoint.h
>@@ -164,7 +164,7 @@ static inline struct tracepoint
>*tracepoint_ptr_deref(tracepoint_ptr_t *p)
> 		struct tracepoint_func *it_func_ptr;			\
> 		void *it_func;						\
> 		void *__data;						\
>-		int __maybe_unused __idx = 0;				\
>+		int __maybe_unused idx = 0;				\
> 									\
> 		if (!(cond))						\
> 			return;						\
>@@ -180,7 +180,7 @@ static inline struct tracepoint
>*tracepoint_ptr_deref(tracepoint_ptr_t *p)
> 		 * doesn't work from the idle path.			\
> 		 */							\
> 		if (rcuidle) {						\
>-			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
>+			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> 			rcu_irq_enter_irqson();				\
> 		}							\
> 									\
>@@ -196,7 +196,7 @@ static inline struct tracepoint
>*tracepoint_ptr_deref(tracepoint_ptr_t *p)
> 									\
> 		if (rcuidle) {						\
> 			rcu_irq_exit_irqson();				\
>-			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
>+			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
> 		}							\
> 									\
> 		preempt_enable_notrace();				\

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
