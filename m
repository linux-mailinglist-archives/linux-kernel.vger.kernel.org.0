Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CA316630A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 17:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgBTQbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 11:31:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36760 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728937AbgBTQbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aG1PP/azsdciMGR9kcbYgDDygB48VmVQwcR6SsxMpCc=;
        b=Wed6S5Ckmb8vvsfqCgxKZTz+KR17ShdTU/Wh+5NClPnQybMUwz+KvZLUVPnOFrsVvHYayr
        1zYcn4330X2hu4Q8ZoUhY2S96k8iWsZwrqeD8bL3TfWa0p15TY/kq3a1L773YillHundn8
        6Nxjm1LfMUqDb5E+BWeH27kjfx3iSXM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-c7451vLHPTi2bAUfe4F-tQ-1; Thu, 20 Feb 2020 11:31:37 -0500
X-MC-Unique: c7451vLHPTi2bAUfe4F-tQ-1
Received: by mail-qv1-f69.google.com with SMTP id d7so2917508qvq.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aG1PP/azsdciMGR9kcbYgDDygB48VmVQwcR6SsxMpCc=;
        b=VdMajL2XTX/PiT6KqIzWDgKvWrl0aAYIYD3p9eBRxZz77+saVZR7n+3Crx7vzHcJhS
         TFBgFK4rTcgAE7+cVbo184yvrEd2pkIbodTHlPSNv8DV+9wczJPobZInT6BlOwEzuvK3
         NoVbwxWTeCYEexqjf5eS7qG1MPgtFf7Gte5kIAuMSwSuX1BHnH8o/dMhPC1VB5iAWRlF
         W+BnA8pqjEOQXWdHQL1bTWnO3gQzwzxmafD6+e9FvWMhQ+5nA1IZXXNY8Kd8oW+tpVCz
         d3m+fTWTaBKNHWTb+CL1TiSiyyCoRPv56nDjygs+TFDVV4YRz4pw3ksYV4HBwhUGtdh7
         uizw==
X-Gm-Message-State: APjAAAULS5akI2fK674ByVX5b6SZqxKuyhLdX8fH0W96MAxwhe3JNBdd
        GuKnZPjaElXcdNfw6V8AMH1ffVmO0mNHLE1Gb1QhfFC/m/vzevArJHQ8PbWB366PMN+ok+dCcI7
        T2F9r6eikI8qhx4zAe1WwLNV4
X-Received: by 2002:a37:a12:: with SMTP id 18mr29827808qkk.249.1582216296631;
        Thu, 20 Feb 2020 08:31:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqyeeoJmBfxz+eoE07FIBfNGkpp7QPDv14l0vh9lWzGoCTi5/u4us5+ZDy8T66tGi8PhjGv1Og==
X-Received: by 2002:a37:a12:: with SMTP id 18mr29827758qkk.249.1582216296306;
        Thu, 20 Feb 2020 08:31:36 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:35 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Brian Geffon <bgeffon@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH v6 11/19] khugepaged: skip collapse if uffd-wp detected
Date:   Thu, 20 Feb 2020 11:31:04 -0500
Message-Id: <20200220163112.11409-12-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't collapse the huge PMD if there is any userfault write protected
small PTEs.  The problem is that the write protection is in small page
granularity and there's no way to keep all these write protection
information if the small pages are going to be merged into a huge PMD.

The same thing needs to be considered for swap entries and migration
entries.  So do the check as well disregarding khugepaged_max_ptes_swap.

Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/trace/events/huge_memory.h |  1 +
 mm/khugepaged.c                    | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index d82a0f4e824d..70e32ff096ec 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -13,6 +13,7 @@
 	EM( SCAN_PMD_NULL,		"pmd_null")			\
 	EM( SCAN_EXCEED_NONE_PTE,	"exceed_none_pte")		\
 	EM( SCAN_PTE_NON_PRESENT,	"pte_non_present")		\
+	EM( SCAN_PTE_UFFD_WP,		"pte_uffd_wp")			\
 	EM( SCAN_PAGE_RO,		"no_writable_page")		\
 	EM( SCAN_LACK_REFERENCED_PAGE,	"lack_referenced_page")		\
 	EM( SCAN_PAGE_NULL,		"page_null")			\
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b679908743cb..789485cc9387 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -29,6 +29,7 @@ enum scan_result {
 	SCAN_PMD_NULL,
 	SCAN_EXCEED_NONE_PTE,
 	SCAN_PTE_NON_PRESENT,
+	SCAN_PTE_UFFD_WP,
 	SCAN_PAGE_RO,
 	SCAN_LACK_REFERENCED_PAGE,
 	SCAN_PAGE_NULL,
@@ -1141,6 +1142,15 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		pte_t pteval = *_pte;
 		if (is_swap_pte(pteval)) {
 			if (++unmapped <= khugepaged_max_ptes_swap) {
+				/*
+				 * Always be strict with uffd-wp
+				 * enabled swap entries.  Please see
+				 * comment below for pte_uffd_wp().
+				 */
+				if (pte_swp_uffd_wp(pteval)) {
+					result = SCAN_PTE_UFFD_WP;
+					goto out_unmap;
+				}
 				continue;
 			} else {
 				result = SCAN_EXCEED_SWAP_PTE;
@@ -1160,6 +1170,19 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 			result = SCAN_PTE_NON_PRESENT;
 			goto out_unmap;
 		}
+		if (pte_uffd_wp(pteval)) {
+			/*
+			 * Don't collapse the page if any of the small
+			 * PTEs are armed with uffd write protection.
+			 * Here we can also mark the new huge pmd as
+			 * write protected if any of the small ones is
+			 * marked but that could bring uknown
+			 * userfault messages that falls outside of
+			 * the registered range.  So, just be simple.
+			 */
+			result = SCAN_PTE_UFFD_WP;
+			goto out_unmap;
+		}
 		if (pte_write(pteval))
 			writable = true;
 
-- 
2.24.1

