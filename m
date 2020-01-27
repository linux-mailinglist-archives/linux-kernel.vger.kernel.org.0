Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3109014A5A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 15:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgA0ODx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 09:03:53 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:52500 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbgA0ODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:03:53 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 3262F2E132A;
        Mon, 27 Jan 2020 17:03:48 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id g8yqaSIic3-3lOqKg1F;
        Mon, 27 Jan 2020 17:03:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1580133828; bh=qWGY/DFq1WV3XiEVxkOBRd4Ym1/RUVz7z/VUuSydAOw=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=E+LE1eShgHHb9insi9I6DRQUvEzYHi1Q/WHBHZNOEczqLDPwA3KGiRXDK1C3m2rK/
         W21o6VK4Hzrgtqp2B3oXO1+qm3IbGBDgMQkOpxS/GAwkXfXkH5LVf/wQjiVonAe+Rk
         s41U/zgmbY8lCtMqx3G7v5pr0qT00vzUjoQcELC8=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id VxjLkPdJIZ-3lWKv05v;
        Mon, 27 Jan 2020 17:03:47 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 3/3] kernel: add sysctl kernel.nr_taints
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 27 Jan 2020 17:03:46 +0300
Message-ID: <158013382685.1528.9104840938958957505.stgit@buzz>
In-Reply-To: <158013382063.1528.13355932625960922673.stgit@buzz>
References: <158013382063.1528.13355932625960922673.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raised taint flag is never cleared. Following taint could be detected only
via parsing kernel log messages which are different for each occasion.

For repeatable taints like TAINT_MACHINE_CHECK, TAINT_BAD_PAGE, TAINT_DIE,
TAINT_WARN, TAINT_LOCKUP it would be good to know count to see their rate.

This patch adds sysctl with vector of counters. One for each taint flag.
Counters are non-atomic in favor of simplicity. Exact count doesn't matter.

Writing vector of zeroes resets counters:
# tr 1-9 0 < /proc/sys/kernel/nr_taints > /proc/sys/kernel/nr_taints

This is useful for detecting frequent problems with automatic monitoring.
Also tests could use this for separating expected and unexpected taints.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: https://lore.kernel.org/lkml/157503370887.8187.1663761929323284758.stgit@buzz/ (v1)
---
 Documentation/admin-guide/sysctl/kernel.rst   |   10 ++++++++++
 Documentation/admin-guide/tainted-kernels.rst |   10 ++++++++++
 include/linux/kernel.h                        |    1 +
 kernel/panic.c                                |    5 +++++
 kernel/sysctl.c                               |    9 +++++++++
 5 files changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 8456c8ed0ca5..6250575bec9f 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -56,6 +56,7 @@ show up in /proc/sys/kernel:
 - msgmnb
 - msgmni
 - nmi_watchdog
+- nr_taints                   ==> Documentation/admin-guide/tainted-kernels.rst
 - osrelease
 - ostype
 - overflowgid
@@ -495,6 +496,15 @@ in a KVM virtual machine. This default can be overridden by adding::
 to the guest kernel command line (see Documentation/admin-guide/kernel-parameters.rst).
 
 
+nr_taints:
+==========
+
+This shows vector of counters for taint flags.
+Writing vector of zeroes resets counters.
+
+See Documentation/admin-guide/tainted-kernels.rst for more information.
+
+
 numa_balancing:
 ===============
 
diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 13249240283c..2c5181d5e8ae 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -166,3 +166,13 @@ More detailed explanation for tainting
      produce extremely unusual kernel structure layouts (even performance
      pathological ones), which is important to know when debugging. Set at
      build time.
+
+
+Taint flag counters
+-------------------
+
+For detecting repeatedly set taint flags kernel counts them in sysctl:
+``cat /proc/sys/kernel/nr_taints``
+
+Writing vector of zeros resets counters but not taint flags itself:
+``tr 1-9 0 < /proc/sys/kernel/nr_taints > /proc/sys/kernel/nr_taints``
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3554456b2d40..2e2c4d008ac1 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -597,6 +597,7 @@ struct taint_flag {
 };
 
 extern const struct taint_flag taint_flags[TAINT_FLAGS_COUNT];
+extern int sysctl_nr_taints[TAINT_FLAGS_COUNT];
 
 extern const char hex_asc[];
 #define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
diff --git a/kernel/panic.c b/kernel/panic.c
index a0ea0c6992b9..2e86387bbea0 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -39,6 +39,7 @@
 int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
 static unsigned long tainted_mask =
 	IS_ENABLED(CONFIG_GCC_PLUGIN_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
+int sysctl_nr_taints[TAINT_FLAGS_COUNT];
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
@@ -434,6 +435,10 @@ void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
 		pr_warn("Disabling lock debugging due to kernel taint\n");
 
 	set_bit(flag, &tainted_mask);
+
+	/* proc_taint() could set unknown taint flag */
+	if (flag < ARRAY_SIZE(sysctl_nr_taints))
+		sysctl_nr_taints[flag]++;
 }
 EXPORT_SYMBOL(add_taint);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 70665934d53e..21911a79305b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -553,6 +553,15 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_taint,
 	},
+	{
+		.procname	= "nr_taints",
+		.data		= &sysctl_nr_taints,
+		.maxlen		= sizeof(sysctl_nr_taints),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ZERO,
+	},
 	{
 		.procname	= "sysctl_writes_strict",
 		.data		= &sysctl_writes_strict,

