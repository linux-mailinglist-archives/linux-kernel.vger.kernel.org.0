Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 107D3134699
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgAHPpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:45:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:42398 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgAHPpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:45:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 07:45:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="246375213"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jan 2020 07:44:59 -0800
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH] x86/resctrl: Take care of PF_EXITING task in callback
Date:   Thu,  9 Jan 2020 00:13:46 +0800
Message-Id: <1578500026-21152-1-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When writing a pid to file "tasks", a callback function move_myself()
is queued to this task to be called when the task returns from kernel
mode or exits. The purpose of move_myself() is to activate the newly
assigned closid and/or rmid associated with this task. This activation
is done by calling resctrl_sched_in() from move_myself(), the same
function that is called when switching to this task.

If this work is successfully queued but then the task enters PF_EXITING
status (e.g., receiving signal SIGKILL, SIGTERM) prior to the execution
of the callback move_myself() then move_myself() still calls
resctrl_sched_in() since the task status is not currently considered.

When a task is exiting then the data structure of the task itself will
be freed soon, calling resctrl_sched_in() to write the register that
control's the task's resources is unnecessary and it implies extra
performance overhead.

Add check on task status in move_myself() and return immediately if the
task is PF_EXITING.

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2e3b06d6bbc6..205925d802d8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -532,11 +532,15 @@ static void move_myself(struct callback_head *head)
 		kfree(rdtgrp);
 	}
 
+	if (unlikely(current->flags & PF_EXITING))
+		goto out;
+
 	preempt_disable();
 	/* update PQR_ASSOC MSR to make resource group go into effect */
 	resctrl_sched_in();
 	preempt_enable();
 
+out:
 	kfree(callback);
 }
 
-- 
1.8.3.1

