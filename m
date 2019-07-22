Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41ECA6FD56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 12:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfGVKAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 06:00:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38651 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfGVKAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:00:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M9xZVD3770811
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 02:59:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M9xZVD3770811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563789577;
        bh=EhrryNSM8WuA+EsuxPC/i0WoETM6dkvWcpNCirchpHU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=b4RqDBnJydDt+NENaJWkRMsJECxt7SjJqzXp910pMTGvW8iUUqwKM6luYjhp5Folu
         67hFSKp25De8zqZBlYh4tYYK2xbR2nQ/ne0atXn615viaVaLMaP8fi59NR9LbF1YzM
         /lypv637luIhllui1VckSy9eECxJJoDN0Ich965jEGDXNXjIwWAcos3TimbZhXuZFZ
         k8aC0dE2flZ6W9niCG8AhGPhFdgysGlN8lJ0Tpfe/Tjuc8GT/H1of1T4y2XJ4HBpUK
         Naj+jyW14SI4jVDpnirir7IU0sgRuO28BjkZmkHmqxtiJ4T717j66/E4hsYPxOc2hz
         iUyFOj/jMokvg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M9xZhk3770808;
        Mon, 22 Jul 2019 02:59:35 -0700
Date:   Mon, 22 Jul 2019 02:59:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-f240652b6032b48ad7fa35c5e701cc4c8d697c0b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, dave.hansen@linux.intel.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190705175321.DB42F0AD@viggo.jf.intel.com>
References: <20190705175321.DB42F0AD@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/mpx: Remove MPX APIs
Git-Commit-ID: f240652b6032b48ad7fa35c5e701cc4c8d697c0b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f240652b6032b48ad7fa35c5e701cc4c8d697c0b
Gitweb:     https://git.kernel.org/tip/f240652b6032b48ad7fa35c5e701cc4c8d697c0b
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 5 Jul 2019 10:53:21 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 11:54:57 +0200

x86/mpx: Remove MPX APIs

MPX is being removed from the kernel due to a lack of support in the
toolchain going forward (gcc).

The first step is to remove the userspace-visible ABIs so that applications
will stop using it.  The most visible one are the enable/disable prctl()s.
Remove them first.

This is the most minimal and least invasive change needed to ensure that
apps stop using MPX with new kernels.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190705175321.DB42F0AD@viggo.jf.intel.com

---
 include/uapi/linux/prctl.h |  2 +-
 kernel/sys.c               | 16 ++--------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 094bb03b9cc2..961e0a4a0f73 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -181,7 +181,7 @@ struct prctl_mm_map {
 #define PR_GET_THP_DISABLE	42
 
 /*
- * Tell the kernel to start/stop helping userspace manage bounds tables.
+ * No longer implemented, but left here to ensure the numbers stay reserved:
  */
 #define PR_MPX_ENABLE_MANAGEMENT  43
 #define PR_MPX_DISABLE_MANAGEMENT 44
diff --git a/kernel/sys.c b/kernel/sys.c
index 2969304c29fe..384b000b7865 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -103,12 +103,6 @@
 #ifndef SET_TSC_CTL
 # define SET_TSC_CTL(a)		(-EINVAL)
 #endif
-#ifndef MPX_ENABLE_MANAGEMENT
-# define MPX_ENABLE_MANAGEMENT()	(-EINVAL)
-#endif
-#ifndef MPX_DISABLE_MANAGEMENT
-# define MPX_DISABLE_MANAGEMENT()	(-EINVAL)
-#endif
 #ifndef GET_FP_MODE
 # define GET_FP_MODE(a)		(-EINVAL)
 #endif
@@ -2456,15 +2450,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		up_write(&me->mm->mmap_sem);
 		break;
 	case PR_MPX_ENABLE_MANAGEMENT:
-		if (arg2 || arg3 || arg4 || arg5)
-			return -EINVAL;
-		error = MPX_ENABLE_MANAGEMENT();
-		break;
 	case PR_MPX_DISABLE_MANAGEMENT:
-		if (arg2 || arg3 || arg4 || arg5)
-			return -EINVAL;
-		error = MPX_DISABLE_MANAGEMENT();
-		break;
+		/* No longer implemented: */
+		return -EINVAL;
 	case PR_SET_FP_MODE:
 		error = SET_FP_MODE(me, arg2);
 		break;
