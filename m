Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82199DF420
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfJURYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 13:24:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54301 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726819AbfJURYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571678655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQYcvLtWk8T9zQAjZwhkaiSHuaBfiwn4LQYTrcLQ9f4=;
        b=Q5MY76FIEwZUmMUaOKA34R5yZWEE3s++fR68hFKyPC9xMqQx8wOhaiQFyvd1WASsvUffQn
        nVxbMArb304zueNPwBJQUckGoacK4G/XamFNCUyY/4DsKds7dbW90f43f95ntHC3HXfZjJ
        Z0R4W5e8q4Ke30JbDNwCLWyIeyMSxxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-oqm37ZubNT24yS1VoOnrbQ-1; Mon, 21 Oct 2019 13:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73F9A1800D79;
        Mon, 21 Oct 2019 17:24:10 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-42.ams2.redhat.com [10.36.116.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A1DF60856;
        Mon, 21 Oct 2019 17:24:07 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH v2 2/2] mm/page_isolation.c: Convert SKIP_HWPOISON to MEMORY_OFFLINE
Date:   Mon, 21 Oct 2019 19:23:53 +0200
Message-Id: <20191021172353.3056-3-david@redhat.com>
In-Reply-To: <20191021172353.3056-1-david@redhat.com>
References: <20191021172353.3056-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: oqm37ZubNT24yS1VoOnrbQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have two types of users of page isolation:
1. Memory offlining: Offline memory so it can be unplugged. Memory won't
=09=09     be touched.
2. Memory allocation: Allocate memory (e.g., alloc_contig_range()) to
=09=09      become the owner of the memory and make use of it.

For example, in case we want to offline memory, we can ignore (skip over)
PageHWPoison() pages, as the memory won't get used. We can allow to
offline memory. In contrast, we don't want to allow to allocate such
memory.

Let's generalize the approach so we can special case other types of
pages we want to skip over in case we offline memory. While at it, also
pass the same flags to test_pages_isolated().

Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-isolation.h |  4 ++--
 mm/memory_hotplug.c            |  8 +++++---
 mm/page_alloc.c                |  4 ++--
 mm/page_isolation.c            | 12 ++++++------
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.=
h
index 1099c2fee20f..6861df759fad 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -30,7 +30,7 @@ static inline bool is_migrate_isolate(int migratetype)
 }
 #endif
=20
-#define SKIP_HWPOISON=090x1
+#define MEMORY_OFFLINE=090x1
 #define REPORT_FAILURE=090x2
=20
 bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
@@ -58,7 +58,7 @@ undo_isolate_page_range(unsigned long start_pfn, unsigned=
 long end_pfn,
  * Test all pages in [start_pfn, end_pfn) are isolated or not.
  */
 int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
-=09=09=09bool skip_hwpoisoned_pages);
+=09=09=09int isol_flags);
=20
 struct page *alloc_migrate_target(struct page *page, unsigned long private=
);
=20
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3524e2e1a9df..561371ead39a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1149,7 +1149,8 @@ static bool is_pageblock_removable_nolock(unsigned lo=
ng pfn)
 =09if (!zone_spans_pfn(zone, pfn))
 =09=09return false;
=20
-=09return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, SKIP_HWPOIS=
ON);
+=09return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE,
+=09=09=09=09    MEMORY_OFFLINE);
 }
=20
 /* Checks if this range of memory is likely to be hot-removable. */
@@ -1364,7 +1365,8 @@ static int
 check_pages_isolated_cb(unsigned long start_pfn, unsigned long nr_pages,
 =09=09=09void *data)
 {
-=09return test_pages_isolated(start_pfn, start_pfn + nr_pages, true);
+=09return test_pages_isolated(start_pfn, start_pfn + nr_pages,
+=09=09=09=09   MEMORY_OFFLINE);
 }
=20
 static int __init cmdline_parse_movable_node(char *p)
@@ -1475,7 +1477,7 @@ static int __ref __offline_pages(unsigned long start_=
pfn,
 =09/* set above range as isolated */
 =09ret =3D start_isolate_page_range(start_pfn, end_pfn,
 =09=09=09=09       MIGRATE_MOVABLE,
-=09=09=09=09       SKIP_HWPOISON | REPORT_FAILURE);
+=09=09=09=09       MEMORY_OFFLINE | REPORT_FAILURE);
 =09if (ret < 0) {
 =09=09reason =3D "failure to isolate range";
 =09=09goto failed_removal;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bf6b21f02154..e153280bde9a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8270,7 +8270,7 @@ bool has_unmovable_pages(struct zone *zone, struct pa=
ge *page, int count,
 =09=09 * The HWPoisoned page may be not in buddy system, and
 =09=09 * page_count() is not 0.
 =09=09 */
-=09=09if ((flags & SKIP_HWPOISON) && PageHWPoison(page))
+=09=09if ((flags & MEMORY_OFFLINE) && PageHWPoison(page))
 =09=09=09continue;
=20
 =09=09if (__PageMovable(page))
@@ -8486,7 +8486,7 @@ int alloc_contig_range(unsigned long start, unsigned =
long end,
 =09}
=20
 =09/* Make sure the range is really isolated. */
-=09if (test_pages_isolated(outer_start, end, false)) {
+=09if (test_pages_isolated(outer_start, end, 0)) {
 =09=09pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
 =09=09=09__func__, outer_start, end);
 =09=09ret =3D -EBUSY;
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 89c19c0feadb..04ee1663cdbe 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -168,7 +168,8 @@ __first_valid_page(unsigned long pfn, unsigned long nr_=
pages)
  * @migratetype:=09Migrate type to set in error recovery.
  * @flags:=09=09The following flags are allowed (they can be combined in
  *=09=09=09a bit mask)
- *=09=09=09SKIP_HWPOISON - ignore hwpoison pages
+ *=09=09=09MEMORY_OFFLINE - isolate to offline (!allocate) memory
+ *=09=09=09=09=09 e.g., skip over PageHWPoison() pages
  *=09=09=09REPORT_FAILURE - report details about the failure to
  *=09=09=09isolate the range
  *
@@ -257,7 +258,7 @@ void undo_isolate_page_range(unsigned long start_pfn, u=
nsigned long end_pfn,
  */
 static unsigned long
 __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn=
,
-=09=09=09=09  bool skip_hwpoisoned_pages)
+=09=09=09=09  int flags)
 {
 =09struct page *page;
=20
@@ -274,7 +275,7 @@ __test_page_isolated_in_pageblock(unsigned long pfn, un=
signed long end_pfn,
 =09=09=09 * simple way to verify that as VM_BUG_ON(), though.
 =09=09=09 */
 =09=09=09pfn +=3D 1 << page_order(page);
-=09=09else if (skip_hwpoisoned_pages && PageHWPoison(page))
+=09=09else if ((flags & MEMORY_OFFLINE) && PageHWPoison(page))
 =09=09=09/* A HWPoisoned page cannot be also PageBuddy */
 =09=09=09pfn++;
 =09=09else
@@ -286,7 +287,7 @@ __test_page_isolated_in_pageblock(unsigned long pfn, un=
signed long end_pfn,
=20
 /* Caller should ensure that requested range is in a single zone */
 int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
-=09=09=09bool skip_hwpoisoned_pages)
+=09=09=09int isol_flags)
 {
 =09unsigned long pfn, flags;
 =09struct page *page;
@@ -308,8 +309,7 @@ int test_pages_isolated(unsigned long start_pfn, unsign=
ed long end_pfn,
 =09/* Check all pages are free or marked as ISOLATED */
 =09zone =3D page_zone(page);
 =09spin_lock_irqsave(&zone->lock, flags);
-=09pfn =3D __test_page_isolated_in_pageblock(start_pfn, end_pfn,
-=09=09=09=09=09=09skip_hwpoisoned_pages);
+=09pfn =3D __test_page_isolated_in_pageblock(start_pfn, end_pfn, isol_flag=
s);
 =09spin_unlock_irqrestore(&zone->lock, flags);
=20
 =09trace_test_pages_isolated(start_pfn, end_pfn, pfn);
--=20
2.21.0

