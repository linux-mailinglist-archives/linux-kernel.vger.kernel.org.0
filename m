Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E62B31558A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 14:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBGNmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 08:42:32 -0500
Received: from smtpbgsg2.qq.com ([54.254.200.128]:33926 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGNmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:42:31 -0500
X-QQ-mid: bizesmtp18t1581082939t75dbg81
Received: from 10.0.2.15 (unknown [221.222.188.180])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 07 Feb 2020 21:42:14 +0800 (CST)
X-QQ-SSF: 01100000002000E0UJ10B00A0000000
X-QQ-FEAT: 1WyLoCoLash2qUdaqhhXwffAD1HxWcVu5Tnw8ZsuX/NdifEJltcnVkU+lrNUD
        W/be7oSxBpTbwXVP9iLoEmDSrAs7TS11/7JEOf4Bd8umcW4MIEwtQa2RsRFNsSEERlWAMlG
        nUt9povzI4tgf915N+FNv8wixTzS2pips9qwLIEGNh+jrvNAuY7B4YzqSdvaHZGamxOhSX0
        nMNIQYwo5E433VuW9QKPGv5ilkIwUYgFLAUHRs6fCv0/klbG41cy1+CpXGyTI3oR4wPcpKK
        zSgbZOTjSTwnhkrmLUJvc69eiUf5N26eOGYS8TbxzvM8ObWdrX0I/Rl9cPsHbhwpoPVHzym
        e6UlRMCn3naPtoJgs4=
X-QQ-GoodBg: 0
From:   Wang Long <w@laoqinren.net>
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     linux-kernel@vger.kernel.org, w@laoqinren.net
Subject: [PATCH] Documentation/ABI: move sysfs-kernel-uids to removed dirtory
Date:   Fri,  7 Feb 2020 21:42:10 +0800
Message-Id: <1581082930-30441-1-git-send-email-w@laoqinren.net>
X-Mailer: git-send-email 1.8.3.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:laoqinren.net:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 7c9414385ebf ("sched: Remove USER_SCHED") delete the
USER_SCHED feature. so move the ABI doc to removed dirtory.

Signed-off-by: Wang Long <w@laoqinren.net>
---
 Documentation/ABI/removed/sysfs-kernel-uids | 14 ++++++++++++++
 Documentation/ABI/testing/sysfs-kernel-uids | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-uids
 delete mode 100644 Documentation/ABI/testing/sysfs-kernel-uids

diff --git a/Documentation/ABI/removed/sysfs-kernel-uids b/Documentation/ABI/removed/sysfs-kernel-uids
new file mode 100644
index 0000000..dc4463f
--- /dev/null
+++ b/Documentation/ABI/removed/sysfs-kernel-uids
@@ -0,0 +1,14 @@
+What:		/sys/kernel/uids/<uid>/cpu_shares
+Date:		December 2007, finally removed in kernel v2.6.34-rc1
+Contact:	Dhaval Giani <dhaval@linux.vnet.ibm.com>
+		Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
+Description:
+		The /sys/kernel/uids/<uid>/cpu_shares tunable is used
+		to set the cpu bandwidth a user is allowed. This is a
+		propotional value. What that means is that if there
+		are two users logged in, each with an equal number of
+		shares, then they will get equal CPU bandwidth. Another
+		example would be, if User A has shares = 1024 and user
+		B has shares = 2048, User B will get twice the CPU
+		bandwidth user A will. For more details refer
+		Documentation/scheduler/sched-design-CFS.rst
diff --git a/Documentation/ABI/testing/sysfs-kernel-uids b/Documentation/ABI/testing/sysfs-kernel-uids
deleted file mode 100644
index 4182b70..0000000
--- a/Documentation/ABI/testing/sysfs-kernel-uids
+++ /dev/null
@@ -1,14 +0,0 @@
-What:		/sys/kernel/uids/<uid>/cpu_shares
-Date:		December 2007
-Contact:	Dhaval Giani <dhaval@linux.vnet.ibm.com>
-		Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
-Description:
-		The /sys/kernel/uids/<uid>/cpu_shares tunable is used
-		to set the cpu bandwidth a user is allowed. This is a
-		propotional value. What that means is that if there
-		are two users logged in, each with an equal number of
-		shares, then they will get equal CPU bandwidth. Another
-		example would be, if User A has shares = 1024 and user
-		B has shares = 2048, User B will get twice the CPU
-		bandwidth user A will. For more details refer
-		Documentation/scheduler/sched-design-CFS.rst
-- 
1.8.3.1



