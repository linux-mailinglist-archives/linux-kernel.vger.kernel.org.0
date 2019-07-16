Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81556B0F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 23:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbfGPVT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 17:19:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43097 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfGPVTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:19:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6GLJCuA1229585
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Jul 2019 14:19:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6GLJCuA1229585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563311953;
        bh=1zfYUP/mfuxHi/RJzpFXhZa1Vfg52V/Ht743QSHKRdQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tk4fKsUIgP+bP4teuGpz//u8HWLVnt4LTxcierqyTAKZbNxNh5g0prrYBOR891O+t
         ylzErAOHedYvOhVi6oJBuZqRBDi7uUIN/ZIJKQOOy5uf9nFY1US5DrEwkJvrcGM47j
         yvsUqaGcL3s0/0y13nlyileqcS8nRcjJluBYBaxxajhGDaFxVGufxJfymak6QYCPmj
         8J8J+UB4fEGdg4hSmL0BpZQCdqsOxZDR+gyOd9L49jknEZzxRnyvkq3HtN32MhvN4v
         DhC7OGAG0gogUW6ZGwVYdps875t84WCe4CQrgDnhChVgBFwt+HW6Ks8MkTNSehQiNl
         eyW1Pz4z4SzMA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6GLJCj81229582;
        Tue, 16 Jul 2019 14:19:12 -0700
Date:   Tue, 16 Jul 2019 14:19:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for David Rientjes <tipbot@zytor.com>
Message-ID: <tip-e74bd96989dd42a51a73eddb4a5510a6f5e42ac3@git.kernel.org>
Cc:     tglx@linutronix.de, cfir@google.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, rientjes@google.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, cfir@google.com,
          linux-kernel@vger.kernel.org, rientjes@google.com,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <alpine.DEB.2.21.1907091942570.28240@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1907091942570.28240@chino.kir.corp.google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot: Fix memory leak in
 default_get_smp_config()
Git-Commit-ID: e74bd96989dd42a51a73eddb4a5510a6f5e42ac3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e74bd96989dd42a51a73eddb4a5510a6f5e42ac3
Gitweb:     https://git.kernel.org/tip/e74bd96989dd42a51a73eddb4a5510a6f5e42ac3
Author:     David Rientjes <rientjes@google.com>
AuthorDate: Tue, 9 Jul 2019 19:44:03 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 16 Jul 2019 23:13:48 +0200

x86/boot: Fix memory leak in default_get_smp_config()

When default_get_smp_config() is called with early == 1 and mpf->feature1
is non-zero, mpf is leaked because the return path does not do
early_memunmap().

Fix this and share a common exit routine.

Fixes: 5997efb96756 ("x86/boot: Use memremap() to map the MPF and MPC data")
Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1907091942570.28240@chino.kir.corp.google.com

---
 arch/x86/kernel/mpparse.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 1bfe5c6e6cfe..afac7ccce72f 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -546,17 +546,15 @@ void __init default_get_smp_config(unsigned int early)
 			 * local APIC has default address
 			 */
 			mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
-			return;
+			goto out;
 		}
 
 		pr_info("Default MP configuration #%d\n", mpf->feature1);
 		construct_default_ISA_mptable(mpf->feature1);
 
 	} else if (mpf->physptr) {
-		if (check_physptr(mpf, early)) {
-			early_memunmap(mpf, sizeof(*mpf));
-			return;
-		}
+		if (check_physptr(mpf, early))
+			goto out;
 	} else
 		BUG();
 
@@ -565,7 +563,7 @@ void __init default_get_smp_config(unsigned int early)
 	/*
 	 * Only use the first configuration found.
 	 */
-
+out:
 	early_memunmap(mpf, sizeof(*mpf));
 }
 
