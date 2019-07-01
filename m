Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D7B1227D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 21:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfEBTOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 15:14:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBTOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:14:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFD405944C;
        Thu,  2 May 2019 19:14:29 +0000 (UTC)
Received: from jsavitz.bos.com (dhcp-17-168.bos.redhat.com [10.18.17.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B50CF1001E86;
        Thu,  2 May 2019 19:14:24 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH 1/2] kernel/sys: add PR_GET_TASK_SIZE option to prctl(2)
Date:   Thu,  2 May 2019 15:13:10 -0400
Message-Id: <1556824391-24060-2-git-send-email-jsavitz@redhat.com>
In-Reply-To: <1556824391-24060-1-git-send-email-jsavitz@redhat.com>
References: <1556824391-24060-1-git-send-email-jsavitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 02 May 2019 19:14:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PR_GET_TASK_SIZE is passed to prctl, the kernel will attempt to
copy the value of TASK_SIZE to the userspace address in arg2.

Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 include/uapi/linux/prctl.h |  3 +++
 kernel/sys.c               | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 094bb03b9cc2..2335fe0a8db8 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -229,4 +229,7 @@ struct prctl_mm_map {
 # define PR_PAC_APDBKEY			(1UL << 3)
 # define PR_PAC_APGAKEY			(1UL << 4)
 
+/* Get the process virtual memory size */
+#define PR_GET_TASK_SIZE 		55
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 12df0e5434b8..7ced7dbd035d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2252,6 +2252,13 @@ static int propagate_has_child_subreaper(struct task_struct *p, void *data)
 	return 1;
 }
 
+static int prctl_get_tasksize(void __user * uaddr)
+{
+	unsigned long long task_size = TASK_SIZE;
+	return copy_to_user(uaddr, &task_size, sizeof(unsigned long long))
+			? -EFAULT : 0;
+}
+
 int __weak arch_prctl_spec_ctrl_get(struct task_struct *t, unsigned long which)
 {
 	return -EINVAL;
@@ -2486,6 +2493,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = PAC_RESET_KEYS(me, arg2);
 		break;
+	case PR_GET_TASK_SIZE:
+		error = prctl_get_tasksize((void *)arg2) ;
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.18.1

