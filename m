Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E871987FE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 01:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfHUXkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 19:40:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728042AbfHUXkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 19:40:31 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LNb3nM042663;
        Wed, 21 Aug 2019 19:40:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhf7j93cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 19:40:21 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7LNeKah049097;
        Wed, 21 Aug 2019 19:40:20 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhf7j93c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 19:40:20 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7LNdNIl000729;
        Wed, 21 Aug 2019 23:40:19 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2ue976yean-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 23:40:19 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7LNeIQa53936454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 23:40:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9D15B2066;
        Wed, 21 Aug 2019 23:40:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4CCBB205F;
        Wed, 21 Aug 2019 23:40:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.200.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 21 Aug 2019 23:40:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5869016C65BD; Wed, 21 Aug 2019 16:40:18 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:40:18 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 3/3] rcu: Disable use_softirq on PREEMPT_RT
Message-ID: <20190821234018.GW28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-4-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821231906.4224-4-swood@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 06:19:06PM -0500, Scott Wood wrote:
> Besides restoring behavior that used to be default on RT, this avoids
> a deadlock on scheduler locks:
> 
> [  136.894657] 039: ============================================
> [  136.900401] 039: WARNING: possible recursive locking detected
> [  136.906146] 039: 5.2.9-rt3.dbg+ #174 Tainted: G            E
> [  136.912152] 039: --------------------------------------------
> [  136.917896] 039: rcu_torture_rea/13474 is trying to acquire lock:
> [  136.923990] 039: 000000005f25146d
> [  136.927310] 039:  (
> [  136.929414] 039: &p->pi_lock
> [  136.932303] 039: ){-...}
> [  136.934840] 039: , at: try_to_wake_up+0x39/0x920
> [  136.939461] 039:
> but task is already holding lock:
> [  136.944425] 039: 000000005f25146d
> [  136.947745] 039:  (
> [  136.949852] 039: &p->pi_lock
> [  136.952738] 039: ){-...}
> [  136.955274] 039: , at: try_to_wake_up+0x39/0x920
> [  136.959895] 039:
> other info that might help us debug this:
> [  136.965555] 039:  Possible unsafe locking scenario:
> 
> [  136.970608] 039:        CPU0
> [  136.973493] 039:        ----
> [  136.976378] 039:   lock(
> [  136.978918] 039: &p->pi_lock
> [  136.981806] 039: );
> [  136.983911] 039:   lock(
> [  136.986451] 039: &p->pi_lock
> [  136.989336] 039: );
> [  136.991444] 039:
>  *** DEADLOCK ***
> 
> [  136.995194] 039:  May be due to missing lock nesting notation
> 
> [  137.001115] 039: 3 locks held by rcu_torture_rea/13474:
> [  137.006341] 039:  #0:
> [  137.008707] 039: 000000005f25146d
> [  137.012024] 039:  (
> [  137.014131] 039: &p->pi_lock
> [  137.017015] 039: ){-...}
> [  137.019558] 039: , at: try_to_wake_up+0x39/0x920
> [  137.024175] 039:  #1:
> [  137.026540] 039: 0000000011c8e51d
> [  137.029859] 039:  (
> [  137.031966] 039: &rq->lock
> [  137.034679] 039: ){-...}
> [  137.037217] 039: , at: try_to_wake_up+0x241/0x920
> [  137.041924] 039:  #2:
> [  137.044291] 039: 00000000098649b9
> [  137.047610] 039:  (
> [  137.049714] 039: rcu_read_lock
> [  137.052774] 039: ){....}
> [  137.055314] 039: , at: cpuacct_charge+0x33/0x1e0
> [  137.059934] 039:
> stack backtrace:
> [  137.063425] 039: CPU: 39 PID: 13474 Comm: rcu_torture_rea Kdump: loaded Tainted: G            E     5.2.9-rt3.dbg+ #174
> [  137.074197] 039: Hardware name: Intel Corporation S2600BT/S2600BT, BIOS SE5C620.86B.01.00.0763.022420181017 02/24/2018
> [  137.084886] 039: Call Trace:
> [  137.087773] 039:  <IRQ>
> [  137.090226] 039:  dump_stack+0x5e/0x8b
> [  137.093997] 039:  __lock_acquire+0x725/0x1100
> [  137.098358] 039:  lock_acquire+0xc0/0x240
> [  137.102374] 039:  ? try_to_wake_up+0x39/0x920
> [  137.106737] 039:  _raw_spin_lock_irqsave+0x47/0x90
> [  137.111534] 039:  ? try_to_wake_up+0x39/0x920
> [  137.115910] 039:  try_to_wake_up+0x39/0x920
> [  137.120098] 039:  rcu_read_unlock_special+0x65/0xb0
> [  137.124977] 039:  __rcu_read_unlock+0x5d/0x70
> [  137.129337] 039:  cpuacct_charge+0xd9/0x1e0
> [  137.133522] 039:  ? cpuacct_charge+0x33/0x1e0
> [  137.137880] 039:  update_curr+0x14b/0x420
> [  137.141894] 039:  enqueue_entity+0x42/0x370
> [  137.146080] 039:  enqueue_task_fair+0xa9/0x490
> [  137.150528] 039:  activate_task+0x5a/0xf0
> [  137.154539] 039:  ttwu_do_activate+0x4e/0x90
> [  137.158813] 039:  try_to_wake_up+0x277/0x920
> [  137.163086] 039:  irq_exit+0xb6/0xf0
> [  137.166661] 039:  smp_apic_timer_interrupt+0xe3/0x3a0
> [  137.171714] 039:  apic_timer_interrupt+0xf/0x20
> [  137.176249] 039:  </IRQ>
> [  137.178785] 039: RIP: 0010:__schedule+0x0/0x8e0
> [  137.183319] 039: Code: 00 02 48 89 43 20 e8 0f 5a 00 00 48 8d 7b 28 e8 86 f2 fd ff 31 c0 5b 5d 41 5c c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <55> 48 89 e5 41 57 41 56 49 c7 c6 c0 ca 1e 00 41 55 41 89 fd 41 54
> [  137.202498] 039: RSP: 0018:ffffc9005835fbc0 EFLAGS: 00000246
> [  137.208158] 039:  ORIG_RAX: ffffffffffffff13
> [  137.212428] 039: RAX: 0000000000000000 RBX: ffff8897c3e1bb00 RCX: 0000000000000001
> [  137.219994] 039: RDX: 0000000080004008 RSI: 0000000000000006 RDI: 0000000000000001
> [  137.227560] 039: RBP: ffff8897c3e1bb00 R08: 0000000000000000 R09: 0000000000000000
> [  137.235126] 039: R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff81001fd1
> [  137.242694] 039: R13: 0000000000000044 R14: 0000000000000000 R15: ffffc9005835fcac
> [  137.250259] 039:  ? ___preempt_schedule+0x16/0x18
> [  137.254969] 039:  preempt_schedule_common+0x32/0x80
> [  137.259846] 039:  ___preempt_schedule+0x16/0x18
> [  137.264379] 039:  rcutorture_one_extend+0x33a/0x510 [rcutorture]
> [  137.270397] 039:  rcu_torture_one_read+0x18c/0x450 [rcutorture]
> [  137.276334] 039:  rcu_torture_reader+0xac/0x1f0 [rcutorture]
> [  137.281998] 039:  ? rcu_torture_reader+0x1f0/0x1f0 [rcutorture]
> [  137.287920] 039:  kthread+0x106/0x140
> [  137.291591] 039:  ? rcu_torture_one_read+0x450/0x450 [rcutorture]
> [  137.297681] 039:  ? kthread_bind+0x10/0x10
> [  137.301783] 039:  ret_from_fork+0x3a/0x50
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
> I think the prohibition on use_softirq can be dropped once RT gets the
> latest RCU code, but the question of what use_softirq should default
> to on PREEMPT_RT remains.
> ---
>  kernel/rcu/tree.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index fc8b00c61b32..12036d33e2f9 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -98,9 +98,16 @@ struct rcu_state rcu_state = {
>  /* Dump rcu_node combining tree at boot to verify correct setup. */
>  static bool dump_tree;
>  module_param(dump_tree, bool, 0444);
> -/* By default, use RCU_SOFTIRQ instead of rcuc kthreads. */
> +/*
> + * By default, use RCU_SOFTIRQ instead of rcuc kthreads.
> + * But, avoid RCU_SOFTIRQ on PREEMPT_RT due to pi/rq deadlocks.
> + */
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +static bool use_softirq;
> +#else
>  static bool use_softirq = 1;
>  module_param(use_softirq, bool, 0444);
> +#endif

Save a couple of lines?

static bool use_softirq = !IS_ENABLED(CONFIG_PREEMPT_RT_FULL);

And if I understand your point above, the module_param() might be
able to be the same either way given the new RCU.  But if not,
at least we get rid of the #else.

							Thanx, Paul

>  /* Control rcu_node-tree auto-balancing at boot time. */
>  static bool rcu_fanout_exact;
>  module_param(rcu_fanout_exact, bool, 0444);
> -- 
> 1.8.3.1
> 
