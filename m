Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB501515A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 07:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgBDGGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 01:06:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:33583 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgBDGGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:06:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 22:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="249242321"
Received: from ncouniha-mobl6.ger.corp.intel.com (HELO localhost) ([10.252.20.163])
  by orsmga002.jf.intel.com with ESMTP; 03 Feb 2020 22:06:39 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v25 09/21] mm: Introduce vm_ops->may_mprotect()
Date:   Tue,  4 Feb 2020 08:05:33 +0200
Message-Id: <20200204060545.31729-10-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204060545.31729-1-jarkko.sakkinen@linux.intel.com>
References: <20200204060545.31729-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add vm_ops()->may_mprotect() to check additional constrains set by a
subsystem for a mprotect() call.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 include/linux/mm.h |  2 ++
 mm/mprotect.c      | 14 +++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 73a044ed6981..188378470e7e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -464,6 +464,8 @@ struct vm_operations_struct {
 	void (*close)(struct vm_area_struct * area);
 	int (*split)(struct vm_area_struct * area, unsigned long addr);
 	int (*mremap)(struct vm_area_struct * area);
+	int (*may_mprotect)(struct vm_area_struct *vma, unsigned long start,
+			    unsigned long end, unsigned long prot);
 	vm_fault_t (*fault)(struct vm_fault *vmf);
 	vm_fault_t (*huge_fault)(struct vm_fault *vmf,
 			enum page_entry_size pe_size);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 7a8e84f86831..c0cb40e23b43 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -543,13 +543,21 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			goto out;
 		}
 
+		tmp = vma->vm_end;
+		if (tmp > end)
+			tmp = end;
+
+		if (vma->vm_ops && vma->vm_ops->may_mprotect) {
+			error = vma->vm_ops->may_mprotect(vma, nstart, tmp,
+							  prot);
+			if (error)
+				goto out;
+		}
+
 		error = security_file_mprotect(vma, reqprot, prot);
 		if (error)
 			goto out;
 
-		tmp = vma->vm_end;
-		if (tmp > end)
-			tmp = end;
 		error = mprotect_fixup(vma, &prev, nstart, tmp, newflags);
 		if (error)
 			goto out;
-- 
2.20.1

