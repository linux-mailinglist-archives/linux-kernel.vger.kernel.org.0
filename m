Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82BC1478C0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 08:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgAXHDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 02:03:10 -0500
Received: from relay.sw.ru ([185.231.240.75]:53108 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgAXHDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:03:10 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iuszF-00085a-V4; Fri, 24 Jan 2020 10:02:38 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 0/7] seq_file .next functions should increase position index
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.com>, Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <244674e5-760c-86bd-d08a-047042881748@virtuozzo.com>
Date:   Fri, 24 Jan 2020 10:02:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Aug 2018 NeilBrown noticed 
commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
"Some ->next functions do not increment *pos when they return NULL...
Note that such ->next functions are buggy and should be fixed. 
A simple demonstration is
   
dd if=/proc/swaps bs=1000 skip=1
    
Choose any block size larger than the size of /proc/swaps.  This will
always show the whole last line of /proc/swaps"

Described problem is still actual. If you make lseek into middle of last output line 
following read will output end of last line and whole last line once again.

$ dd if=/proc/swaps bs=1  # usual output
Filename				Type		Size	Used	Priority
/dev/dm-0                               partition	4194812	97536	-2
104+0 records in
104+0 records out
104 bytes copied

$ dd if=/proc/swaps bs=40 skip=1    # last line was generated twice
dd: /proc/swaps: cannot skip to specified offset
v/dm-0                               partition	4194812	97536	-2
/dev/dm-0                               partition	4194812	97536	-2 
3+1 records in
3+1 records out
131 bytes copied

There are lot of other affected files, I've found 30+ including
/proc/net/ip_tables_matches and /proc/sysvipc/*

I've sent patches into maillists of affected subsystems already,
this patch-set fixes the problem in files related to 
pstore, tracing, gcov, sysvipc  and other subsystems processed 
via linux-kernel@ mailing list directly

https://bugzilla.kernel.org/show_bug.cgi?id=206283

Vasily Averin (7):
  pstore_ftrace_seq_next should increase position index
  gcov_seq_next should increase position index
  t_next should increase position index
  fpid_next should increase position index
  eval_map_next should increase position index
  trigger_next should increase position index
  sysvipc_find_ipc should increase position index

 fs/pstore/inode.c                   | 2 +-
 ipc/util.c                          | 2 +-
 kernel/gcov/fs.c                    | 2 +-
 kernel/trace/ftrace.c               | 9 ++++++---
 kernel/trace/trace.c                | 4 +---
 kernel/trace/trace_events_trigger.c | 5 +++--
 6 files changed, 13 insertions(+), 11 deletions(-)

-- 
1.8.3.1

