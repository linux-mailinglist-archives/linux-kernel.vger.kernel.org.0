Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6625358EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 01:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfF0XkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 19:40:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41513 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfF0XkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:40:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNaxX5499727
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:36:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNaxX5499727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561678619;
        bh=aBi/LHzDapDb8y90kpPQZO4vgXOeEJt8PvCQMalY6nM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JXhnsPffpeXS0kQG+m7LM2/lswBCnHaL0uE/R1GzDBBYR1a9vAyGxdPjJy3dPfSFt
         nx0UxurvLbmO4mBgP0Q5GDg0pU/sVOVVmbFnsKe2cbD4UgCTVg5gsta1bd55gAKQT4
         Y9BoZQ4v1EgJVs8DXfvkbYGNkVvhHDMeZfNqpxkMYoeaM3GpPIHKtA+xT4VX1UNYIc
         jPNMwbP+Xmtwr6t5woZE+nU34gh8P71Ir/eroJlktVtK1RSZ+jn77T5eeniUIZr0cX
         FiXnBlL22fHP85FnPQ/Nu82yZP7KeiTE06+drJ9tqQ/Dr0PVZTQYZ8JGwjfGVcra0J
         Qo0/sm/igwqkA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNawV0499723;
        Thu, 27 Jun 2019 16:36:58 -0700
Date:   Thu, 27 Jun 2019 16:36:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-853acaf064acf3aad6189b36de814bd381d35133@git.kernel.org>
Cc:     hpa@zytor.com, ravi.v.shankar@intel.com, eranian@google.com,
        ashok.raj@intel.com, tglx@linutronix.de,
        ricardo.neri-calderon@linux.intel.com, mingo@kernel.org,
        Suravee.Suthikulpanit@amd.com, andi.kleen@intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: Suravee.Suthikulpanit@amd.com, mingo@kernel.org,
          andi.kleen@intel.com, ashok.raj@intel.com, tglx@linutronix.de,
          ricardo.neri-calderon@linux.intel.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          eranian@google.com, ravi.v.shankar@intel.com, hpa@zytor.com
In-Reply-To: <20190623132434.447880978@linutronix.de>
References: <20190623132434.447880978@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Remove unused parameter from
 hpet_next_event()
Git-Commit-ID: 853acaf064acf3aad6189b36de814bd381d35133
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  853acaf064acf3aad6189b36de814bd381d35133
Gitweb:     https://git.kernel.org/tip/853acaf064acf3aad6189b36de814bd381d35133
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:45 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:16 +0200

x86/hpet: Remove unused parameter from hpet_next_event()

The clockevent device pointer is not used in this function.

While at it, rename the misnamed 'timer' parameter to 'channel', which makes it
clear what this parameter means.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132434.447880978@linutronix.de

---
 arch/x86/kernel/hpet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 76d63ed62ce8..b2ec52a7773d 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -347,15 +347,14 @@ static int hpet_resume(struct clock_event_device *evt)
 	return 0;
 }
 
-static int hpet_next_event(unsigned long delta,
-			   struct clock_event_device *evt, int timer)
+static int hpet_next_event(unsigned long delta, int channel)
 {
 	u32 cnt;
 	s32 res;
 
 	cnt = hpet_readl(HPET_COUNTER);
 	cnt += (u32) delta;
-	hpet_writel(cnt, HPET_Tn_CMP(timer));
+	hpet_writel(cnt, HPET_Tn_CMP(channel));
 
 	/*
 	 * HPETs are a complete disaster. The compare register is
@@ -407,7 +406,7 @@ static int hpet_legacy_resume(struct clock_event_device *evt)
 static int hpet_legacy_next_event(unsigned long delta,
 			struct clock_event_device *evt)
 {
-	return hpet_next_event(delta, evt, 0);
+	return hpet_next_event(delta, 0);
 }
 
 /*
@@ -508,7 +507,8 @@ static int hpet_msi_next_event(unsigned long delta,
 				struct clock_event_device *evt)
 {
 	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-	return hpet_next_event(delta, evt, hdev->num);
+
+	return hpet_next_event(delta, hdev->num);
 }
 
 static irqreturn_t hpet_interrupt_handler(int irq, void *data)
