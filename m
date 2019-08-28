Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E63CEA0E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 01:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfH1XGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 19:06:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbfH1XGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 19:06:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SMl944023628;
        Wed, 28 Aug 2019 19:05:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unys2dtca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 19:05:38 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7SMlAfE023744;
        Wed, 28 Aug 2019 19:05:38 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unys2dtc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 19:05:38 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SMj31Q010154;
        Wed, 28 Aug 2019 23:05:36 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 2ujvv6grqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 23:05:36 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SN5ap750987338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 23:05:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D51EEB2066;
        Wed, 28 Aug 2019 23:05:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A56DFB2064;
        Wed, 28 Aug 2019 23:05:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 23:05:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9051516C65B8; Wed, 28 Aug 2019 16:05:38 -0700 (PDT)
Date:   Wed, 28 Aug 2019 16:05:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rcu/dyntick-idle: Add better tracing
Message-ID: <20190828230538.GD26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190828001146.GM26530@linux.ibm.com>
 <20190828182613.37715-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828182613.37715-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 02:26:13PM -0400, Joel Fernandes (Google) wrote:
> The dyntick-idle traces are a bit confusing. This patch makes it simpler
> and adds some missing cases such as EQS-enter because user vs idle mode.
> 
> Following are the changes:
> (1) Add a new context field to trace_rcu_dyntick tracepoint. This
>     context field can be "USER", "IDLE" or "IRQ".
> 
> (2) Remove the "++=" and "--=" strings and replace them with
>    "StillNonIdle". This is much easier on the eyes, and the -- and ++
>    are easily apparent in the dynticks_nesting counters we are printing
>    anyway.
> 
> This patch is based on the previous patches to simplify rcu_dyntick
> counters [1] and with these traces, I have verified the counters are
> working properly.
> 
> [1]
> Link: https://lore.kernel.org/patchwork/patch/1120021/
> Link: https://lore.kernel.org/patchwork/patch/1120022/
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks plausible to me.

							Thanx, Paul

> ---
>  include/trace/events/rcu.h | 13 ++++++++-----
>  kernel/rcu/tree.c          | 17 +++++++++++------
>  2 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 66122602bd08..474c1f7e7104 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -449,12 +449,14 @@ TRACE_EVENT_RCU(rcu_fqs,
>   */
>  TRACE_EVENT_RCU(rcu_dyntick,
>  
> -	TP_PROTO(const char *polarity, long oldnesting, long newnesting, atomic_t dynticks),
> +	TP_PROTO(const char *polarity, const char *context, long oldnesting,
> +		 long newnesting, atomic_t dynticks),
>  
> -	TP_ARGS(polarity, oldnesting, newnesting, dynticks),
> +	TP_ARGS(polarity, context, oldnesting, newnesting, dynticks),
>  
>  	TP_STRUCT__entry(
>  		__field(const char *, polarity)
> +		__field(const char *, context)
>  		__field(long, oldnesting)
>  		__field(long, newnesting)
>  		__field(int, dynticks)
> @@ -462,14 +464,15 @@ TRACE_EVENT_RCU(rcu_dyntick,
>  
>  	TP_fast_assign(
>  		__entry->polarity = polarity;
> +		__entry->context = context;
>  		__entry->oldnesting = oldnesting;
>  		__entry->newnesting = newnesting;
>  		__entry->dynticks = atomic_read(&dynticks);
>  	),
>  
> -	TP_printk("%s %lx %lx %#3x", __entry->polarity,
> -		  __entry->oldnesting, __entry->newnesting,
> -		  __entry->dynticks & 0xfff)
> +	TP_printk("%s %s %lx %lx %#3x", __entry->polarity,
> +		__entry->context, __entry->oldnesting, __entry->newnesting,
> +		__entry->dynticks & 0xfff)
>  );
>  
>  /*
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1465a3e406f8..1a65919ec800 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -570,7 +570,8 @@ static void rcu_eqs_enter(bool user)
>  	}
>  
>  	lockdep_assert_irqs_disabled();
> -	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, rdp->dynticks);
> +	trace_rcu_dyntick(TPS("Start"), (user ? TPS("USER") : TPS("IDLE")),
> +			  rdp->dynticks_nesting, 0, rdp->dynticks);
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	rdp = this_cpu_ptr(&rcu_data);
>  	do_nocb_deferred_wakeup(rdp);
> @@ -642,15 +643,17 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
>  	 * leave it in non-RCU-idle state.
>  	 */
>  	if (rdp->dynticks_nesting != 1) {
> -		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nesting,
> -				  rdp->dynticks_nesting - 2, rdp->dynticks);
> +		trace_rcu_dyntick(TPS("StillNonIdle"), TPS("IRQ"),
> +				  rdp->dynticks_nesting, rdp->dynticks_nesting - 2,
> +				  rdp->dynticks);
>  		WRITE_ONCE(rdp->dynticks_nesting, /* No store tearing. */
>  			   rdp->dynticks_nesting - 2);
>  		return;
>  	}
>  
>  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> -	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nesting, 0, rdp->dynticks);
> +	trace_rcu_dyntick(TPS("Start"), TPS("IRQ"), rdp->dynticks_nesting, 0,
> +			  rdp->dynticks);
>  	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid store tearing. */
>  
>  	if (irq)
> @@ -733,7 +736,8 @@ static void rcu_eqs_exit(bool user)
>  	rcu_dynticks_task_exit();
>  	rcu_dynticks_eqs_exit();
>  	rcu_cleanup_after_idle();
> -	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
> +	trace_rcu_dyntick(TPS("End"), (user ? TPS("USER") : TPS("IDLE")),
> +			  rdp->dynticks_nesting, 1, rdp->dynticks);
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	WRITE_ONCE(rdp->dynticks_nesting, 1);
>  
> @@ -825,7 +829,8 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
>  		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
>  	}
>  
> -	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> +	trace_rcu_dyntick(incby == 1 ? TPS("End") : TPS("StillNonIdle"),
> +			  TPS("IRQ"),
>  			  rdp->dynticks_nesting,
>  			  rdp->dynticks_nesting + incby, rdp->dynticks);
>  
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
