Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C1912212
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 20:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfEBSns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 14:43:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33365 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfEBSnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:43:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id m32so708388qtf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=F53mVZg38ORKpzG6u8tAANwm3nwFDbLr58RDkqAxcF0=;
        b=PyyTBVSCQ3AA7QeDsVoZcXkNxvscJ/Eubktvsu0ShHb2SYfsJHqxOAtwRUBbYO2Nhl
         vOyL7FoxPWAyfDeiPb+hBBEFYObZRK/QIpYfdZhTrCaCHDjO24HV9jTO15x+L8rv9QBD
         FGnVGHj9tbIiUsXWeJjjrrMlZKDIBMvMzIgCR5xCvL/6KohNIGgJhsSNG/fSj6XXKJqT
         t0Rv+SI6yWGseZZCK/dRe7U5S+GoFTC+StqtJ4naZC5rDJosDhBbXDxFxov1A40jPfHC
         dJqV3/+l/NnjkDFyD/8uj631iQSWrBko8wkUxRTAMyMUieMl4saojWrtndVA7LpmG4gv
         Ufgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F53mVZg38ORKpzG6u8tAANwm3nwFDbLr58RDkqAxcF0=;
        b=qbHHTq5LCSEHMth7csF6ypHzFoASf6kmKmDVdFA0KNhsqCZ7xP5YeENzo3Xz1yCSiC
         OKJwhzCQdZcwC135JWrkdXq7qk/f3qVMzGr3gBQdn5LXKikeJnamg+teQxEpsweRmnnP
         Cnjrh2x1FUccNT3m3f3xcr+r9JWXYeWvybsgjBYot7rZPAK339cXFeDcM3acJYWo5Q+H
         UKcJIlPQ8JBRzeP1ajMZBMod2CuhnV147Cb5kYnV+DmEo6W0MOu80PjFLTJKYTBxBCZ8
         94IRME4s0tuHC0fCr9N8d1t6eO4zz+FdRIU5GhMJe0/3VdOII4dbZCO0CsbnySWIeX+d
         ga1g==
X-Gm-Message-State: APjAAAWIt44hHEt4IC7B1gKsBPA5gW9N4Nj/4pHRzOgTvxVsFZWUevRL
        xlKKkN6xklVoygwb5ydGeLbnsQ==
X-Google-Smtp-Source: APXvYqyfwEAWWnvwijtzClV/lCkQK+L47PTgTei/5edOoaHHMny11XeQ+5u/49ncXcht4fFFuYhkew==
X-Received: by 2002:a0c:a94b:: with SMTP id z11mr4530210qva.166.1556822624458;
        Thu, 02 May 2019 11:43:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 8sm25355751qtr.32.2019.05.02.11.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 11:43:43 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, akpm@linux-foundation.org,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        thomas.lendacky@amd.com, ying.huang@intel.com,
        fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com,
        david@redhat.com
Subject: [v5 2/3] mm/hotplug: make remove_memory() interface useable
Date:   Thu,  2 May 2019 14:43:36 -0400
Message-Id: <20190502184337.20538-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502184337.20538-1-pasha.tatashin@soleen.com>
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of right now remove_memory() interface is inherently broken. It tries
to remove memory but panics if some memory is not offline. The problem
is that it is impossible to ensure that all memory blocks are offline as
this function also takes lock_device_hotplug that is required to
change memory state via sysfs.

So, between calling this function and offlining all memory blocks there
is always a window when lock_device_hotplug is released, and therefore,
there is always a chance for a panic during this window.

Make this interface to return an error if memory removal fails. This way
it is safe to call this function without panicking machine, and also
makes it symmetric to add_memory() which already returns an error.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/memory_hotplug.h |  8 +++--
 mm/memory_hotplug.c            | 61 ++++++++++++++++++++++------------
 2 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 8ade08c50d26..5438a2d92560 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -304,7 +304,7 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
 extern bool is_mem_section_removable(unsigned long pfn, unsigned long nr_pages);
 extern void try_offline_node(int nid);
 extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
-extern void remove_memory(int nid, u64 start, u64 size);
+extern int remove_memory(int nid, u64 start, u64 size);
 extern void __remove_memory(int nid, u64 start, u64 size);
 
 #else
@@ -321,7 +321,11 @@ static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	return -EINVAL;
 }
 
-static inline void remove_memory(int nid, u64 start, u64 size) {}
+static inline bool remove_memory(int nid, u64 start, u64 size)
+{
+	return -EBUSY;
+}
+
 static inline void __remove_memory(int nid, u64 start, u64 size) {}
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8c454e82d4f6..a826aededa1a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1778,9 +1778,10 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
 		endpa = PFN_PHYS(section_nr_to_pfn(mem->end_section_nr + 1))-1;
 		pr_warn("removing memory fails, because memory [%pa-%pa] is onlined\n",
 			&beginpa, &endpa);
-	}
 
-	return ret;
+		return -EBUSY;
+	}
+	return 0;
 }
 
 static int check_cpu_on_node(pg_data_t *pgdat)
@@ -1843,19 +1844,9 @@ void try_offline_node(int nid)
 }
 EXPORT_SYMBOL(try_offline_node);
 
-/**
- * remove_memory
- * @nid: the node ID
- * @start: physical address of the region to remove
- * @size: size of the region to remove
- *
- * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
- * and online/offline operations before this call, as required by
- * try_offline_node().
- */
-void __ref __remove_memory(int nid, u64 start, u64 size)
+static int __ref try_remove_memory(int nid, u64 start, u64 size)
 {
-	int ret;
+	int rc = 0;
 
 	BUG_ON(check_hotplug_memory_range(start, size));
 
@@ -1863,13 +1854,13 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
 
 	/*
 	 * All memory blocks must be offlined before removing memory.  Check
-	 * whether all memory blocks in question are offline and trigger a BUG()
+	 * whether all memory blocks in question are offline and return error
 	 * if this is not the case.
 	 */
-	ret = walk_memory_range(PFN_DOWN(start), PFN_UP(start + size - 1), NULL,
-				check_memblock_offlined_cb);
-	if (ret)
-		BUG();
+	rc = walk_memory_range(PFN_DOWN(start), PFN_UP(start + size - 1), NULL,
+			       check_memblock_offlined_cb);
+	if (rc)
+		goto done;
 
 	/* remove memmap entry */
 	firmware_map_remove(start, start + size, "System RAM");
@@ -1879,14 +1870,42 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
 
 	try_offline_node(nid);
 
+done:
 	mem_hotplug_done();
+	return rc;
 }
 
-void remove_memory(int nid, u64 start, u64 size)
+/**
+ * remove_memory
+ * @nid: the node ID
+ * @start: physical address of the region to remove
+ * @size: size of the region to remove
+ *
+ * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
+ * and online/offline operations before this call, as required by
+ * try_offline_node().
+ */
+void __remove_memory(int nid, u64 start, u64 size)
 {
+
+	/*
+	 * trigger BUG() is some memory is not offlined prior to calling this
+	 * function
+	 */
+	if (try_remove_memory(nid, start, size))
+		BUG();
+}
+
+/* Remove memory if every memory block is offline, otherwise return false */
+int remove_memory(int nid, u64 start, u64 size)
+{
+	int rc;
+
 	lock_device_hotplug();
-	__remove_memory(nid, start, size);
+	rc  = try_remove_memory(nid, start, size);
 	unlock_device_hotplug();
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(remove_memory);
 #endif /* CONFIG_MEMORY_HOTREMOVE */
-- 
2.21.0

