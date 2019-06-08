Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4563A26B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 00:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfFHWw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 18:52:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:38570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727927AbfFHWwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 18:52:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22CCEAFAF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2019 22:52:50 +0000 (UTC)
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F105B2C16B
        for <bp@suse.de>; Sat,  8 Jun 2019 21:30:30 +0000 (UTC)
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTPS id 983D8AD00
        for <bp@suse.de>; Sat,  8 Jun 2019 21:30:30 +0000 (UTC)
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x58LUNor3146077
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 8 Jun 2019 14:30:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x58LUNor3146077
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560029424;
        bh=egwMkHidIPH0qSlt14TH8NgLcvplvg4gH4P3OFAAnRg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=GRArQt2ZXNtHGa+I1nF/N6KKXmB/keaPJoy0FdkJehIpVAwKXH71uah/ssszAXG0K
         g/eyKdm+7aEzeBpHof+wDyaWO9XOP0DrdXs5zWU6dOBJgzbQx0TPu7SaCbcmW4C/NB
         r1O5QU43XGDrA2YYvazwePvHp973O6/MYfbRX/knVjFjIBDFKqCWSSHnpIaytFUHQP
         X+a0vWFR73vQzkpMxpSA0WbjBXaAjEIJNAqVhdUcTs5dGc+RLjDFV6DgtD4+yE/WkT
         1p+U7jfnunAYZSmv2gHtXzFzyTevnWPEui3UrRN+NhTyEo0DD58mjPsaYs5CjQ4EKz
         khUpe1ATzVcSw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x58LUNpa3146074;
        Sat, 8 Jun 2019 14:30:23 -0700
Date:   Sat, 8 Jun 2019 14:30:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Luck <tipbot@zytor.com>
Message-ID: <tip-60fd42d26cc7ec8847598da50ebf27e3c9647d7b@git.kernel.org>
Cc:     mingo@kernel.org, bp@suse.de, tglx@linutronix.de,
        tony.luck@intel.com, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tony.luck@intel.com,
          mingo@kernel.org, bp@suse.de, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS/CEC: Add CONFIG_RAS_CEC_DEBUG and move CEC debug
 features there
Git-Commit-ID: 60fd42d26cc7ec8847598da50ebf27e3c9647d7b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  60fd42d26cc7ec8847598da50ebf27e3c9647d7b
Gitweb:     https://git.kernel.org/tip/60fd42d26cc7ec8847598da50ebf27e3c9647d7b
Author:     Tony Luck <tony.luck@intel.com>
AuthorDate: Mon, 6 May 2019 13:13:22 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 8 Jun 2019 17:39:24 +0200

RAS/CEC: Add CONFIG_RAS_CEC_DEBUG and move CEC debug features there

The pfn and array files in (debugfs)/ras/cec are intended for debugging
the CEC code itself. They are not needed on production systems, so the
default setting for this CONFIG option is "n".

 [ bp: Have it with less ifdeffery by using IS_ENABLED(). ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/ras/Kconfig | 10 ++++++++++
 drivers/ras/cec.c    | 26 ++++++++++++++------------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/ras/Kconfig b/arch/x86/ras/Kconfig
index a9c3db125222..9ad6842de4b4 100644
--- a/arch/x86/ras/Kconfig
+++ b/arch/x86/ras/Kconfig
@@ -11,3 +11,13 @@ config RAS_CEC
 
 	  Bear in mind that this is absolutely useless if your platform doesn't
 	  have ECC DIMMs and doesn't have DRAM ECC checking enabled in the BIOS.
+
+config RAS_CEC_DEBUG
+	bool "CEC debugging machinery"
+	default n
+	depends on RAS_CEC
+	help
+	  Add extra files to (debugfs)/ras/cec to test the correctable error
+	  collector feature. "pfn" is a writable file that allows user to
+	  simulate an error in a particular page frame. "array" is a read-only
+	  file that dumps out the current state of all pages logged so far.
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index dc08c705b493..0907dc6f4afe 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -486,18 +486,6 @@ static int __init create_debugfs_nodes(void)
 		return -1;
 	}
 
-	pfn = debugfs_create_file("pfn", S_IRUSR | S_IWUSR, d, &dfs_pfn, &pfn_ops);
-	if (!pfn) {
-		pr_warn("Error creating pfn debugfs node!\n");
-		goto err;
-	}
-
-	array = debugfs_create_file("array", S_IRUSR, d, NULL, &array_ops);
-	if (!array) {
-		pr_warn("Error creating array debugfs node!\n");
-		goto err;
-	}
-
 	decay = debugfs_create_file("decay_interval", S_IRUSR | S_IWUSR, d,
 				    &decay_interval, &decay_interval_ops);
 	if (!decay) {
@@ -512,6 +500,20 @@ static int __init create_debugfs_nodes(void)
 		goto err;
 	}
 
+	if (!IS_ENABLED(CONFIG_RAS_CEC_DEBUG))
+		return 0;
+
+	pfn = debugfs_create_file("pfn", S_IRUSR | S_IWUSR, d, &dfs_pfn, &pfn_ops);
+	if (!pfn) {
+		pr_warn("Error creating pfn debugfs node!\n");
+		goto err;
+	}
+
+	array = debugfs_create_file("array", S_IRUSR, d, NULL, &array_ops);
+	if (!array) {
+		pr_warn("Error creating array debugfs node!\n");
+		goto err;
+	}
 
 	return 0;
 
