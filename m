Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F6C8D751
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 17:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfHNPlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 11:41:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfHNPlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:41:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F76A51EF3;
        Wed, 14 Aug 2019 15:41:15 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B9418069C;
        Wed, 14 Aug 2019 15:41:09 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arun KS <arunks@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v2 0/5] mm/memory_hotplug: online_pages() cleanups
Date:   Wed, 14 Aug 2019 17:41:04 +0200
Message-Id: <20190814154109.3448-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 14 Aug 2019 15:41:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cleanups (+ one fix for a special case) in the context of
online_pages(). Hope I am not missing something obvious. Did a sanity test
with DIMMs only.

v1 -> v2:
- "mm/memory_hotplug: Handle unaligned start and nr_pages in
   online_pages_blocks()"
-- Turned into "mm/memory_hotplug: make sure the pfn is aligned to the
		order when onlining"
-- Dropped the "nr_pages not an order of two" condition for now as
   requested by Michal, but kept a simplified alignment check
- "mm/memory_hotplug: Drop PageReserved() check in online_pages_range()"
-- Split out from "mm/memory_hotplug: Simplify online_pages_range()"
- "mm/memory_hotplug: Simplify online_pages_range()"
-- Modified due to the other changes

David Hildenbrand (5):
  resource: Use PFN_UP / PFN_DOWN in walk_system_ram_range()
  mm/memory_hotplug: Drop PageReserved() check in online_pages_range()
  mm/memory_hotplug: Simplify online_pages_range()
  mm/memory_hotplug: Make sure the pfn is aligned to the order when
    onlining
  mm/memory_hotplug: online_pages cannot be 0 in online_pages()

 kernel/resource.c   |  4 +--
 mm/memory_hotplug.c | 61 ++++++++++++++++++++-------------------------
 2 files changed, 29 insertions(+), 36 deletions(-)

-- 
2.21.0

