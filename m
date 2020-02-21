Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6EF9168473
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 18:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgBURKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 12:10:12 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34705 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgBURKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:10:12 -0500
Received: by mail-qk1-f196.google.com with SMTP id c20so2493180qkm.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gL/kI9VlGkNvzMfzmc7dKStrYuJZuzj9czJ6UkMUDSw=;
        b=hQnbm4bvPj/8KwZxCy4xnI5Jiq2xd0eO7tnVuE+mZt3Y6ny5WGl5XAnVRa/kyz/CAc
         kYoSXdEzR2tlxIfb0qIeZip7nPAIvQSkurUB0I2PZqpsiI5G381887tq0Oj0pkHWCmkI
         y89jbPtiIuO9qHSubtu6J77b9/Hi0du3KhAA/S6LTAT6pk85vfriN6sWJtsCzaPvJwI+
         IYgG3cuorr392xFSccQqbBRNJmfQm9//mBER3pncenCZW6w8bTv8kFZj5JE+roSX1IFg
         iyVi14thTMxG6HBk4re079w58AZKmuW+PDRCpTKsZQGqLDh3Tny7NrfXxpe6l0o3ZJf1
         DUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gL/kI9VlGkNvzMfzmc7dKStrYuJZuzj9czJ6UkMUDSw=;
        b=ZR3w8vxNFHsVehm3ET+0izzZqHssw8N41ugZkCy1GdfvL5kYexGeSLB3Ud6RiTXHLX
         egsiewtdkm+l2MDfsVSBju+jLXkso27Uot0fHF+1mquDpplP3eBoV/Vy0+Yf6agLayt/
         VW1rUzUSehpzOG0FH1qf0gmHw+GumKP2tuS3B3yLFtLNyI03KxqeZW76FcIaSVQnydhy
         8QYOy78k48SwdzIROzB8SwnvpOvIJER/TB4RcLrxqDpubq4/gM52D2kvS/x8gKWT2BTJ
         Gwg2k+isjAqmvuwBkq8s3olUDSmh4CbZALHV0cBBCepCBuwRUR5a5R9zwfR6txoisKjE
         OcVw==
X-Gm-Message-State: APjAAAUeYGW54bvZEMmL4hGFD8K/jwd5HhcdoyFprd/2Hkdg0egP8ogB
        tLfowVHjD/DDSLjLnrPLGXoNGA==
X-Google-Smtp-Source: APXvYqyQ4uvzqNzwsp8oGQxg0ieef9/jivwkEYxQxVIMvsd0JDosQFqtvwHapRXAKh2pfUTJ62AwdQ==
X-Received: by 2002:a37:4c81:: with SMTP id z123mr33909677qka.320.1582305010998;
        Fri, 21 Feb 2020 09:10:10 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 65sm1797385qtc.4.2020.02.21.09.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:10:10 -0800 (PST)
Message-ID: <1582305008.7365.111.camel@lca.pw>
Subject: Re: [PATCH] kcsan: Add option for verbose reporting
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 12:10:08 -0500
In-Reply-To: <20200219151531.161515-1-elver@google.com>
References: <20200219151531.161515-1-elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-19 at 16:15 +0100, Marco Elver wrote:
> Adds CONFIG_KCSAN_VERBOSE to optionally enable more verbose reports.
> Currently information about the reporting task's held locks and IRQ
> trace events are shown, if they are enabled.

Well, there is a report. I don't understand why it said there is no lock held in
the writer, but clearly there is this right after in
jbd2_journal_commit_transaction(),

 spin_unlock(&jh->b_state_lock);

[ 2268.021382][T25724] BUG: KCSAN: data-race in __jbd2_journal_refile_buffer
[jbd2] / jbd2_write_access_granted [jbd2]
[ 2268.031888][T25724] 
[ 2268.034099][T25724] write to 0xffff99f9b1bd0e30 of 8 bytes by task 25721 on
cpu 70:
[ 2268.041842][T25724]  __jbd2_journal_refile_buffer+0xdd/0x210 [jbd2]
__jbd2_journal_refile_buffer at fs/jbd2/transaction.c:2569
[ 2268.048181][T25724]  jbd2_journal_commit_transaction+0x2d15/0x3f20 [jbd2]
(inlined by) jbd2_journal_commit_transaction at fs/jbd2/commit.c:1033
[ 2268.055042][T25724]  kjournald2+0x13b/0x450 [jbd2]
[ 2268.059876][T25724]  kthread+0x1cd/0x1f0
[ 2268.063835][T25724]  ret_from_fork+0x27/0x50
[ 2268.068143][T25724] 
[ 2268.070348][T25724] no locks held by jbd2/loop0-8/25721.
[ 2268.075699][T25724] irq event stamp: 77604
[ 2268.079830][T25724] hardirqs last  enabled at (77603): [<ffffffff986da853>]
_raw_spin_unlock_irqrestore+0x53/0x60
[ 2268.090166][T25724] hardirqs last disabled at (77604): [<ffffffff986d0841>]
__schedule+0x181/0xa50
[ 2268.099192][T25724] softirqs last  enabled at (76092): [<ffffffff98a0034c>]
__do_softirq+0x34c/0x57c
[ 2268.108392][T25724] softirqs last disabled at (76005): [<ffffffff97cc67a2>]
irq_exit+0xa2/0xc0
[ 2268.117062][T25724] 
[ 2268.119269][T25724] read to 0xffff99f9b1bd0e30 of 8 bytes by task 25724 on
cpu 68:
[ 2268.126916][T25724]  jbd2_write_access_granted+0x1b2/0x250 [jbd2]
jbd2_write_access_granted at fs/jbd2/transaction.c:1155
[ 2268.133086][T25724]  jbd2_journal_get_write_access+0x2c/0x60 [jbd2]
[ 2268.139492][T25724]  __ext4_journal_get_write_access+0x50/0x90 [ext4]
[ 2268.146076][T25724]  ext4_mb_mark_diskspace_used+0x158/0x620 [ext4]
[ 2268.152507][T25724]  ext4_mb_new_blocks+0x54f/0xca0 [ext4]
[ 2268.158125][T25724]  ext4_ind_map_blocks+0xc79/0x1b40 [ext4]
[ 2268.163923][T25724]  ext4_map_blocks+0x3b4/0x950 [ext4]
[ 2268.169284][T25724]  _ext4_get_block+0xfc/0x270 [ext4]
[ 2268.174556][T25724]  ext4_get_block+0x3b/0x50 [ext4]
[ 2268.179566][T25724]  __block_write_begin_int+0x22e/0xae0
[ 2268.184921][T25724]  __block_write_begin+0x39/0x50
[ 2268.189842][T25724]  ext4_write_begin+0x388/0xb50 [ext4]
[ 2268.195195][T25724]  generic_perform_write+0x15d/0x290
[ 2268.200467][T25724]  ext4_buffered_write_iter+0x11f/0x210 [ext4]
[ 2268.206612][T25724]  ext4_file_write_iter+0xce/0x9e0 [ext4]
[ 2268.212228][T25724]  new_sync_write+0x29c/0x3b0
[ 2268.216794][T25724]  __vfs_write+0x92/0xa0
[ 2268.220924][T25724]  vfs_write+0x103/0x260
[ 2268.225052][T25724]  ksys_write+0x9d/0x130
[ 2268.229182][T25724]  __x64_sys_write+0x4c/0x60
[ 2268.233666][T25724]  do_syscall_64+0x91/0xb05
[ 2268.238058][T25724]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 2268.243846][T25724] 
[ 2268.246056][T25724] 5 locks held by fsync04/25724:
[ 2268.250880][T25724]  #0: ffff99f9911093f8 (sb_writers#13){.+.+}, at:
vfs_write+0x21c/0x260
[ 2268.259211][T25724]  #1: ffff99f9db4c0348 (&sb->s_type-
>i_mutex_key#15){+.+.}, at: ext4_buffered_write_iter+0x65/0x210 [ext4]
[ 2268.270693][T25724]  #2: ffff99f5e7dfcf58 (jbd2_handle){++++}, at:
start_this_handle+0x1c1/0x9d0 [jbd2]
[ 2268.280180][T25724]  #3: ffff99f9db4c0168 (&ei->i_data_sem){++++}, at:
ext4_map_blocks+0x176/0x950 [ext4]
[ 2268.289913][T25724]  #4: ffffffff99086b40 (rcu_read_lock){....}, at:
jbd2_write_access_granted+0x4e/0x250 [jbd2]
[ 2268.300187][T25724] irq event stamp: 1407125
[ 2268.304496][T25724] hardirqs last  enabled at (1407125): [<ffffffff980da9b7>]
__find_get_block+0x107/0x790
[ 2268.314218][T25724] hardirqs last disabled at (1407124): [<ffffffff980da8f9>]
__find_get_block+0x49/0x790
[ 2268.323856][T25724] softirqs last  enabled at (1405528): [<ffffffff98a0034c>]
__do_softirq+0x34c/0x57c
[ 2268.333229][T25724] softirqs last disabled at (1405521): [<ffffffff97cc67a2>]
irq_exit+0xa2/0xc0
[ 2268.342075][T25724] 
[ 2268.344282][T25724] Reported by Kernel Concurrency Sanitizer on:
[ 2268.350339][T25724] CPU: 68 PID: 25724 Comm: fsync04 Tainted:
G             L    5.6.0-rc2-next-20200221+ #7
[ 2268.360234][T25724] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385
Gen10, BIOS A40 07/10/2019

> 
> Signed-off-by: Marco Elver <elver@google.com>
> Suggested-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/kcsan/report.c | 48 +++++++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.kcsan     | 13 ++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index 11c791b886f3c..f14becb6f1537 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -1,10 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/debug_locks.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/lockdep.h>
>  #include <linux/preempt.h>
>  #include <linux/printk.h>
> +#include <linux/rcupdate.h>
>  #include <linux/sched.h>
>  #include <linux/spinlock.h>
>  #include <linux/stacktrace.h>
> @@ -245,6 +247,29 @@ static int sym_strcmp(void *addr1, void *addr2)
>  	return strncmp(buf1, buf2, sizeof(buf1));
>  }
>  
> +static void print_verbose_info(struct task_struct *task)
> +{
> +	if (!task)
> +		return;
> +
> +	if (task != current && task->state == TASK_RUNNING)
> +		/*
> +		 * Showing held locks for a running task is unreliable, so just
> +		 * skip this. The printed locks are very likely inconsistent,
> +		 * since the stack trace was obtained when the actual race
> +		 * occurred and the task has since continued execution. Since we
> +		 * cannot display the below information from the racing thread,
> +		 * but must print it all from the watcher thread, bail out.
> +		 * Note: Even if the task is not running, there is a chance that
> +		 * the locks held may be inconsistent.
> +		 */
> +		return;
> +
> +	pr_err("\n");
> +	debug_show_held_locks(task);
> +	print_irqtrace_events(task);
> +}
> +
>  /*
>   * Returns true if a report was generated, false otherwise.
>   */
> @@ -319,6 +344,26 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
>  				  other_info.num_stack_entries - other_skipnr,
>  				  0);
>  
> +		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE) && other_info.task_pid != -1) {
> +			struct task_struct *other_task;
> +
> +			/*
> +			 * Rather than passing @current from the other task via
> +			 * @other_info, obtain task_struct here. The problem
> +			 * with passing @current via @other_info is that, we
> +			 * would have to get_task_struct/put_task_struct, and if
> +			 * we race with a task being released, we would have to
> +			 * release it in release_report(). This may result in
> +			 * deadlock if we want to use KCSAN on the allocators.
> +			 * Instead, make this best-effort, and if the task was
> +			 * already released, we just do not print anything here.
> +			 */
> +			rcu_read_lock();
> +			other_task = find_task_by_pid_ns(other_info.task_pid, &init_pid_ns);
> +			print_verbose_info(other_task);
> +			rcu_read_unlock();
> +		}
> +
>  		pr_err("\n");
>  		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
>  		       get_access_type(access_type), ptr, size,
> @@ -340,6 +385,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
>  	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
>  			  0);
>  
> +	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> +		print_verbose_info(current);
> +
>  	/* Print report footer. */
>  	pr_err("\n");
>  	pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index f0b791143c6ab..ba9268076cfbc 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -20,6 +20,19 @@ menuconfig KCSAN
>  
>  if KCSAN
>  
> +config KCSAN_VERBOSE
> +	bool "Show verbose reports with more information about system state"
> +	depends on PROVE_LOCKING
> +	help
> +	  If enabled, reports show more information about the system state that
> +	  may help better analyze and debug races. This includes held locks and
> +	  IRQ trace events.
> +
> +	  While this option should generally be benign, we call into more
> +	  external functions on report generation; if a race report is
> +	  generated from any one of them, system stability may suffer due to
> +	  deadlocks or recursion.  If in doubt, say N.
> +
>  config KCSAN_DEBUG
>  	bool "Debugging of KCSAN internals"
>  
