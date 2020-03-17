Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA27D18804D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 12:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgCQLJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 07:09:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10151 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgCQLJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:09:05 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48hVmG5jKbz9v9FB;
        Tue, 17 Mar 2020 12:09:02 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=QDV5rzbl; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id j4a2GrTQUvXd; Tue, 17 Mar 2020 12:09:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48hVmG4YC2z9v9Dv;
        Tue, 17 Mar 2020 12:09:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584443342; bh=dZhvDR0wuiUu1YgTZZp6+nM2qTe6hyc+zlocUw5NC4s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QDV5rzblc087xsiMAg5aNqqDGE4JHX7k3Zw6j6hi20P/D62++2o25cwNbguwbxYWL
         TAZOXE2Kciy9rIf9LJS4WBUojFIZV5kJ/oCC/Gw0tXhs5EhGAWyMU2QakquGopiJ2O
         DBFrOox6bpyKQfO1KjjPWfgCtOQ3D3+M93ZDRMLo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BCF638B786;
        Tue, 17 Mar 2020 12:09:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nLUaxYmRGV_a; Tue, 17 Mar 2020 12:09:03 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 92CDC8B785;
        Tue, 17 Mar 2020 12:08:57 +0100 (CET)
Subject: Re: [PATCH 13/15] powerpc/watchpoint: Don't allow concurrent perf and
 ptrace events
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-14-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <673cf087-1422-84b3-e3bc-13c4dd491414@c-s.fr>
Date:   Tue, 17 Mar 2020 12:08:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309085806.155823-14-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/03/2020 à 09:58, Ravi Bangoria a écrit :
> ptrace and perf watchpoints on powerpc behaves differently. Ptrace

On the 8xx, ptrace generates signal after executing the instruction.

> watchpoint works in one-shot mode and generates signal before executing
> instruction. It's ptrace user's job to single-step the instruction and
> re-enable the watchpoint. OTOH, in case of perf watchpoint, kernel
> emulates/single-steps the instruction and then generates event. If perf
> and ptrace creates two events with same or overlapping address ranges,
> it's ambiguous to decide who should single-step the instruction. Because
> of this issue ptrace and perf event can't coexist when the address range
> overlaps.

Ok, and then ? What's the purpose of this (big) patch ?

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/hw_breakpoint.h |   2 +
>   arch/powerpc/kernel/hw_breakpoint.c      | 220 +++++++++++++++++++++++
>   kernel/events/hw_breakpoint.c            |  16 ++
>   3 files changed, 238 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
> index ec61e2b7195c..6e1a19af5177 100644
> --- a/arch/powerpc/include/asm/hw_breakpoint.h
> +++ b/arch/powerpc/include/asm/hw_breakpoint.h
> @@ -66,6 +66,8 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
>   						unsigned long val, void *data);
>   int arch_install_hw_breakpoint(struct perf_event *bp);
>   void arch_uninstall_hw_breakpoint(struct perf_event *bp);
> +int arch_reserve_bp_slot(struct perf_event *bp);
> +void arch_release_bp_slot(struct perf_event *bp);
>   void arch_unregister_hw_breakpoint(struct perf_event *bp);
>   void hw_breakpoint_pmu_read(struct perf_event *bp);
>   extern void flush_ptrace_hw_breakpoint(struct task_struct *tsk);
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 2ac89b92590f..d8529d9151e8 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -123,6 +123,226 @@ static bool is_ptrace_bp(struct perf_event *bp)
>   	return (bp->overflow_handler == ptrace_triggered);
>   }
>   
> +struct breakpoint {
> +	struct list_head list;
> +	struct perf_event *bp;
> +	bool ptrace_bp;
> +};

Don't we have an equivalent struct already ?

> +
> +static DEFINE_PER_CPU(struct breakpoint *, cpu_bps[HBP_NUM_MAX]);
> +static LIST_HEAD(task_bps);
> +
> +static struct breakpoint *alloc_breakpoint(struct perf_event *bp)
> +{
> +	struct breakpoint *tmp;
> +
> +	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
> +	if (!tmp)
> +		return ERR_PTR(-ENOMEM);
> +	tmp->bp = bp;
> +	tmp->ptrace_bp = is_ptrace_bp(bp);
> +	return tmp;
> +}
> +
> +static bool bp_addr_range_overlap(struct perf_event *bp1, struct perf_event *bp2)
> +{
> +	__u64 bp1_saddr, bp1_eaddr, bp2_saddr, bp2_eaddr;
> +
> +	bp1_saddr = bp1->attr.bp_addr & ~HW_BREAKPOINT_ALIGN;
> +	bp1_eaddr = (bp1->attr.bp_addr + bp1->attr.bp_len - 1) | HW_BREAKPOINT_ALIGN;
> +	bp2_saddr = bp2->attr.bp_addr & ~HW_BREAKPOINT_ALIGN;
> +	bp2_eaddr = (bp2->attr.bp_addr + bp2->attr.bp_len - 1) | HW_BREAKPOINT_ALIGN;
> +
> +	return (bp1_saddr <= bp2_eaddr && bp1_eaddr >= bp2_saddr);

Would be better with something like (HW_BREAKPOINT_SIZE needs to be 
defined).

	bp1_saddr = ALIGN_DOWN(bp1->attr.bp_addr, HW_BREAKPOINT_SIZE);
	bp1_eaddr = ALIGN(bp1->attr.bp_addr, HW_BREAKPOINT_SIZE);
	bp2_saddr = ALIGN_DOWN(bp2->attr.bp_addr, HW_BREAKPOINT_SIZE);
	bp2_eaddr = ALIGN(bp2->attr.bp_addr, HW_BREAKPOINT_SIZE);

	return (bp1_saddr < bp2_eaddr && bp1_eaddr > bp2_saddr);

> +}
> +
> +static bool alternate_infra_bp(struct breakpoint *b, struct perf_event *bp)
> +{
> +	return is_ptrace_bp(bp) ? !b->ptrace_bp : b->ptrace_bp;
> +}
> +
> +static bool can_co_exist(struct breakpoint *b, struct perf_event *bp)
> +{
> +	return !(alternate_infra_bp(b, bp) && bp_addr_range_overlap(b->bp, bp));
> +}
> +
> +static int task_bps_add(struct perf_event *bp)
> +{
> +	struct breakpoint *tmp;
> +
> +	tmp = alloc_breakpoint(bp);
> +	if (IS_ERR(tmp))
> +		return PTR_ERR(tmp);
> +
> +	list_add(&tmp->list, &task_bps);
> +	return 0;
> +}
> +
> +static void task_bps_remove(struct perf_event *bp)
> +{
> +	struct list_head *pos, *q;
> +	struct breakpoint *tmp;
> +
> +	list_for_each_safe(pos, q, &task_bps) {
> +		tmp = list_entry(pos, struct breakpoint, list);
> +
> +		if (tmp->bp == bp) {
> +			list_del(&tmp->list);
> +			kfree(tmp);
> +			break;
> +		}
> +	}
> +}
> +
> +/*
> + * If any task has breakpoint from alternate infrastructure,
> + * return true. Otherwise return false.
> + */
> +static bool all_task_bps_check(struct perf_event *bp)
> +{
> +	struct breakpoint *tmp;
> +
> +	list_for_each_entry(tmp, &task_bps, list) {
> +		if (!can_co_exist(tmp, bp))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * If same task has breakpoint from alternate infrastructure,
> + * return true. Otherwise return false.
> + */
> +static bool same_task_bps_check(struct perf_event *bp)
> +{
> +	struct breakpoint *tmp;
> +
> +	list_for_each_entry(tmp, &task_bps, list) {
> +		if (tmp->bp->hw.target == bp->hw.target &&
> +		    !can_co_exist(tmp, bp))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static int cpu_bps_add(struct perf_event *bp)
> +{
> +	struct breakpoint **cpu_bp;
> +	struct breakpoint *tmp;
> +	int i = 0;
> +
> +	tmp = alloc_breakpoint(bp);
> +	if (IS_ERR(tmp))
> +		return PTR_ERR(tmp);
> +
> +	cpu_bp = per_cpu_ptr(cpu_bps, bp->cpu);
> +	for (i = 0; i < nr_wp_slots(); i++) {
> +		if (!cpu_bp[i]) {
> +			cpu_bp[i] = tmp;
> +			break;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static void cpu_bps_remove(struct perf_event *bp)
> +{
> +	struct breakpoint **cpu_bp;
> +	int i = 0;
> +
> +	cpu_bp = per_cpu_ptr(cpu_bps, bp->cpu);
> +	for (i = 0; i < nr_wp_slots(); i++) {
> +		if (!cpu_bp[i])
> +			continue;
> +
> +		if (cpu_bp[i]->bp == bp) {
> +			kfree(cpu_bp[i]);
> +			cpu_bp[i] = NULL;
> +			break;
> +		}
> +	}
> +}
> +
> +static bool cpu_bps_check(int cpu, struct perf_event *bp)
> +{
> +	struct breakpoint **cpu_bp;
> +	int i;
> +
> +	cpu_bp = per_cpu_ptr(cpu_bps, cpu);
> +	for (i = 0; i < nr_wp_slots(); i++) {
> +		if (cpu_bp[i] && !can_co_exist(cpu_bp[i], bp))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool all_cpu_bps_check(struct perf_event *bp)
> +{
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		if (cpu_bps_check(cpu, bp))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * We don't use any locks to serialize accesses to cpu_bps or task_bps
> + * because are already inside nr_bp_mutex.
> + */
> +int arch_reserve_bp_slot(struct perf_event *bp)
> +{
> +	int ret;
> +
> +	if (is_ptrace_bp(bp)) {
> +		if (all_cpu_bps_check(bp))
> +			return -ENOSPC;
> +
> +		if (same_task_bps_check(bp))
> +			return -ENOSPC;
> +
> +		return task_bps_add(bp);
> +	} else {
> +		if (is_kernel_addr(bp->attr.bp_addr))
> +			return 0;
> +
> +		if (bp->hw.target && bp->cpu == -1) {
> +			if (same_task_bps_check(bp))
> +				return -ENOSPC;
> +
> +			return task_bps_add(bp);
> +		} else if (!bp->hw.target && bp->cpu != -1) {
> +			if (all_task_bps_check(bp))
> +				return -ENOSPC;
> +
> +			return cpu_bps_add(bp);
> +		} else {
> +			if (same_task_bps_check(bp))
> +				return -ENOSPC;
> +
> +			ret = cpu_bps_add(bp);
> +			if (ret)
> +				return ret;
> +			ret = task_bps_add(bp);
> +			if (ret)
> +				cpu_bps_remove(bp);
> +
> +			return ret;
> +		}
> +	}
> +}
> +
> +void arch_release_bp_slot(struct perf_event *bp)
> +{
> +	if (!is_kernel_addr(bp->attr.bp_addr)) {
> +		if (bp->hw.target)
> +			task_bps_remove(bp);
> +		if (bp->cpu != -1)
> +			cpu_bps_remove(bp);
> +	}
> +}
> +
>   /*
>    * Perform cleanup of arch-specific counters during unregistration
>    * of the perf-event
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 3cc8416ec844..b48d7039a015 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -213,6 +213,15 @@ toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
>   		list_del(&bp->hw.bp_list);
>   }
>   
> +__weak int arch_reserve_bp_slot(struct perf_event *bp)
> +{
> +	return 0;
> +}
> +
> +__weak void arch_release_bp_slot(struct perf_event *bp)
> +{
> +}
> +
>   /*
>    * Function to perform processor-specific cleanup during unregistration
>    */
> @@ -270,6 +279,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
>   	struct bp_busy_slots slots = {0};
>   	enum bp_type_idx type;
>   	int weight;
> +	int ret;
>   
>   	/* We couldn't initialize breakpoint constraints on boot */
>   	if (!constraints_initialized)
> @@ -294,6 +304,10 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
>   	if (slots.pinned + (!!slots.flexible) > nr_slots[type])
>   		return -ENOSPC;
>   
> +	ret = arch_reserve_bp_slot(bp);
> +	if (ret)
> +		return ret;
> +
>   	toggle_bp_slot(bp, true, type, weight);
>   
>   	return 0;
> @@ -317,6 +331,8 @@ static void __release_bp_slot(struct perf_event *bp, u64 bp_type)
>   	enum bp_type_idx type;
>   	int weight;
>   
> +	arch_release_bp_slot(bp);
> +
>   	type = find_slot_idx(bp_type);
>   	weight = hw_breakpoint_weight(bp);
>   	toggle_bp_slot(bp, false, type, weight);
> 


Christophe
