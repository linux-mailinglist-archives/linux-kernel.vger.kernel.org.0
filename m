Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68AB2C05C1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfI0Mwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 08:52:34 -0400
Received: from foss.arm.com ([217.140.110.172]:51658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfI0Mwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:52:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E7231000;
        Fri, 27 Sep 2019 05:52:33 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A8853F67D;
        Fri, 27 Sep 2019 05:52:32 -0700 (PDT)
Date:   Fri, 27 Sep 2019 13:52:30 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Julien Grall <julien.grall@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64/sve: Fix wrong free for task->thread.sve_state
Message-ID: <20190927125228.GQ27757@arm.com>
References: <20190926190846.3072-1-msys.mizuma@gmail.com>
 <20190926190846.3072-2-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926190846.3072-2-msys.mizuma@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 03:08:46PM -0400, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> The system which has SVE feature crashed because of
> the memory pointed by task->thread.sve_state was destroyed
> by someone.
> 
> That is because sve_state is freed while the forking the
> child process. The child process has the pointer of sve_state
> which is same as the parent's because the child's task_struct
> is copied from the parent's one. If the copy_process()
> fails as an error on somewhere, for example, copy_creds(),
> then the sve_state is freed even if the parent is alive.
> The flow is as follows.
> 
> copy_process
>         p = dup_task_struct
>             => arch_dup_task_struct
>                 *dst = *src;  // copy the entire region.
> :
>         retval = copy_creds
>         if (retval < 0)
>                 goto bad_fork_free;
> :
> bad_fork_free:
> ...
>         delayed_free_task(p);
>           => free_task
>              => arch_release_task_struct
>                 => fpsimd_release_task
>                    => __sve_free
>                       => kfree(task->thread.sve_state);
>                          // free the parent's sve_state
> 
> Add a flag in task->thread which shows the fork is in progress.
> If the fork is in progress, that means the child has the pointer
> to the parent's sve_state, doesn't free the sve_state.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Reported-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> ---
>  arch/arm64/include/asm/processor.h | 1 +
>  arch/arm64/kernel/fpsimd.c         | 6 ++++--
>  arch/arm64/kernel/process.c        | 2 ++
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 5623685c7d13..3ca3e350145a 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -143,6 +143,7 @@ struct thread_struct {
>  	unsigned long		fault_address;	/* fault info */
>  	unsigned long		fault_code;	/* ESR_EL1 value */
>  	struct debug_info	debug;		/* debugging */
> +	unsigned int		fork_in_progress;
>  #ifdef CONFIG_ARM64_PTR_AUTH
>  	struct ptrauth_keys	keys_user;
>  #endif
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 37d3912cfe06..8641db4cb062 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -202,8 +202,10 @@ static bool have_cpu_fpsimd_context(void)
>   */
>  static void __sve_free(struct task_struct *task)
>  {
> -	kfree(task->thread.sve_state);
> -	task->thread.sve_state = NULL;
> +	if (!task->thread.fork_in_progress) {
> +		kfree(task->thread.sve_state);
> +		task->thread.sve_state = NULL;
> +	}
>  }
>  
>  static void sve_free(struct task_struct *task)
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index a47462def04b..8ac0ee4e5f76 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -347,6 +347,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  	if (current->mm)
>  		fpsimd_preserve_current_state();
>  	*dst = *src;
> +	dst->thread.fork_in_progress = 1;
>  
>  	return 0;
>  }
> @@ -365,6 +366,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  	 * and disable discard SVE state for p:
>  	 */
>  	clear_tsk_thread_flag(p, TIF_SVE);
> +	p->thread.fork_in_progress = 0;
>  	p->thread.sve_state = NULL;

There's definitely a problem here, but a simpler fix is probably to
NULL sve_state and clear TIF_SVE for dst at the same time.

Once upon a time, I had to cope with the thread_flags not being copied
as part of task_struct here, which is one reason why the code is the
(broken) way it is, but this is ancient history...

Commit c02433dd6de3 ("arm64: split thread_info from task stack") was
merged in v4.10 and predates SVE support anyway.


So can just do the following (untested) and delete the confusing
comments?

Cheers
---Dave

--8<--


diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f674f28..6937f59 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -323,22 +323,16 @@ void arch_release_task_struct(struct task_struct *tsk)
 	fpsimd_release_task(tsk);
 }
 
-/*
- * src and dst may temporarily have aliased sve_state after task_struct
- * is copied.  We cannot fix this properly here, because src may have
- * live SVE state and dst's thread_info may not exist yet, so tweaking
- * either src's or dst's TIF_SVE is not safe.
- *
- * The unaliasing is done in copy_thread() instead.  This works because
- * dst is not schedulable or traceable until both of these functions
- * have been called.
- */
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
 	if (current->mm)
 		fpsimd_preserve_current_state();
 	*dst = *src;
 
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK));
+	dst->thread.sve_state = NULL;
+	clear_tsk_thread_flag(dst, TIF_SVE);
+
 	return 0;
 }
 
@@ -352,13 +346,6 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
 	/*
-	 * Unalias p->thread.sve_state (if any) from the parent task
-	 * and disable discard SVE state for p:
-	 */
-	clear_tsk_thread_flag(p, TIF_SVE);
-	p->thread.sve_state = NULL;
-
-	/*
 	 * In case p was allocated the same task_struct pointer as some
 	 * other recently-exited task, make sure p is disassociated from
 	 * any cpu that may have run that now-exited task recently.
