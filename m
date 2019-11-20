Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED191031C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 03:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfKTCsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 21:48:05 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48204 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727082AbfKTCsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 21:48:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0Tiba29s_1574218073;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tiba29s_1574218073)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Nov 2019 10:47:54 +0800
Subject: Re: [PATCH V2 7/7] x86,rcu: use percpu rcu_preempt_depth
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Rik van Riel <riel@surriel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jann Horn <jannh@google.com>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Yuyang Du <duyuyang@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>, rcu@vger.kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-8-laijs@linux.alibaba.com>
 <20191116154821.GE2865@paulmck-ThinkPad-P72>
 <4680b6f5-02d2-1d76-0b67-a5d3d9b36200@linux.alibaba.com>
 <20191118145953.GK2889@paulmck-ThinkPad-P72>
 <3dd0fa56-68b9-c179-95db-f110e47f53b7@linux.alibaba.com>
 <20191119211443.GH2889@paulmck-ThinkPad-P72>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <e23925a5-e447-127c-93f8-757e8a5f8069@linux.alibaba.com>
Date:   Wed, 20 Nov 2019 10:47:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119211443.GH2889@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/20 5:14 上午, Paul E. McKenney wrote:
> On Tue, Nov 19, 2019 at 09:59:03AM +0800, Lai Jiangshan wrote:
>>
>>
>> On 2019/11/18 10:59 下午, Paul E. McKenney wrote:
>>> On Mon, Nov 18, 2019 at 10:02:50AM +0800, Lai Jiangshan wrote:
>>>>
>>>>
>>>> On 2019/11/16 11:48 下午, Paul E. McKenney wrote:
>>>>> On Sat, Nov 02, 2019 at 12:45:59PM +0000, Lai Jiangshan wrote:
>>>>>> Convert x86 to use a per-cpu rcu_preempt_depth. The reason for doing so
>>>>>> is that accessing per-cpu variables is a lot cheaper than accessing
>>>>>> task_struct or thread_info variables.
>>>>>>
>>>>>> We need to save/restore the actual rcu_preempt_depth when switch.
>>>>>> We also place the per-cpu rcu_preempt_depth close to __preempt_count
>>>>>> and current_task variable.
>>>>>>
>>>>>> Using the idea of per-cpu __preempt_count.
>>>>>>
>>>>>> No function call when using rcu_read_[un]lock().
>>>>>> Single instruction for rcu_read_lock().
>>>>>> 2 instructions for fast path of rcu_read_unlock().
>>>>>>
>>>>>> CC: Peter Zijlstra <peterz@infradead.org>
>>>>>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>>>>>
>>>>> Wouldn't putting RCU's nesting-depth counter in task info be just as fast,
>>>>> just as nice for #include/inlining, and a lot less per-architecture code?
>>>>>
>>>>> Or am I missing some issue with the task-info approach?
>>>>
>>>> struct thread_info itself is per-architecture definition.
>>>> All the arches would have to be touched if RCU's nesting-depth counter
>>>> is put int struct thread_info. Though the inlining functions can be
>>>> defined in include/asm-generic/ so that it serves for all arches
>>>> and X86 can have its own implementation in arch/x86/include/asm/.
>>>
>>> True enough.
>>>
>>> But doesn't the per-CPU code require per-architecture changes to copy
>>> to and from the per-CPU variable?  If that code simpler and smaller than
>>> the thread_info access code, I will be -very- surprised.
>>
>> The per-CPU code is not simpler. And my code touch X86 ONLY so that
>> it requires an additional CONFIG and some more "#if" in rcu code
>> which adds little more complicity.
>>
>> As far as I understand, the rcu_read_lock_nesting can only be possible
>> put in per CPU in X86, not possible in other ARCHs.
>>
>> Putting the rcu_read_lock_nesting in struct thread_info and putting
>> the inlining functions in include/asm-generic/ are OK for me. It will
>> be a good-shaped framework and reduce function calls, and still allow
>> x86 has its own implementation.
> 
> In addition, even for x86, the struct thread_info approach would avoid
> adding more instructions to the context-switch path.

For all arches, these is no additional instructions to the
context-switch path for the struct thread_info approach.

The X86 per-cpu approach adds only a 2loads and 2 stores in the
context-switch path.

But there are tens of read_read_[un]lock calls between context-switchs
if not hundreds nor thousands. The read_read_[un]lock is more frequent
than context-switch. Every read_read_[un]lock pair needs about 20
instructions now, reducing the pair to 3 instructions in the percpu
approach is a win in my opinion.

> 
>> The framework will only be more appealing when the x86 percpu
>> rcu_read_lock_nesting is implemented. This series implements
>> the x86 percpu rcu_read_lock_nesting first and avoid touch too much
>> files. The framework can be implemented later
> 
> If I remember correctly, you mentioned earlier that the struct
> thread_info approach was just as few instructions for rcu_read_lock()
> and rcu_read_unlock() as is the per-CPU approach.  If that is the
> case, and if the struct thread_info approach avoids adding code to the
> context-switch path, why would the x86 maintainers be at all happy with
> the per-CPU approach?  What am I missing here?


The struct thread_info approach will save only function calls compared
with the current struct task_struct approach. The struct thread_info
approach and the current struct task_struct approach are the same
excepct that the later one has to do function calls to avoid c-header
files including hell.

These is no additional instructions to the context-switch path for the
struct thread_info approach. But I'm not sure whether each Arch
maintainers be at all happy with the struct thread_info approach
since the benefit is not so large as x86.

And maybe gcc LTO can reduce the function calls too, so that the
struct thread_info approach and the current struct task_struct
approach will be really exactly the same. But I know nothing about
LTO.

The struct thread_info approach will still need 12(=5+7) instructions
for read_read_[un]lock pair whereas the per-CPU approach needs only 3
instructions for every pair (fast path).

In x86, on one hand, this patchset reduces the number of instructions
needed for the read_read_[un]lock pair markedly (12 basic instructions
+ 2 functions calls => 3 instructions).

On the other hand, it can be compared with preempt_disable/enable()
pair, which had also been changed from the struct thread_info approach
by Peter Zijlstra <peterz@infradead.org> at c2daa3bed53a in 2013.
The importance of reducing the overhead of the preempt_disable/enable()
pair and the read_read_[un]lock pair is the same to me. Especially,
preempt_disable/enable() is discouraged except really needed, while
the usage of read_read_[un]lock is increasing.

Thanks
Lai

> 
> 							Thanx, Paul
> 
>> Thanks
>> Lai
>>
>>
>>>
>>> 							Thanx, Paul
>>>
>>>>>> ---
>>>>>>     arch/x86/Kconfig                         |  2 +
>>>>>>     arch/x86/include/asm/rcu_preempt_depth.h | 87 ++++++++++++++++++++++++
>>>>>>     arch/x86/kernel/cpu/common.c             |  7 ++
>>>>>>     arch/x86/kernel/process_32.c             |  2 +
>>>>>>     arch/x86/kernel/process_64.c             |  2 +
>>>>>>     include/linux/rcupdate.h                 | 24 +++++++
>>>>>>     init/init_task.c                         |  2 +-
>>>>>>     kernel/fork.c                            |  2 +-
>>>>>>     kernel/rcu/Kconfig                       |  3 +
>>>>>>     kernel/rcu/tree_exp.h                    |  2 +
>>>>>>     kernel/rcu/tree_plugin.h                 | 37 +++++++---
>>>>>>     11 files changed, 158 insertions(+), 12 deletions(-)
>>>>>>     create mode 100644 arch/x86/include/asm/rcu_preempt_depth.h
>>>>>>
>>>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>>>> index d6e1faa28c58..af9fedc0fdc4 100644
>>>>>> --- a/arch/x86/Kconfig
>>>>>> +++ b/arch/x86/Kconfig
>>>>>> @@ -18,6 +18,7 @@ config X86_32
>>>>>>     	select MODULES_USE_ELF_REL
>>>>>>     	select OLD_SIGACTION
>>>>>>     	select GENERIC_VDSO_32
>>>>>> +	select ARCH_HAVE_RCU_PREEMPT_DEEPTH
>>>>>>     config X86_64
>>>>>>     	def_bool y
>>>>>> @@ -31,6 +32,7 @@ config X86_64
>>>>>>     	select NEED_DMA_MAP_STATE
>>>>>>     	select SWIOTLB
>>>>>>     	select ARCH_HAS_SYSCALL_WRAPPER
>>>>>> +	select ARCH_HAVE_RCU_PREEMPT_DEEPTH
>>>>>>     config FORCE_DYNAMIC_FTRACE
>>>>>>     	def_bool y
>>>>>> diff --git a/arch/x86/include/asm/rcu_preempt_depth.h b/arch/x86/include/asm/rcu_preempt_depth.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..88010ad59c20
>>>>>> --- /dev/null
>>>>>> +++ b/arch/x86/include/asm/rcu_preempt_depth.h
>>>>>> @@ -0,0 +1,87 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>> +#ifndef __ASM_RCU_PREEMPT_DEPTH_H
>>>>>> +#define __ASM_RCU_PREEMPT_DEPTH_H
>>>>>> +
>>>>>> +#include <asm/rmwcc.h>
>>>>>> +#include <asm/percpu.h>
>>>>>> +
>>>>>> +#ifdef CONFIG_PREEMPT_RCU
>>>>>> +DECLARE_PER_CPU(int, __rcu_preempt_depth);
>>>>>> +
>>>>>> +/*
>>>>>> + * We use the RCU_NEED_SPECIAL bit as an inverted need_special
>>>>>> + * such that a decrement hitting 0 means we can and should do
>>>>>> + * rcu_read_unlock_special().
>>>>>> + */
>>>>>> +#define RCU_NEED_SPECIAL	0x80000000
>>>>>> +
>>>>>> +#define INIT_RCU_PREEMPT_DEPTH	(RCU_NEED_SPECIAL)
>>>>>> +
>>>>>> +/* We mask the RCU_NEED_SPECIAL bit so that it return real depth */
>>>>>> +static __always_inline int rcu_preempt_depth(void)
>>>>>> +{
>>>>>> +	return raw_cpu_read_4(__rcu_preempt_depth) & ~RCU_NEED_SPECIAL;
>>>>>> +}
>>>>>> +
>>>>>> +static __always_inline void rcu_preempt_depth_set(int pc)
>>>>>> +{
>>>>>> +	int old, new;
>>>>>> +
>>>>>> +	do {
>>>>>> +		old = raw_cpu_read_4(__rcu_preempt_depth);
>>>>>> +		new = (old & RCU_NEED_SPECIAL) |
>>>>>> +			(pc & ~RCU_NEED_SPECIAL);
>>>>>> +	} while (raw_cpu_cmpxchg_4(__rcu_preempt_depth, old, new) != old);
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * We fold the RCU_NEED_SPECIAL bit into the rcu_preempt_depth such that
>>>>>> + * rcu_read_unlock() can decrement and test for needing to do special
>>>>>> + * with a single instruction.
>>>>>> + *
>>>>>> + * We invert the actual bit, so that when the decrement hits 0 we know
>>>>>> + * both it just exited the outmost rcu_read_lock() critical section and
>>>>>> + * we need to do specail (the bit is cleared) if it doesn't need to be
>>>>>> + * deferred.
>>>>>> + */
>>>>>> +
>>>>>> +static inline void set_rcu_preempt_need_special(void)
>>>>>> +{
>>>>>> +	raw_cpu_and_4(__rcu_preempt_depth, ~RCU_NEED_SPECIAL);
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * irq needs to be disabled for clearing any bits of ->rcu_read_unlock_special
>>>>>> + * and calling this function. Otherwise it may clear the work done
>>>>>> + * by set_rcu_preempt_need_special() in interrupt.
>>>>>> + */
>>>>>> +static inline void clear_rcu_preempt_need_special(void)
>>>>>> +{
>>>>>> +	raw_cpu_or_4(__rcu_preempt_depth, RCU_NEED_SPECIAL);
>>>>>> +}
>>>>>> +
>>>>>> +static __always_inline void rcu_preempt_depth_inc(void)
>>>>>> +{
>>>>>> +	raw_cpu_add_4(__rcu_preempt_depth, 1);
>>>>>> +}
>>>>>> +
>>>>>> +static __always_inline bool rcu_preempt_depth_dec_and_test(void)
>>>>>> +{
>>>>>> +	return GEN_UNARY_RMWcc("decl", __rcu_preempt_depth, e, __percpu_arg([var]));
>>>>>> +}
>>>>>> +
>>>>>> +/* must be macros to avoid header recursion hell */
>>>>>> +#define save_restore_rcu_preempt_depth(prev_p, next_p) do {				\
>>>>>> +		prev_p->rcu_read_lock_nesting = this_cpu_read(__rcu_preempt_depth);	\
>>>>>> +		this_cpu_write(__rcu_preempt_depth, next_p->rcu_read_lock_nesting);	\
>>>>>> +	} while (0)
>>>>>> +
>>>>>> +#define DEFINE_PERCPU_RCU_PREEMP_DEPTH						\
>>>>>> +	DEFINE_PER_CPU(int, __rcu_preempt_depth) = INIT_RCU_PREEMPT_DEPTH;	\
>>>>>> +	EXPORT_PER_CPU_SYMBOL(__rcu_preempt_depth)
>>>>>> +#else /* #ifdef CONFIG_PREEMPT_RCU */
>>>>>> +#define save_restore_rcu_preempt_depth(prev_p, next_p) do {} while (0)
>>>>>> +#define DEFINE_PERCPU_RCU_PREEMP_DEPTH	/* empty */
>>>>>> +#endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>>>>>> +
>>>>>> +#endif /* __ASM_RCU_PREEMPT_DEPTH_H */
>>>>>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>>>>>> index 9ae7d1bcd4f4..0151737e196c 100644
>>>>>> --- a/arch/x86/kernel/cpu/common.c
>>>>>> +++ b/arch/x86/kernel/cpu/common.c
>>>>>> @@ -46,6 +46,7 @@
>>>>>>     #include <asm/asm.h>
>>>>>>     #include <asm/bugs.h>
>>>>>>     #include <asm/cpu.h>
>>>>>> +#include <asm/rcu_preempt_depth.h>
>>>>>>     #include <asm/mce.h>
>>>>>>     #include <asm/msr.h>
>>>>>>     #include <asm/pat.h>
>>>>>> @@ -1633,6 +1634,9 @@ DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
>>>>>>     DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
>>>>>>     EXPORT_PER_CPU_SYMBOL(__preempt_count);
>>>>>> +/* close to __preempt_count */
>>>>>> +DEFINE_PERCPU_RCU_PREEMP_DEPTH;
>>>>>> +
>>>>>>     /* May not be marked __init: used by software suspend */
>>>>>>     void syscall_init(void)
>>>>>>     {
>>>>>> @@ -1690,6 +1694,9 @@ EXPORT_PER_CPU_SYMBOL(current_task);
>>>>>>     DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
>>>>>>     EXPORT_PER_CPU_SYMBOL(__preempt_count);
>>>>>> +/* close to __preempt_count */
>>>>>> +DEFINE_PERCPU_RCU_PREEMP_DEPTH;
>>>>>> +
>>>>>>     /*
>>>>>>      * On x86_32, vm86 modifies tss.sp0, so sp0 isn't a reliable way to find
>>>>>>      * the top of the kernel stack.  Use an extra percpu variable to track the
>>>>>> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
>>>>>> index b8ceec4974fe..ab1f20353663 100644
>>>>>> --- a/arch/x86/kernel/process_32.c
>>>>>> +++ b/arch/x86/kernel/process_32.c
>>>>>> @@ -51,6 +51,7 @@
>>>>>>     #include <asm/cpu.h>
>>>>>>     #include <asm/syscalls.h>
>>>>>>     #include <asm/debugreg.h>
>>>>>> +#include <asm/rcu_preempt_depth.h>
>>>>>>     #include <asm/switch_to.h>
>>>>>>     #include <asm/vm86.h>
>>>>>>     #include <asm/resctrl_sched.h>
>>>>>> @@ -290,6 +291,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>>>>>>     	if (prev->gs | next->gs)
>>>>>>     		lazy_load_gs(next->gs);
>>>>>> +	save_restore_rcu_preempt_depth(prev_p, next_p);
>>>>>>     	this_cpu_write(current_task, next_p);
>>>>>>     	switch_fpu_finish(next_fpu);
>>>>>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
>>>>>> index af64519b2695..2e1c6e829d30 100644
>>>>>> --- a/arch/x86/kernel/process_64.c
>>>>>> +++ b/arch/x86/kernel/process_64.c
>>>>>> @@ -50,6 +50,7 @@
>>>>>>     #include <asm/ia32.h>
>>>>>>     #include <asm/syscalls.h>
>>>>>>     #include <asm/debugreg.h>
>>>>>> +#include <asm/rcu_preempt_depth.h>
>>>>>>     #include <asm/switch_to.h>
>>>>>>     #include <asm/xen/hypervisor.h>
>>>>>>     #include <asm/vdso.h>
>>>>>> @@ -559,6 +560,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>>>>>>     	x86_fsgsbase_load(prev, next);
>>>>>> +	save_restore_rcu_preempt_depth(prev_p, next_p);
>>>>>>     	/*
>>>>>>     	 * Switch the PDA and FPU contexts.
>>>>>>     	 */
>>>>>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>>>>>> index a35daab95d14..0d2abf08b694 100644
>>>>>> --- a/include/linux/rcupdate.h
>>>>>> +++ b/include/linux/rcupdate.h
>>>>>> @@ -41,6 +41,29 @@ void synchronize_rcu(void);
>>>>>>     #ifdef CONFIG_PREEMPT_RCU
>>>>>> +#ifdef CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH
>>>>>> +#include <asm/rcu_preempt_depth.h>
>>>>>> +
>>>>>> +#ifndef CONFIG_PROVE_LOCKING
>>>>>> +extern void rcu_read_unlock_special(void);
>>>>>> +
>>>>>> +static inline void __rcu_read_lock(void)
>>>>>> +{
>>>>>> +	rcu_preempt_depth_inc();
>>>>>> +}
>>>>>> +
>>>>>> +static inline void __rcu_read_unlock(void)
>>>>>> +{
>>>>>> +	if (unlikely(rcu_preempt_depth_dec_and_test()))
>>>>>> +		rcu_read_unlock_special();
>>>>>> +}
>>>>>> +#else
>>>>>> +void __rcu_read_lock(void);
>>>>>> +void __rcu_read_unlock(void);
>>>>>> +#endif
>>>>>> +
>>>>>> +#else /* #ifdef CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH */
>>>>>> +#define INIT_RCU_PREEMPT_DEPTH (0)
>>>>>>     void __rcu_read_lock(void);
>>>>>>     void __rcu_read_unlock(void);
>>>>>> @@ -51,6 +74,7 @@ void __rcu_read_unlock(void);
>>>>>>      * types of kernel builds, the rcu_read_lock() nesting depth is unknowable.
>>>>>>      */
>>>>>>     #define rcu_preempt_depth() (current->rcu_read_lock_nesting)
>>>>>> +#endif /* #else #ifdef CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH */
>>>>>>     #else /* #ifdef CONFIG_PREEMPT_RCU */
>>>>>> diff --git a/init/init_task.c b/init/init_task.c
>>>>>> index 9e5cbe5eab7b..0a91e38fba37 100644
>>>>>> --- a/init/init_task.c
>>>>>> +++ b/init/init_task.c
>>>>>> @@ -130,7 +130,7 @@ struct task_struct init_task
>>>>>>     	.perf_event_list = LIST_HEAD_INIT(init_task.perf_event_list),
>>>>>>     #endif
>>>>>>     #ifdef CONFIG_PREEMPT_RCU
>>>>>> -	.rcu_read_lock_nesting = 0,
>>>>>> +	.rcu_read_lock_nesting = INIT_RCU_PREEMPT_DEPTH,
>>>>>>     	.rcu_read_unlock_special.s = 0,
>>>>>>     	.rcu_node_entry = LIST_HEAD_INIT(init_task.rcu_node_entry),
>>>>>>     	.rcu_blocked_node = NULL,
>>>>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>>>>> index f9572f416126..7368d4ccb857 100644
>>>>>> --- a/kernel/fork.c
>>>>>> +++ b/kernel/fork.c
>>>>>> @@ -1665,7 +1665,7 @@ init_task_pid(struct task_struct *task, enum pid_type type, struct pid *pid)
>>>>>>     static inline void rcu_copy_process(struct task_struct *p)
>>>>>>     {
>>>>>>     #ifdef CONFIG_PREEMPT_RCU
>>>>>> -	p->rcu_read_lock_nesting = 0;
>>>>>> +	p->rcu_read_lock_nesting = INIT_RCU_PREEMPT_DEPTH;
>>>>>>     	p->rcu_read_unlock_special.s = 0;
>>>>>>     	p->rcu_blocked_node = NULL;
>>>>>>     	INIT_LIST_HEAD(&p->rcu_node_entry);
>>>>>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>>>>>> index 1cc940fef17c..d2ecca49a1a4 100644
>>>>>> --- a/kernel/rcu/Kconfig
>>>>>> +++ b/kernel/rcu/Kconfig
>>>>>> @@ -14,6 +14,9 @@ config TREE_RCU
>>>>>>     	  thousands of CPUs.  It also scales down nicely to
>>>>>>     	  smaller systems.
>>>>>> +config ARCH_HAVE_RCU_PREEMPT_DEEPTH
>>>>>> +	def_bool n
>>>>>> +
>>>>>>     config PREEMPT_RCU
>>>>>>     	bool
>>>>>>     	default y if PREEMPTION
>>>>>> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>>>>>> index dcb2124203cf..f919881832d4 100644
>>>>>> --- a/kernel/rcu/tree_exp.h
>>>>>> +++ b/kernel/rcu/tree_exp.h
>>>>>> @@ -588,6 +588,7 @@ static void wait_rcu_exp_gp(struct work_struct *wp)
>>>>>>     }
>>>>>>     #ifdef CONFIG_PREEMPT_RCU
>>>>>> +static inline void set_rcu_preempt_need_special(void);
>>>>>>     /*
>>>>>>      * Remote handler for smp_call_function_single().  If there is an
>>>>>> @@ -637,6 +638,7 @@ static void rcu_exp_handler(void *unused)
>>>>>>     		if (rnp->expmask & rdp->grpmask) {
>>>>>>     			rdp->exp_deferred_qs = true;
>>>>>>     			t->rcu_read_unlock_special.b.exp_hint = true;
>>>>>> +			set_rcu_preempt_need_special();
>>>>>>     		}
>>>>>>     		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>>>>>>     		return;
>>>>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>>>>> index e16c3867d2ff..e6774a7ab16b 100644
>>>>>> --- a/kernel/rcu/tree_plugin.h
>>>>>> +++ b/kernel/rcu/tree_plugin.h
>>>>>> @@ -82,7 +82,7 @@ static void __init rcu_bootup_announce_oddness(void)
>>>>>>     #ifdef CONFIG_PREEMPT_RCU
>>>>>>     static void rcu_report_exp_rnp(struct rcu_node *rnp, bool wake);
>>>>>> -static void rcu_read_unlock_special(struct task_struct *t);
>>>>>> +void rcu_read_unlock_special(void);
>>>>>>     /*
>>>>>>      * Tell them what RCU they are running.
>>>>>> @@ -298,6 +298,7 @@ void rcu_note_context_switch(bool preempt)
>>>>>>     		t->rcu_read_unlock_special.b.need_qs = false;
>>>>>>     		t->rcu_read_unlock_special.b.blocked = true;
>>>>>>     		t->rcu_blocked_node = rnp;
>>>>>> +		set_rcu_preempt_need_special();
>>>>>>     		/*
>>>>>>     		 * Verify the CPU's sanity, trace the preemption, and
>>>>>> @@ -345,6 +346,7 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
>>>>>>     /* Bias and limit values for ->rcu_read_lock_nesting. */
>>>>>>     #define RCU_NEST_PMAX (INT_MAX / 2)
>>>>>> +#ifndef CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH
>>>>>>     static inline void rcu_preempt_depth_inc(void)
>>>>>>     {
>>>>>>     	current->rcu_read_lock_nesting++;
>>>>>> @@ -352,7 +354,12 @@ static inline void rcu_preempt_depth_inc(void)
>>>>>>     static inline bool rcu_preempt_depth_dec_and_test(void)
>>>>>>     {
>>>>>> -	return --current->rcu_read_lock_nesting == 0;
>>>>>> +	if (--current->rcu_read_lock_nesting == 0) {
>>>>>> +		/* check speical after dec ->rcu_read_lock_nesting */
>>>>>> +		barrier();
>>>>>> +		return READ_ONCE(current->rcu_read_unlock_special.s);
>>>>>> +	}
>>>>>> +	return 0;
>>>>>>     }
>>>>>>     static inline void rcu_preempt_depth_set(int val)
>>>>>> @@ -360,6 +367,12 @@ static inline void rcu_preempt_depth_set(int val)
>>>>>>     	current->rcu_read_lock_nesting = val;
>>>>>>     }
>>>>>> +static inline void clear_rcu_preempt_need_special(void) {}
>>>>>> +static inline void set_rcu_preempt_need_special(void) {}
>>>>>> +
>>>>>> +#endif /* #ifndef CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH */
>>>>>> +
>>>>>> +#if !defined(CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH) || defined (CONFIG_PROVE_LOCKING)
>>>>>>     /*
>>>>>>      * Preemptible RCU implementation for rcu_read_lock().
>>>>>>      * Just increment ->rcu_read_lock_nesting, shared state will be updated
>>>>>> @@ -383,18 +396,16 @@ EXPORT_SYMBOL_GPL(__rcu_read_lock);
>>>>>>      */
>>>>>>     void __rcu_read_unlock(void)
>>>>>>     {
>>>>>> -	struct task_struct *t = current;
>>>>>> -
>>>>>>     	if (rcu_preempt_depth_dec_and_test()) {
>>>>>> -		barrier();  /* critical section before exit code. */
>>>>>> -		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
>>>>>> -			rcu_read_unlock_special(t);
>>>>>> +		rcu_read_unlock_special();
>>>>>>     	}
>>>>>>     	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
>>>>>> -		WARN_ON_ONCE(rcu_preempt_depth() < 0);
>>>>>> +		WARN_ON_ONCE(rcu_preempt_depth() < 0 ||
>>>>>> +			     rcu_preempt_depth() > RCU_NEST_PMAX);
>>>>>>     	}
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(__rcu_read_unlock);
>>>>>> +#endif /* #if !defined(CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH) || defined (CONFIG_PROVE_LOCKING) */
>>>>>>     /*
>>>>>>      * Advance a ->blkd_tasks-list pointer to the next entry, instead
>>>>>> @@ -449,6 +460,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>>>>>>     		return;
>>>>>>     	}
>>>>>>     	t->rcu_read_unlock_special.s = 0;
>>>>>> +	clear_rcu_preempt_need_special();
>>>>>>     	if (special.b.need_qs)
>>>>>>     		rcu_qs();
>>>>>> @@ -579,8 +591,9 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>>>>>>      * notify RCU core processing or task having blocked during the RCU
>>>>>>      * read-side critical section.
>>>>>>      */
>>>>>> -static void rcu_read_unlock_special(struct task_struct *t)
>>>>>> +void rcu_read_unlock_special(void)
>>>>>>     {
>>>>>> +	struct task_struct *t = current;
>>>>>>     	unsigned long flags;
>>>>>>     	bool preempt_bh_were_disabled =
>>>>>>     			!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
>>>>>> @@ -631,6 +644,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>>>>>>     	}
>>>>>>     	rcu_preempt_deferred_qs_irqrestore(t, flags);
>>>>>>     }
>>>>>> +EXPORT_SYMBOL_GPL(rcu_read_unlock_special);
>>>>>>     /*
>>>>>>      * Check that the list of blocked tasks for the newly completed grace
>>>>>> @@ -694,8 +708,10 @@ static void rcu_flavor_sched_clock_irq(int user)
>>>>>>     	    __this_cpu_read(rcu_data.core_needs_qs) &&
>>>>>>     	    __this_cpu_read(rcu_data.cpu_no_qs.b.norm) &&
>>>>>>     	    !t->rcu_read_unlock_special.b.need_qs &&
>>>>>> -	    time_after(jiffies, rcu_state.gp_start + HZ))
>>>>>> +	    time_after(jiffies, rcu_state.gp_start + HZ)) {
>>>>>>     		t->rcu_read_unlock_special.b.need_qs = true;
>>>>>> +		set_rcu_preempt_need_special();
>>>>>> +	}
>>>>>>     }
>>>>>>     /*
>>>>>> @@ -714,6 +730,7 @@ void exit_rcu(void)
>>>>>>     		rcu_preempt_depth_set(1);
>>>>>>     		barrier();
>>>>>>     		WRITE_ONCE(t->rcu_read_unlock_special.b.blocked, true);
>>>>>> +		set_rcu_preempt_need_special();
>>>>>>     	} else if (unlikely(rcu_preempt_depth())) {
>>>>>>     		rcu_preempt_depth_set(1);
>>>>>>     	} else {
>>>>>> -- 
>>>>>> 2.20.1
>>>>>>
