Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C1287AAA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406942AbfHIM5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 08:57:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfHIM5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:57:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3F3530CE671;
        Fri,  9 Aug 2019 12:57:33 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-120.ams2.redhat.com [10.36.117.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C4C218396;
        Fri,  9 Aug 2019 12:57:02 +0000 (UTC)
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
Subject: [PATCH v1 0/4] mm/memory_hotplug: online_pages() cleanups
Date:   Fri,  9 Aug 2019 14:56:57 +0200
Message-Id: <20190809125701.3316-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 09 Aug 2019 12:57:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cleanups (+ one fix for a special case) in the context of
online_pages(). Hope I am not missing something obvious. Did a sanity test
with DIMMs only.

David Hildenbrand (4):
  resource: Use PFN_UP / PFN_DOWN in walk_system_ram_range()
  mm/memory_hotplug: Handle unaligned start and nr_pages in
    online_pages_blocks()
  mm/memory_hotplug: Simplify online_pages_range()
  mm/memory_hotplug: online_pages cannot be 0 in online_pages()

 kernel/resource.c   |  4 +--
 mm/memory_hotplug.c | 62 ++++++++++++++++++++-------------------------
 2 files changed, 30 insertions(+), 36 deletions(-)

-- 
2.21.0

