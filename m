Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3C6EB2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 15:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfJaOaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 10:30:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24930 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727905AbfJaOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572532252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fW+q4JEyGdT3dDl614K5eA1MAQq8tuqAAZNZecM/exs=;
        b=R8Ae/b+JQXs1rbKLZMAr/Y+A4in18BVqA5b3QxiK7xVY8YYas3HD7thBpMvkUzEKRak8QE
        P3KtH/BRr/JdfaGwPPMeT8JgTzFnPwKW/EvhotFIilStEgjJNEb7V66Mbs78QnECmKY5rM
        1hkHt5ickb9nJxNT0xttL4OZLkHyXuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-Pu_oPw-oNleAAvPIDUgx6Q-1; Thu, 31 Oct 2019 10:30:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E608800EB5;
        Thu, 31 Oct 2019 14:30:46 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E2865D6D6;
        Thu, 31 Oct 2019 14:30:42 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Qian Cai <cai@lca.pw>, Pingfan Liu <kernelfans@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Arun KS <arunks@codeaurora.org>
Subject: [PATCH v1 12/12] mm: remove "count" parameter from has_unmovable_pages()
Date:   Thu, 31 Oct 2019 15:29:33 +0100
Message-Id: <20191031142933.10779-13-david@redhat.com>
In-Reply-To: <20191031142933.10779-1-david@redhat.com>
References: <20191031142933.10779-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Pu_oPw-oNleAAvPIDUgx6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the memory isolate notifier is gone, the parameter is always 0.
Drop it and cleanup has_unmovable_pages().

Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Arun KS <arunks@codeaurora.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-isolation.h |  4 ++--
 mm/memory_hotplug.c            |  2 +-
 mm/page_alloc.c                | 21 +++++++--------------
 mm/page_isolation.c            |  2 +-
 4 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.=
h
index 6861df759fad..148e65a9c606 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -33,8 +33,8 @@ static inline bool is_migrate_isolate(int migratetype)
 #define MEMORY_OFFLINE=090x1
 #define REPORT_FAILURE=090x2
=20
-bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
-=09=09=09 int migratetype, int flags);
+bool has_unmovable_pages(struct zone *zone, struct page *page, int migrate=
type,
+=09=09=09 int flags);
 void set_pageblock_migratetype(struct page *page, int migratetype);
 int move_freepages_block(struct zone *zone, struct page *page,
 =09=09=09=09int migratetype, int *num_movable);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 561371ead39a..81e38e699e23 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1149,7 +1149,7 @@ static bool is_pageblock_removable_nolock(unsigned lo=
ng pfn)
 =09if (!zone_spans_pfn(zone, pfn))
 =09=09return false;
=20
-=09return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE,
+=09return !has_unmovable_pages(zone, page, MIGRATE_MOVABLE,
 =09=09=09=09    MEMORY_OFFLINE);
 }
=20
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12f3ce09d33d..efcce493452c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8182,17 +8182,15 @@ void *__init alloc_large_system_hash(const char *ta=
blename,
=20
 /*
  * This function checks whether pageblock includes unmovable pages or not.
- * If @count is not zero, it is okay to include less @count unmovable page=
s
  *
  * PageLRU check without isolation or lru_lock could race so that
  * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
  * check without lock_page also may miss some movable non-lru pages at
  * race condition. So you can't expect this function should be exact.
  */
-bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
-=09=09=09 int migratetype, int flags)
+bool has_unmovable_pages(struct zone *zone, struct page *page, int migrate=
type,
+=09=09=09 int flags)
 {
-=09unsigned long found;
 =09unsigned long iter =3D 0;
 =09unsigned long pfn =3D page_to_pfn(page);
 =09const char *reason =3D "unmovable page";
@@ -8218,13 +8216,11 @@ bool has_unmovable_pages(struct zone *zone, struct =
page *page, int count,
 =09=09goto unmovable;
 =09}
=20
-=09for (found =3D 0; iter < pageblock_nr_pages; iter++) {
-=09=09unsigned long check =3D pfn + iter;
-
-=09=09if (!pfn_valid_within(check))
+=09for (; iter < pageblock_nr_pages; iter++) {
+=09=09if (!pfn_valid_within(pfn + iter))
 =09=09=09continue;
=20
-=09=09page =3D pfn_to_page(check);
+=09=09page =3D pfn_to_page(pfn + iter);
=20
 =09=09if (PageReserved(page))
 =09=09=09goto unmovable;
@@ -8273,11 +8269,9 @@ bool has_unmovable_pages(struct zone *zone, struct p=
age *page, int count,
 =09=09if ((flags & MEMORY_OFFLINE) && PageHWPoison(page))
 =09=09=09continue;
=20
-=09=09if (__PageMovable(page))
+=09=09if (__PageMovable(page) || PageLRU(page))
 =09=09=09continue;
=20
-=09=09if (!PageLRU(page))
-=09=09=09found++;
 =09=09/*
 =09=09 * If there are RECLAIMABLE pages, we need to check
 =09=09 * it.  But now, memory offline itself doesn't call
@@ -8291,8 +8285,7 @@ bool has_unmovable_pages(struct zone *zone, struct pa=
ge *page, int count,
 =09=09 * is set to both of a memory hole page and a _used_ kernel
 =09=09 * page at boot.
 =09=09 */
-=09=09if (found > count)
-=09=09=09goto unmovable;
+=09=09goto unmovable;
 =09}
 =09return false;
 unmovable:
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 20d87d18c7cc..c0ecae9f5f93 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -37,7 +37,7 @@ static int set_migratetype_isolate(struct page *page, int=
 migratetype, int isol_
 =09 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 =09 * We just check MOVABLE pages.
 =09 */
-=09if (!has_unmovable_pages(zone, page, 0, migratetype, isol_flags))
+=09if (!has_unmovable_pages(zone, page, migratetype, isol_flags))
 =09=09ret =3D 0;
=20
 =09/*
--=20
2.21.0

