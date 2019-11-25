Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8CE10943E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 20:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKYTbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 14:31:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:22629 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKYTbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 14:31:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 11:31:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,242,1571727600"; 
   d="scan'208";a="216994579"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 25 Nov 2019 11:31:11 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "David Laight" <David.Laight@ACULAB.COM>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 2/4] xen-pcifront: Align address of flags to size of unsigned long
Date:   Mon, 25 Nov 2019 11:43:02 -0800
Message-Id: <1574710984-208305-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1574710984-208305-1-git-send-email-fenghua.yu@intel.com>
References: <1574710984-208305-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address of "flags" is passed to atomic bitops which require the
address is aligned to size of unsigned long.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 include/xen/interface/io/pciif.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/xen/interface/io/pciif.h b/include/xen/interface/io/pciif.h
index d9922ae36eb5..639d5fb484a3 100644
--- a/include/xen/interface/io/pciif.h
+++ b/include/xen/interface/io/pciif.h
@@ -103,8 +103,11 @@ struct xen_pcie_aer_op {
 	uint32_t devfn;
 };
 struct xen_pci_sharedinfo {
-	/* flags - XEN_PCIF_* */
-	uint32_t flags;
+	/* flags - XEN_PCIF_*. Force alignment for atomic bit operations. */
+	union {
+		uint32_t	flags;
+		unsigned long	flags_alignment;
+	};
 	struct xen_pci_op op;
 	struct xen_pcie_aer_op aer_op;
 };
-- 
2.19.1

