Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6470586AEC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 21:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390370AbfHHTyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 15:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404447AbfHHTxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:17 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 501AC218A6;
        Thu,  8 Aug 2019 19:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293997;
        bh=XUAqwdMFL0v2xw6bXW2tTsOnay/wYkSspiv610CB660=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=wHsZAxl0O346hTPIv6diGqaGoIU9tmqGg2f0L7RtDdILJeGR/CGyKqW2qFUU9dK41
         zSm7rEPJCcj7SIOM/RzJtaVH83x6yPICzPNOrw4KeBis0oYjaGKKXxOxiZKbFf3r6I
         Wgvce5hf6IbPXd21LJCfaVVX3nylvBFUmgcjgiVM=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 08/19] arm: imx6: cpuidle: Use raw_spinlock_t
Date:   Thu,  8 Aug 2019 14:52:36 -0500
Message-Id: <c7f5849d42ff0ab9a447752e66b55ac91193c2fa.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 40d0332ec8312e9c090f0a5414d9c90e12b13611 ]

The idle call back is invoked with disabled interrupts and requires
raw_spinlock_t locks to work.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 arch/arm/mach-imx/cpuidle-imx6q.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index 326e870d7123..d9ac80aa1eb0 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -17,22 +17,22 @@
 #include "hardware.h"
 
 static int num_idle_cpus = 0;
-static DEFINE_SPINLOCK(cpuidle_lock);
+static DEFINE_RAW_SPINLOCK(cpuidle_lock);
 
 static int imx6q_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
-	spin_lock(&cpuidle_lock);
+	raw_spin_lock(&cpuidle_lock);
 	if (++num_idle_cpus == num_online_cpus())
 		imx6_set_lpm(WAIT_UNCLOCKED);
-	spin_unlock(&cpuidle_lock);
+	raw_spin_unlock(&cpuidle_lock);
 
 	cpu_do_idle();
 
-	spin_lock(&cpuidle_lock);
+	raw_spin_lock(&cpuidle_lock);
 	if (num_idle_cpus-- == num_online_cpus())
 		imx6_set_lpm(WAIT_CLOCKED);
-	spin_unlock(&cpuidle_lock);
+	raw_spin_unlock(&cpuidle_lock);
 
 	return index;
 }
-- 
2.14.1

