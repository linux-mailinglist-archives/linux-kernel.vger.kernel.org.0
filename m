Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39D719B583
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 20:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbgDASbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 14:31:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:5040 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732316AbgDASa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:30:59 -0400
IronPort-SDR: i285Qq+YQYgVWafNweVX1IrQg3WrA3onyjFM873HV2phugeu/iVo8Rew+qpIsWlzx2A6oYAw9J
 hPHqIUBYEPfg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 11:30:58 -0700
IronPort-SDR: tnndSZF9txte6F/9oSlc03r0JHMTicmx8nQxyAdDlE0hzEQ8UuRWOj5bLNbppg3Q/X868un7jN
 LgVLo/ESuGag==
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="249552585"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 11:30:57 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] x86/resctrl: Use appropriate API for strings terminated by newline
Date:   Wed,  1 Apr 2020 11:30:48 -0700
Message-Id: <2a51c327497738ad7012e4f185046c530dba4594.1585765499.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1585765499.git.reinette.chatre@intel.com>
References: <cover.1585765499.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user input to files in the resctrl filesystem are expected to be
terminated with a newline. Testing the user input includes a test for
the presence of a newline and then replacing the newline with NUL
byte followed by comparison using strcmp().

sysfs_streq() exists to test if strings are equal, treating both NUL and
newline-then-NUL as equivalent string terminations. Even more,
sysfs_match_string() exists to match a given string in an array using
sysfs_streq().

Replace existing strcmp() comparisons of strings that are terminated
with a newline with more appropriate sysfs_streq() via the
sysfs_match_string() API that can perform the match across the different
mode strings that are already maintained in an array.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index fbee891a7d6e..623e33c0a290 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1412,11 +1412,11 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 	struct rdtgroup *rdtgrp;
 	enum rdtgrp_mode mode;
 	int ret = 0;
+	int user_m;
 
 	/* Valid input requires a trailing newline */
 	if (nbytes == 0 || buf[nbytes - 1] != '\n')
 		return -EINVAL;
-	buf[nbytes - 1] = '\0';
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
@@ -1428,11 +1428,15 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 
 	mode = rdtgrp->mode;
 
-	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
-	    (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE) ||
-	    (!strcmp(buf, "pseudo-locksetup") &&
-	     mode == RDT_MODE_PSEUDO_LOCKSETUP) ||
-	    (!strcmp(buf, "pseudo-locked") && mode == RDT_MODE_PSEUDO_LOCKED))
+	user_m = sysfs_match_string(rdt_mode_str, buf);
+	if (user_m < 0) {
+		rdt_last_cmd_puts("Unknown or unsupported mode\n");
+		ret = user_m;
+		goto out;
+	}
+
+	/* Do nothing and return success if user asks for current mode */
+	if (user_m == mode)
 		goto out;
 
 	if (mode == RDT_MODE_PSEUDO_LOCKED) {
@@ -1441,14 +1445,14 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 		goto out;
 	}
 
-	if (!strcmp(buf, "shareable")) {
+	if (user_m == RDT_MODE_SHAREABLE) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			ret = rdtgroup_locksetup_exit(rdtgrp);
 			if (ret)
 				goto out;
 		}
 		rdtgrp->mode = RDT_MODE_SHAREABLE;
-	} else if (!strcmp(buf, "exclusive")) {
+	} else if (user_m == RDT_MODE_EXCLUSIVE) {
 		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
 			ret = -EINVAL;
 			goto out;
@@ -1459,14 +1463,11 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 				goto out;
 		}
 		rdtgrp->mode = RDT_MODE_EXCLUSIVE;
-	} else if (!strcmp(buf, "pseudo-locksetup")) {
+	} else if (user_m == RDT_MODE_PSEUDO_LOCKSETUP) {
 		ret = rdtgroup_locksetup_enter(rdtgrp);
 		if (ret)
 			goto out;
 		rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
-	} else {
-		rdt_last_cmd_puts("Unknown or unsupported mode\n");
-		ret = -EINVAL;
 	}
 
 out:
-- 
2.21.0

