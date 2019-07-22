Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64A46FBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 11:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfGVJKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 05:10:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60897 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfGVJKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:10:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M9A6vu3755220
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 02:10:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M9A6vu3755220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563786607;
        bh=KfHlYRZ/ghbKhkZmjBq14Z6TRy0tSlX9QYfjn1EwK5I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=EJpKlH0Wizj0teLyFPH62lU462D4m+VgEFdaUqCUssLPEAqMSOBRga+I/hP/g1WAt
         oq7qZoMZaR+XYidj81Ssgi37peNZg8KUlQdwxBl7FIjfSk3c0WXalsz9Uxb4e8LT6E
         Z2m+6B0wCCDjIEBpC5LdNCgPETKEh8CTnYk1lAQ4piIwmXAnm6TzyHhShDY9+BpDN4
         4wxAjdOm1iddvyebLQAbxERSByqLcb6kuZJI1QuayJMjPlNN2kLevgW0F40IRja/Ca
         tifmHbTpRdnIu38MsDdD8jQKITnaZ8VP3EghThV2pstBAqPkzZPueiINi8jmMj+YO/
         p/auPXBsjHPlA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M9A6Ip3755216;
        Mon, 22 Jul 2019 02:10:06 -0700
Date:   Mon, 22 Jul 2019 02:10:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Maya Nakamura <tipbot@zytor.com>
Message-ID: <tip-fcd3f6222a4ece735d0b3ffb93f646eff693aa69@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, mingo@kernel.org, hpa@zytor.com,
        m.maya.nakamura@gmail.com, mikelley@microsoft.com
Reply-To: mingo@kernel.org, hpa@zytor.com, m.maya.nakamura@gmail.com,
          mikelley@microsoft.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, vkuznets@redhat.com
In-Reply-To: <e95111629abf65d016e983f72494cbf110ce605f.1562916939.git.m.maya.nakamura@gmail.com>
References: <e95111629abf65d016e983f72494cbf110ce605f.1562916939.git.m.maya.nakamura@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyperv: Create and use Hyper-V page
 definitions
Git-Commit-ID: fcd3f6222a4ece735d0b3ffb93f646eff693aa69
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=1.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fcd3f6222a4ece735d0b3ffb93f646eff693aa69
Gitweb:     https://git.kernel.org/tip/fcd3f6222a4ece735d0b3ffb93f646eff693aa69
Author:     Maya Nakamura <m.maya.nakamura@gmail.com>
AuthorDate: Fri, 12 Jul 2019 08:14:47 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 11:06:44 +0200

x86/hyperv: Create and use Hyper-V page definitions

Define HV_HYP_PAGE_SHIFT, HV_HYP_PAGE_SIZE, and HV_HYP_PAGE_MASK because
the Linux guest page size and hypervisor page size concepts are different,
even though they happen to be the same value on x86.

Also, replace PAGE_SIZE with HV_HYP_PAGE_SIZE.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lkml.kernel.org/r/e95111629abf65d016e983f72494cbf110ce605f.1562916939.git.m.maya.nakamura@gmail.com

---
 arch/x86/include/asm/hyperv-tlfs.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index af78cd72b8f3..7a2705694f5b 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -12,6 +12,16 @@
 #include <linux/types.h>
 #include <asm/page.h>
 
+/*
+ * While not explicitly listed in the TLFS, Hyper-V always runs with a page size
+ * of 4096. These definitions are used when communicating with Hyper-V using
+ * guest physical pages and guest physical page addresses, since the guest page
+ * size may not be 4096 on all architectures.
+ */
+#define HV_HYP_PAGE_SHIFT      12
+#define HV_HYP_PAGE_SIZE       BIT(HV_HYP_PAGE_SHIFT)
+#define HV_HYP_PAGE_MASK       (~(HV_HYP_PAGE_SIZE - 1))
+
 /*
  * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
  * is set by CPUID(HvCpuIdFunctionVersionAndFeatures).
@@ -847,7 +857,7 @@ union hv_gpa_page_range {
  * count is equal with how many entries of union hv_gpa_page_range can
  * be populated into the input parameter page.
  */
-#define HV_MAX_FLUSH_REP_COUNT ((PAGE_SIZE - 2 * sizeof(u64)) /	\
+#define HV_MAX_FLUSH_REP_COUNT ((HV_HYP_PAGE_SIZE - 2 * sizeof(u64)) /	\
 				sizeof(union hv_gpa_page_range))
 
 struct hv_guest_mapping_flush_list {
