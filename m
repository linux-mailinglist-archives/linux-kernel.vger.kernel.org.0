Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 237A71418F2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 19:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgARS3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 13:29:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44468 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgARS3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 13:29:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so25657550wrm.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 10:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6gl79ho+mKe4vfBg5gI2ydk/iTfOCFwyadWeOZQIjMk=;
        b=lDYi/OcJz7rSt6K52PCNMi+DMPUvQdlLgvjftp0VpWt9uunCP4r6EhyFhEfQjED0RL
         w4ASaSaDnOlFy4447Iz/3hhJP+aon70qiu89XNkTIC8oOqsvuiYyk/Iy0zJPOthijXI5
         VKA41R7YtfGN6hAP/BOyrKZqKrFF4v5vyw2WKWZozBcZoPuoK8IvLqk56rroHg5t2d1G
         UlsJbS0p/2XHIZt6qlUVbbL8Dwel7Rl1y2AieZ2b+mgcahG9K8BST3qk6mdv5RHMAzkE
         lzNjWtKyYKq80W39OUD3KhWINOmsMS5iFK7w9Zr1DAsU8KeF39N6mma4V6BM0yQmmPCa
         ZLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=6gl79ho+mKe4vfBg5gI2ydk/iTfOCFwyadWeOZQIjMk=;
        b=mC+bAI8Ho2OG8CYRrnw+zig6QPRzaqSW42wh7j1KXVJK2sktyleElgkt+JWbDdC+Md
         o5KsGiY30pbgUUGO0kHTAkljLUaG27h6WhwYE9DTzknnK7+kk+I1EiOYSU4TB8QUpN83
         /jwwkQ/40CpFc+dkUn30F3iP3OAEqX/nssHh9+yoCTA9YhFybaQ7PAUXTTRULB9WACUD
         LVZVGhFHcs4HcN4mAzg4jS+Hd4r3t/4Qt5Ximn25i9CIvsAM1MlLjtxjDz4Gr0kBdrQQ
         FUMYWdtlXURaXZHQ39lZjuBBv0iIGh1GqYtYf7os7gItMXLTExJ2Kkw9SvjvWtvQjtgM
         H/hA==
X-Gm-Message-State: APjAAAXpZlYrXT7rL5cZeqr34OOKTyat2wCxJTgwfVWihjnn2mUKCtBq
        OmfrH3Tu5zhIysxTVM9gA/4=
X-Google-Smtp-Source: APXvYqwb+Ssi9pNB/lybhVtFbev8i+4QkVv67+lx7kVV74v+VE9A/uMvTsPa4sBGP4cEka8AlJZ9yA==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr9624354wrs.237.1579372192180;
        Sat, 18 Jan 2020 10:29:52 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g9sm39991948wro.67.2020.01.18.10.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 10:29:51 -0800 (PST)
Date:   Sat, 18 Jan 2020 19:29:49 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RAS fix
Message-ID: <20200118182949.GA61525@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest ras-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-for-linus

   # HEAD: 978370956d2046b19313659ce65ed12d5b996626 x86/mce/therm_throt: Do not access uninitialized therm_work

Fix a thermal throttling race that can result in easy to trigger boot 
crashes on certain Ice Lake platforms.

 Thanks,

	Ingo

------------------>
Chuansheng Liu (1):
      x86/mce/therm_throt: Do not access uninitialized therm_work


 arch/x86/kernel/cpu/mce/therm_throt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index b38010b541d6..6c3e1c92f183 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -467,6 +467,7 @@ static int thermal_throttle_online(unsigned int cpu)
 {
 	struct thermal_state *state = &per_cpu(thermal_state, cpu);
 	struct device *dev = get_cpu_device(cpu);
+	u32 l;
 
 	state->package_throttle.level = PACKAGE_LEVEL;
 	state->core_throttle.level = CORE_LEVEL;
@@ -474,6 +475,10 @@ static int thermal_throttle_online(unsigned int cpu)
 	INIT_DELAYED_WORK(&state->package_throttle.therm_work, throttle_active_work);
 	INIT_DELAYED_WORK(&state->core_throttle.therm_work, throttle_active_work);
 
+	/* Unmask the thermal vector after the above workqueues are initialized. */
+	l = apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
+
 	return thermal_throttle_add_dev(dev, cpu);
 }
 
@@ -722,10 +727,6 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
 	wrmsr(MSR_IA32_MISC_ENABLE, l | MSR_IA32_MISC_ENABLE_TM1, h);
 
-	/* Unmask the thermal vector: */
-	l = apic_read(APIC_LVTTHMR);
-	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
-
 	pr_info_once("CPU0: Thermal monitoring enabled (%s)\n",
 		      tm2 ? "TM2" : "TM1");
 
