Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A171685BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 18:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgBUR6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 12:58:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38841 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBUR6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:58:49 -0500
Received: by mail-ot1-f68.google.com with SMTP id z9so2785964oth.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02nz5IY2LDSzsi6Uwi52GMpeaKEGb8jSNiWMvCCts+g=;
        b=Wsv50n8Q9c9FO9EmNBmQOtFrLHiCL1ewuU16RjFVw6klebZY725b8j5BAv8N6Vwj0J
         sMvP2NGGk5Xh3vofbSSJtcTtIbkOudT1vMKDWYQCEsZ4QvXlNyRidAC5Ok3xyJFzoXeG
         EM24RX+BP0APhts8JGOywYa5e5T+R0MthuIESWOkGX5zAhQ4v+fGwLtB/iE/wBUN2j2+
         QPNY/099g7BpMpx7gs4qnbDrGVLEUlNUAARBq5sfy5dWAzphI/RDEJto7uVqPoyoari7
         ZPOKPiCl2CqggebttO9roTZ1S+jV0TpRLl1zSLKiqQKatK9SNrkbBZtcXK58ojXBTcBj
         gySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02nz5IY2LDSzsi6Uwi52GMpeaKEGb8jSNiWMvCCts+g=;
        b=lhLGHYrJndJiBrZG8xgmR/upcQw2B4JxGFUsXBkNP/nXjs6res9l1h9n07M/r+zQEh
         pAKhfe4nDQk0SzoTkN3etLSaAgXiy9TpYdi5UWZZ3bjbACi9a0KQmzV/CYjxWtXGBCxt
         XRtpP3b16yClbQe+DeyN2hBjtSHCs35CE4ZrE9ulw+ePS3QgOgMiHJwHgGWznaodvjFz
         uUShqrorlzvQMdjRWj/4I00KT/11vRwXmIm2l7vFC09O5z+8Eo8++sRYwfaPMuMSnKZP
         JS4QVfCvlwNeAWDZh34ixPO+b16Hx5rqGV8ezBVR8pnDzGwWSfZmMiMkBmJGH9KUSGhn
         Ldqw==
X-Gm-Message-State: APjAAAX/DXne9C7pCvDwL4lRyEns6gCorbkWdF8LJoEbNbcHQs4KM689
        tPCdyUeNtbkhk1VgE0uWmMG13Z37PEzI3sHzZWyq1w==
X-Google-Smtp-Source: APXvYqyTQpLKn5mk9pVf4ftGL846zu9cQ5dx4FwkJ7BtEMT7Fyn5KWCXiAcoZfE44n5b1v+b5nvpdfK5NbPxSBv2pPQ=
X-Received: by 2002:a05:6830:1d7b:: with SMTP id l27mr27496908oti.251.1582307927408;
 Fri, 21 Feb 2020 09:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20200219151531.161515-1-elver@google.com> <1582305008.7365.111.camel@lca.pw>
In-Reply-To: <1582305008.7365.111.camel@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Fri, 21 Feb 2020 18:58:36 +0100
Message-ID: <CANpmjNMG4nZYLi+wFR-R_ifq1+u-YfC7b68iucCRWNd4M==vrw@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Add option for verbose reporting
To:     Qian Cai <cai@lca.pw>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 at 18:10, Qian Cai <cai@lca.pw> wrote:
>
> On Wed, 2020-02-19 at 16:15 +0100, Marco Elver wrote:
> > Adds CONFIG_KCSAN_VERBOSE to optionally enable more verbose reports.
> > Currently information about the reporting task's held locks and IRQ
> > trace events are shown, if they are enabled.
>
> Well, there is a report. I don't understand why it said there is no lock held in
> the writer, but clearly there is this right after in
> jbd2_journal_commit_transaction(),
>
>  spin_unlock(&jh->b_state_lock);

This is sort of expected right now.  In the comment that adds this
feature, it also has a comment for the "other thread" (in this case
the writer):

/*
* Showing held locks for a running task is unreliable, so just
* skip this. The printed locks are very likely inconsistent,
* since the stack trace was obtained when the actual race
* occurred and the task has since continued execution. Since we
* cannot display the below information from the racing thread,
* but must print it all from the watcher thread, bail out.
* Note: Even if the task is not running, there is a chance that
* the locks held may be inconsistent.
*/

Hmm, I suppose I could try harder and make this reliable by stalling
the other task if this option is on. Let me give that a try.

Thanks,
-- Marco


> [ 2268.021382][T25724] BUG: KCSAN: data-race in __jbd2_journal_refile_buffer
> [jbd2] / jbd2_write_access_granted [jbd2]
> [ 2268.031888][T25724]
> [ 2268.034099][T25724] write to 0xffff99f9b1bd0e30 of 8 bytes by task 25721 on
> cpu 70:
> [ 2268.041842][T25724]  __jbd2_journal_refile_buffer+0xdd/0x210 [jbd2]
> __jbd2_journal_refile_buffer at fs/jbd2/transaction.c:2569
> [ 2268.048181][T25724]  jbd2_journal_commit_transaction+0x2d15/0x3f20 [jbd2]
> (inlined by) jbd2_journal_commit_transaction at fs/jbd2/commit.c:1033
> [ 2268.055042][T25724]  kjournald2+0x13b/0x450 [jbd2]
> [ 2268.059876][T25724]  kthread+0x1cd/0x1f0
> [ 2268.063835][T25724]  ret_from_fork+0x27/0x50
> [ 2268.068143][T25724]
> [ 2268.070348][T25724] no locks held by jbd2/loop0-8/25721.
> [ 2268.075699][T25724] irq event stamp: 77604
> [ 2268.079830][T25724] hardirqs last  enabled at (77603): [<ffffffff986da853>]
> _raw_spin_unlock_irqrestore+0x53/0x60
> [ 2268.090166][T25724] hardirqs last disabled at (77604): [<ffffffff986d0841>]
> __schedule+0x181/0xa50
> [ 2268.099192][T25724] softirqs last  enabled at (76092): [<ffffffff98a0034c>]
> __do_softirq+0x34c/0x57c
> [ 2268.108392][T25724] softirqs last disabled at (76005): [<ffffffff97cc67a2>]
> irq_exit+0xa2/0xc0
> [ 2268.117062][T25724]
> [ 2268.119269][T25724] read to 0xffff99f9b1bd0e30 of 8 bytes by task 25724 on
> cpu 68:
> [ 2268.126916][T25724]  jbd2_write_access_granted+0x1b2/0x250 [jbd2]
> jbd2_write_access_granted at fs/jbd2/transaction.c:1155
> [ 2268.133086][T25724]  jbd2_journal_get_write_access+0x2c/0x60 [jbd2]
> [ 2268.139492][T25724]  __ext4_journal_get_write_access+0x50/0x90 [ext4]
> [ 2268.146076][T25724]  ext4_mb_mark_diskspace_used+0x158/0x620 [ext4]
> [ 2268.152507][T25724]  ext4_mb_new_blocks+0x54f/0xca0 [ext4]
> [ 2268.158125][T25724]  ext4_ind_map_blocks+0xc79/0x1b40 [ext4]
> [ 2268.163923][T25724]  ext4_map_blocks+0x3b4/0x950 [ext4]
> [ 2268.169284][T25724]  _ext4_get_block+0xfc/0x270 [ext4]
> [ 2268.174556][T25724]  ext4_get_block+0x3b/0x50 [ext4]
> [ 2268.179566][T25724]  __block_write_begin_int+0x22e/0xae0
> [ 2268.184921][T25724]  __block_write_begin+0x39/0x50
> [ 2268.189842][T25724]  ext4_write_begin+0x388/0xb50 [ext4]
> [ 2268.195195][T25724]  generic_perform_write+0x15d/0x290
> [ 2268.200467][T25724]  ext4_buffered_write_iter+0x11f/0x210 [ext4]
> [ 2268.206612][T25724]  ext4_file_write_iter+0xce/0x9e0 [ext4]
> [ 2268.212228][T25724]  new_sync_write+0x29c/0x3b0
> [ 2268.216794][T25724]  __vfs_write+0x92/0xa0
> [ 2268.220924][T25724]  vfs_write+0x103/0x260
> [ 2268.225052][T25724]  ksys_write+0x9d/0x130
> [ 2268.229182][T25724]  __x64_sys_write+0x4c/0x60
> [ 2268.233666][T25724]  do_syscall_64+0x91/0xb05
> [ 2268.238058][T25724]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 2268.243846][T25724]
> [ 2268.246056][T25724] 5 locks held by fsync04/25724:
> [ 2268.250880][T25724]  #0: ffff99f9911093f8 (sb_writers#13){.+.+}, at:
> vfs_write+0x21c/0x260
> [ 2268.259211][T25724]  #1: ffff99f9db4c0348 (&sb->s_type-
> >i_mutex_key#15){+.+.}, at: ext4_buffered_write_iter+0x65/0x210 [ext4]
> [ 2268.270693][T25724]  #2: ffff99f5e7dfcf58 (jbd2_handle){++++}, at:
> start_this_handle+0x1c1/0x9d0 [jbd2]
> [ 2268.280180][T25724]  #3: ffff99f9db4c0168 (&ei->i_data_sem){++++}, at:
> ext4_map_blocks+0x176/0x950 [ext4]
> [ 2268.289913][T25724]  #4: ffffffff99086b40 (rcu_read_lock){....}, at:
> jbd2_write_access_granted+0x4e/0x250 [jbd2]
> [ 2268.300187][T25724] irq event stamp: 1407125
> [ 2268.304496][T25724] hardirqs last  enabled at (1407125): [<ffffffff980da9b7>]
> __find_get_block+0x107/0x790
> [ 2268.314218][T25724] hardirqs last disabled at (1407124): [<ffffffff980da8f9>]
> __find_get_block+0x49/0x790
> [ 2268.323856][T25724] softirqs last  enabled at (1405528): [<ffffffff98a0034c>]
> __do_softirq+0x34c/0x57c
> [ 2268.333229][T25724] softirqs last disabled at (1405521): [<ffffffff97cc67a2>]
> irq_exit+0xa2/0xc0
> [ 2268.342075][T25724]
> [ 2268.344282][T25724] Reported by Kernel Concurrency Sanitizer on:
> [ 2268.350339][T25724] CPU: 68 PID: 25724 Comm: fsync04 Tainted:
> G             L    5.6.0-rc2-next-20200221+ #7
> [ 2268.360234][T25724] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385
> Gen10, BIOS A40 07/10/2019
>
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Suggested-by: Qian Cai <cai@lca.pw>
> > ---
> >  kernel/kcsan/report.c | 48 +++++++++++++++++++++++++++++++++++++++++++
> >  lib/Kconfig.kcsan     | 13 ++++++++++++
> >  2 files changed, 61 insertions(+)
> >
> > diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> > index 11c791b886f3c..f14becb6f1537 100644
> > --- a/kernel/kcsan/report.c
> > +++ b/kernel/kcsan/report.c
> > @@ -1,10 +1,12 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> > +#include <linux/debug_locks.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/kernel.h>
> >  #include <linux/lockdep.h>
> >  #include <linux/preempt.h>
> >  #include <linux/printk.h>
> > +#include <linux/rcupdate.h>
> >  #include <linux/sched.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/stacktrace.h>
> > @@ -245,6 +247,29 @@ static int sym_strcmp(void *addr1, void *addr2)
> >       return strncmp(buf1, buf2, sizeof(buf1));
> >  }
> >
> > +static void print_verbose_info(struct task_struct *task)
> > +{
> > +     if (!task)
> > +             return;
> > +
> > +     if (task != current && task->state == TASK_RUNNING)
> > +             /*
> > +              * Showing held locks for a running task is unreliable, so just
> > +              * skip this. The printed locks are very likely inconsistent,
> > +              * since the stack trace was obtained when the actual race
> > +              * occurred and the task has since continued execution. Since we
> > +              * cannot display the below information from the racing thread,
> > +              * but must print it all from the watcher thread, bail out.
> > +              * Note: Even if the task is not running, there is a chance that
> > +              * the locks held may be inconsistent.
> > +              */
> > +             return;
> > +
> > +     pr_err("\n");
> > +     debug_show_held_locks(task);
> > +     print_irqtrace_events(task);
> > +}
> > +
> >  /*
> >   * Returns true if a report was generated, false otherwise.
> >   */
> > @@ -319,6 +344,26 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
> >                                 other_info.num_stack_entries - other_skipnr,
> >                                 0);
> >
> > +             if (IS_ENABLED(CONFIG_KCSAN_VERBOSE) && other_info.task_pid != -1) {
> > +                     struct task_struct *other_task;
> > +
> > +                     /*
> > +                      * Rather than passing @current from the other task via
> > +                      * @other_info, obtain task_struct here. The problem
> > +                      * with passing @current via @other_info is that, we
> > +                      * would have to get_task_struct/put_task_struct, and if
> > +                      * we race with a task being released, we would have to
> > +                      * release it in release_report(). This may result in
> > +                      * deadlock if we want to use KCSAN on the allocators.
> > +                      * Instead, make this best-effort, and if the task was
> > +                      * already released, we just do not print anything here.
> > +                      */
> > +                     rcu_read_lock();
> > +                     other_task = find_task_by_pid_ns(other_info.task_pid, &init_pid_ns);
> > +                     print_verbose_info(other_task);
> > +                     rcu_read_unlock();
> > +             }
> > +
> >               pr_err("\n");
> >               pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
> >                      get_access_type(access_type), ptr, size,
> > @@ -340,6 +385,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
> >       stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
> >                         0);
> >
> > +     if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> > +             print_verbose_info(current);
> > +
> >       /* Print report footer. */
> >       pr_err("\n");
> >       pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
> > diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> > index f0b791143c6ab..ba9268076cfbc 100644
> > --- a/lib/Kconfig.kcsan
> > +++ b/lib/Kconfig.kcsan
> > @@ -20,6 +20,19 @@ menuconfig KCSAN
> >
> >  if KCSAN
> >
> > +config KCSAN_VERBOSE
> > +     bool "Show verbose reports with more information about system state"
> > +     depends on PROVE_LOCKING
> > +     help
> > +       If enabled, reports show more information about the system state that
> > +       may help better analyze and debug races. This includes held locks and
> > +       IRQ trace events.
> > +
> > +       While this option should generally be benign, we call into more
> > +       external functions on report generation; if a race report is
> > +       generated from any one of them, system stability may suffer due to
> > +       deadlocks or recursion.  If in doubt, say N.
> > +
> >  config KCSAN_DEBUG
> >       bool "Debugging of KCSAN internals"
> >
