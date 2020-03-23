Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0812918ED66
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 00:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgCVX6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 19:58:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34564 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgCVX6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 19:58:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id 26so7763757wmk.1;
        Sun, 22 Mar 2020 16:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1u2HajMxZOO6lE3B4pGCCJXeMZ2tGYJNbbDaBEbx78k=;
        b=GtuufJqUGYQuK+2KOFVYtmop0mIuOSghHCK/Vy2XlIs3+vIsXt/3Dbz5wkhN+RsMwd
         VU1ejr2sP3SZETD28w0b5MFRJiZQ8O8clrjMsMxywRH6b1aLwm/ObKfnSm4tm6vKsF93
         8sfxHW4esKSKxRdoa4FgusmbczqF706Zj2AsLYIdLSaQVHyedJi45SbQhmqZk7tu4b7R
         nDJ+XuXraJCz6KkSb5UOQcbSAIAqkISvO8hp8nOGqmWqYCsrvYgcEeK48l/+j4Hk2LCV
         IOKQyLRtqU4mR8L95j6AxTfS28Ze6sYVfsB2gCFIcAueFoS368a1OfnWkPePMOtolugg
         aorw==
X-Gm-Message-State: ANhLgQ2FeHYJKfA6DAX2CMDlT4IgJ32H4sPwWoehN6pu3KqkzJ4869jk
        gKqICwORwhpMSKDS5W8FbbLj8K7N0ezVT+X0FK4=
X-Google-Smtp-Source: ADFU+vuG4vP7sG0Mn7MpGkfnSOWY0b9bDeHUuSd5ib/JzQ2EReiHixDYZyjKzSOP5C0zYWDEtKdO/s5RaaBfjTy17D0=
X-Received: by 2002:a1c:4684:: with SMTP id t126mr8192483wma.128.1584921495984;
 Sun, 22 Mar 2020 16:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200224043749.69466-1-namhyung@kernel.org>
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 23 Mar 2020 08:58:04 +0900
Message-ID: <CAM9d7chneHzibiQFopmN1rED=mf-nBpy58kauXWSOSYy2zCtzQ@mail.gmail.com>
Subject: Re: [PATCHSET 00/10] perf: Improve cgroup profiling (v5)
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter, Tejun and folks.

Do you have any other comments on the kernel side?
If not, can I get your Ack?

Thanks
Namhyung


On Mon, Feb 24, 2020 at 1:37 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> This work is to improve cgroup profiling in perf.  Currently it only
> supports profiling tasks in a specific cgroup and there's no way to
> identify which cgroup the current sample belongs to.  So I added
> PERF_SAMPLE_CGROUP to add cgroup id into each sample.  It's a 64-bit
> integer having file handle of the cgroup.  And kernel also generates
> PERF_RECORD_CGROUP event for new groups to correlate the cgroup id and
> cgroup name (path in the cgroup filesystem).  The cgroup id can be
> read from userspace by name_to_handle_at() system call so it can
> synthesize the CGROUP event for existing groups.
>
> So why do we want this?  Systems running a large number of jobs in
> different cgroups want to profiling such jobs precisely. This includes
> container hosting systems widely used today. Currently perf supports
> namespace tracking but the systems may not use (cgroup) namespace for
> their jobs. Also it'd be more intuitive to see cgroup names (as
> they're given by user or sysadmin) rather than numeric
> cgroup/namespace id even if they use the namespaces.
>
> From Stephane Eranian:
> > In data centers you care about attributing samples to a job not such
> > much to a process.  A job may have multiple processes which may come
> > and go. The cgroup on the other hand stays around for the entire
> > lifetime of the job. It is much easier to map a cgroup name to a
> > particular job than it is to map a pid back to a job name,
> > especially for offline post-processing.
>
> Note that this only works for "perf_event" cgroups (obviously) so if
> users are still using cgroup-v1 interface, they need to have same
> hierarchy for subsystem(s) want to profile with it.
>
>  * Changes from v4:
>   - use CONFIG_CGROUP_PERF
>   - move cgroup tree to perf_env
>   - move cgroup fs utility function to tools/lib/api/fs
>   - use a local buffer and check its size for cgroup systhesis
>
>  * Changes from v3:
>   - staticize perf_event_cgroup()
>   - fix sample parsing test
>
>  * Changes from v2:
>   - remove path_len from cgroup_event
>   - bail out if kernel doesn't support cgroup sampling
>   - add some description in the Kconfig
>
>  * Changes from v1:
>   - use new cgroup id (= file handle)
>
> The code is available at perf/cgroup-v5 branch in
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
>
> The testing result looks something like this:
>
>   [root@qemu build]# ./perf record --all-cgroups ./cgtest
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.009 MB perf.data (150 samples) ]
>
>   [root@qemu build]# ./perf report -s cgroup,comm --stdio
>   # To display the perf.data header info, please use --header/--header-only options.
>   #
>   #
>   # Total Lost Samples: 0
>   #
>   # Samples: 150  of event 'cpu-clock:pppH'
>   # Event count (approx.): 37500000
>   #
>   # Overhead  cgroup      Command
>   # ........  ..........  .......
>   #
>       32.00%  /sub/cgrp2  looper2
>       28.00%  /sub/cgrp1  looper1
>       25.33%  /sub        looper0
>        4.00%  /           cgtest
>        4.00%  /sub        cgtest
>        3.33%  /sub/cgrp2  cgtest
>        2.67%  /sub/cgrp1  cgtest
>        0.67%  /           looper0
>
>
> The test program (cgtest) follows.
>
> Thanks,
> Namhyung
>
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
>
>
> -------8<-----------------------------------------8<----------------
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <sched.h>
> #include <errno.h>
> #include <sys/stat.h>
> #include <sys/wait.h>
> #include <sys/prctl.h>
> #include <sys/mount.h>
>
> char cgbase[] = "/sys/fs/cgroup/perf_event";
>
> void mkcgrp(char *name) {
>   char buf[256];
>
>   snprintf(buf, sizeof(buf), "%s%s", cgbase, name);
>   if (mkdir(buf, 0755) < 0)
>     perror("mkdir");
> }
>
> void rmcgrp(char *name) {
>   char buf[256];
>
>   snprintf(buf, sizeof(buf), "%s%s", cgbase, name);
>   if (rmdir(buf) < 0)
>     perror("rmdir");
> }
>
> void setcgrp(char *name) {
>   char buf[256];
>   int fd;
>
>   snprintf(buf, sizeof(buf), "%s%s/tasks", cgbase, name);
>
>   fd = open(buf, O_WRONLY);
>   if (fd > 0) {
>     if (write(fd, "0\n", 2) != 2)
>       perror("write");
>     close(fd);
>   }
> }
>
> void create_sub_cgroup(int idx) {
>   char buf[128];
>
>   snprintf(buf, sizeof(buf), "/sub/cgrp%d", idx);
>   mkcgrp(buf);
> }
>
> void remove_sub_cgroup(int idx) {
>   char buf[128];
>
>   snprintf(buf, sizeof(buf), "/sub/cgrp%d", idx);
>   rmcgrp(buf);
> }
>
> void set_sub_cgroup(int idx) {
>   char buf[128];
>
>   snprintf(buf, sizeof(buf), "/sub/cgrp%d", idx);
>   setcgrp(buf);
> }
>
> void set_task_name(int idx) {
>   char buf[16];
>
>   snprintf(buf, sizeof(buf), "looper%d", idx);
>   prctl(PR_SET_NAME, buf, 0, 0, 0);
> }
>
> void loop(unsigned max) {
>   volatile unsigned int count = 1;
>
>   while (count++ != max) {
>     asm volatile ("pause");
>   }
> }
>
> void worker(int idx, unsigned cnt, int new_ns) {
>   int oldns;
>
>   create_sub_cgroup(idx);
>   set_sub_cgroup(idx);
>
>   if (new_ns) {
>     if (unshare(CLONE_NEWCGROUP) < 0)
>       perror("unshare");
>
> #if 0  /* FIXME */
>     if (unshare(CLONE_NEWNS) < 0)
>       perror("unshare");
>
>     if (mount("none", "/sys", NULL, MS_REMOUNT | MS_REC | MS_SLAVE, NULL) < 0)
>       perror("mount --make-rslave");
>
>     sleep(1);
>     if (umount("/sys/fs/cgroup/perf_event") < 0)
>       perror("umount");
>
>     if (mount("cgroup", "/sys/fs/cgroup/perf_event", "cgroup",
>               MS_NODEV | MS_NOEXEC | MS_NOSUID, "perf_event") < 0)
>       perror("mount again");
> #endif
>   }
>
>   if (fork() == 0) {
>     set_task_name(idx);
>     loop(cnt);
>     exit(0);
>   }
>   wait(NULL);
> }
>
> int main(int argc, char *argv[])
> {
>   int i, nr = 2;
>   int new_ns = 1;
>   unsigned cnt = 1000000;
>   int fd;
>
>   if (argc > 1)
>     nr = atoi(argv[1]);
>   if (argc > 2)
>     cnt = atoi(argv[2]);
>   if (argc > 3)
>     new_ns = atoi(argv[3]);
>
>   mkcgrp("/sub");
>   setcgrp("/sub");
>
>   for (i = 0; i < nr; i++) {
>     if (fork() == 0) {
>       worker(i+1, cnt, new_ns);
>       exit(0);
>     }
>   }
>
>   set_task_name(0);
>   loop(cnt);
>
>   for (i = 0; i < nr; i++)
>     wait(NULL);
>
>   for (i = 0; i < nr; i++)
>     remove_sub_cgroup(i+1);
>
>   setcgrp("/");
>   rmcgrp("/sub");
>
>   return 0;
> }
> -------8<-----------------------------------------8<----------------
>
>
> Namhyung Kim (10):
>   perf/core: Add PERF_RECORD_CGROUP event
>   perf/core: Add PERF_SAMPLE_CGROUP feature
>   tools lib api fs: Move cgroupsfs__mountpoint()
>   perf tools: Basic support for CGROUP event
>   perf tools: Maintain cgroup hierarchy
>   perf report: Add 'cgroup' sort key
>   perf record: Support synthesizing cgroup events
>   perf record: Add --all-cgroups option
>   perf top: Add --all-cgroups option
>   perf script: Add --show-cgroup-events option
>
>  include/linux/perf_event.h                |   1 +
>  include/uapi/linux/perf_event.h           |  16 ++-
>  init/Kconfig                              |   3 +-
>  kernel/events/core.c                      | 133 ++++++++++++++++++++
>  tools/include/uapi/linux/perf_event.h     |  16 ++-
>  tools/lib/api/fs/Build                    |   1 +
>  tools/lib/api/fs/cgroup.c                 |  67 ++++++++++
>  tools/lib/api/fs/fs.h                     |   2 +
>  tools/lib/perf/include/perf/event.h       |   7 ++
>  tools/perf/Documentation/perf-record.txt  |   5 +-
>  tools/perf/Documentation/perf-report.txt  |   1 +
>  tools/perf/Documentation/perf-script.txt  |   3 +
>  tools/perf/Documentation/perf-top.txt     |   4 +
>  tools/perf/builtin-diff.c                 |   1 +
>  tools/perf/builtin-record.c               |  10 ++
>  tools/perf/builtin-report.c               |   1 +
>  tools/perf/builtin-script.c               |  41 +++++++
>  tools/perf/builtin-top.c                  |   9 ++
>  tools/perf/tests/sample-parsing.c         |   6 +-
>  tools/perf/util/cgroup.c                  | 143 +++++++++++++---------
>  tools/perf/util/cgroup.h                  |  18 ++-
>  tools/perf/util/env.c                     |   2 +
>  tools/perf/util/env.h                     |   6 +
>  tools/perf/util/event.c                   |  19 +++
>  tools/perf/util/event.h                   |   6 +
>  tools/perf/util/evsel.c                   |  17 ++-
>  tools/perf/util/evsel.h                   |   1 +
>  tools/perf/util/hist.c                    |  12 ++
>  tools/perf/util/hist.h                    |   1 +
>  tools/perf/util/machine.c                 |  19 +++
>  tools/perf/util/machine.h                 |   3 +
>  tools/perf/util/perf_event_attr_fprintf.c |   2 +
>  tools/perf/util/record.h                  |   1 +
>  tools/perf/util/session.c                 |   4 +
>  tools/perf/util/sort.c                    |  37 ++++++
>  tools/perf/util/sort.h                    |   2 +
>  tools/perf/util/synthetic-events.c        | 121 ++++++++++++++++++
>  tools/perf/util/synthetic-events.h        |   1 +
>  tools/perf/util/tool.h                    |   2 +
>  39 files changed, 671 insertions(+), 73 deletions(-)
>  create mode 100644 tools/lib/api/fs/cgroup.c
>
> --
> 2.25.0.265.gbab2e86ba0-goog
>
