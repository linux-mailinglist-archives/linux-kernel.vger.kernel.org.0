Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF5F710AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 06:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbfGWEmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 00:42:55 -0400
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:34786 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730761AbfGWEmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 00:42:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 1793A1802912A;
        Tue, 23 Jul 2019 04:42:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:2:41:355:379:599:800:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1606:1730:1747:1777:1792:2196:2198:2199:2200:2393:2553:2559:2562:2828:2915:3138:3139:3140:3141:3142:3503:3504:3622:3865:3866:3867:3868:3870:3871:3872:3874:4117:4321:4385:4605:5007:8603:9163:10004:10848:10967:11026:11232:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:12986:13439:14096:14097:14659:21080:21433:21611:21627:21740:30012:30029:30034:30051:30054:30056:30062:30069:30079:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: sort64_8d7b5ff508a0e
X-Filterd-Recvd-Size: 6752
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jul 2019 04:42:52 +0000 (UTC)
Message-ID: <24bcbaee40a4174cb5d9fa876f88b2a1869a4870.camel@perches.com>
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Mon, 22 Jul 2019 21:42:51 -0700
In-Reply-To: <20190722213527.18deeaf07ae036cce57035ea@linux-foundation.org>
References: <cover.1563841972.git.joe@perches.com>
         <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
         <20190722213527.18deeaf07ae036cce57035ea@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-22 at 21:35 -0700, Andrew Morton wrote:
> On Mon, 22 Jul 2019 17:38:15 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > Several uses of strlcpy and strscpy have had defects because the
> > last argument of each function is misused or typoed.
> > 
> > Add macro mechanisms to avoid this defect.
> > 
> > stracpy (copy a string to a string array) must have a string
> > array as the first argument (to) and uses sizeof(to) as the
> > size.
> > 
> > These mechanisms verify that the to argument is an array of
> > char or other compatible types like u8 or unsigned char.
> > 
> > A BUILD_BUG is emitted when the type of to is not compatible.
> > 
> 
> It would be nice to include some conversions.  To demonstrate the need,
> to test the code, etc.

How about all the kernel/ ?
---
 kernel/acct.c                  | 2 +-
 kernel/cgroup/cgroup-v1.c      | 3 +--
 kernel/debug/gdbstub.c         | 4 ++--
 kernel/debug/kdb/kdb_support.c | 2 +-
 kernel/events/core.c           | 4 ++--
 kernel/module.c                | 2 +-
 kernel/printk/printk.c         | 2 +-
 kernel/time/clocksource.c      | 2 +-
 8 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 81f9831a7859..5ad29248b654 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -425,7 +425,7 @@ static void fill_ac(acct_t *ac)
 	memset(ac, 0, sizeof(acct_t));
 
 	ac->ac_version = ACCT_VERSION | ACCT_BYTEORDER;
-	strlcpy(ac->ac_comm, current->comm, sizeof(ac->ac_comm));
+	stracpy(ac->ac_comm, current->comm);
 
 	/* calculate run_time in nsec*/
 	run_time = ktime_get_ns();
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 88006be40ea3..dd4f041e4179 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -571,8 +571,7 @@ static ssize_t cgroup_release_agent_write(struct kernfs_open_file *of,
 	if (!cgrp)
 		return -ENODEV;
 	spin_lock(&release_agent_path_lock);
-	strlcpy(cgrp->root->release_agent_path, strstrip(buf),
-		sizeof(cgrp->root->release_agent_path));
+	stracpy(cgrp->root->release_agent_path, strstrip(buf));
 	spin_unlock(&release_agent_path_lock);
 	cgroup_kn_unlock(of->kn);
 	return nbytes;
diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index 4b280fc7dd67..a263f27f51ad 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -1095,10 +1095,10 @@ int gdbstub_state(struct kgdb_state *ks, char *cmd)
 		return error;
 	case 's':
 	case 'c':
-		strscpy(remcom_in_buffer, cmd, sizeof(remcom_in_buffer));
+		stracpy(remcom_in_buffer, cmd);
 		return 0;
 	case '$':
-		strscpy(remcom_in_buffer, cmd, sizeof(remcom_in_buffer));
+		stracpy(remcom_in_buffer, cmd);
 		gdbstub_use_prev_in_buf = strlen(remcom_in_buffer);
 		gdbstub_prev_in_buf_pos = 0;
 		return 0;
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index b8e6306e7e13..b49b6c3976c7 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -192,7 +192,7 @@ int kallsyms_symbol_complete(char *prefix_name, int max_len)
 
 	while ((name = kdb_walk_kallsyms(&pos))) {
 		if (strncmp(name, prefix_name, prefix_len) == 0) {
-			strscpy(ks_namebuf, name, sizeof(ks_namebuf));
+			stracpy(ks_namebuf, name);
 			/* Work out the longest name that matches the prefix */
 			if (++number == 1) {
 				prev_len = min_t(int, max_len-1,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 026a14541a38..25bd8c777270 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7049,7 +7049,7 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 	unsigned int size;
 
 	memset(comm, 0, sizeof(comm));
-	strlcpy(comm, comm_event->task->comm, sizeof(comm));
+	stracpy(comm, comm_event->task->comm);
 	size = ALIGN(strlen(comm)+1, sizeof(u64));
 
 	comm_event->comm = comm;
@@ -7394,7 +7394,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	}
 
 cpy_name:
-	strlcpy(tmp, name, sizeof(tmp));
+	stracpy(tmp, name);
 	name = tmp;
 got_name:
 	/*
diff --git a/kernel/module.c b/kernel/module.c
index 5933395af9a0..39384b0c90b8 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1021,7 +1021,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	async_synchronize_full();
 
 	/* Store the name of the last unloaded module for diagnostic purposes */
-	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
+	stracpy(last_unloaded_module, mod->name);
 
 	free_module(mod);
 	return 0;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 424abf802f02..029633052be4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2127,7 +2127,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 		return -E2BIG;
 	if (!brl_options)
 		preferred_console = i;
-	strlcpy(c->name, name, sizeof(c->name));
+	stracpy(c->name, name);
 	c->options = options;
 	braille_set_options(c, brl_options);
 
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index fff5f64981c6..f0c833d89ace 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1203,7 +1203,7 @@ static int __init boot_override_clocksource(char* str)
 {
 	mutex_lock(&clocksource_mutex);
 	if (str)
-		strlcpy(override_name, str, sizeof(override_name));
+		stracpy(override_name, str);
 	mutex_unlock(&clocksource_mutex);
 	return 1;
 }


