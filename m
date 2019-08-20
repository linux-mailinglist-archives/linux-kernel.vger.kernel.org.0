Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE9495FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 15:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfHTNSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 09:18:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:56360 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729409AbfHTNSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:18:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0EACAC50;
        Tue, 20 Aug 2019 13:18:38 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 0/4] debug_pagealloc improvements through page_owner
Date:   Tue, 20 Aug 2019 15:18:24 +0200
Message-Id: <20190820131828.22684-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: also fix THP split handling (added Patch 1) per Kirill

The debug_pagealloc functionality serves a similar purpose on the page
allocator level that slub_debug does on the kmalloc level, which is to detect
bad users. One notable feature that slub_debug has is storing stack traces of
who last allocated and freed the object. On page level we track allocations via
page_owner, but that info is discarded when freeing, and we don't track freeing
at all. This series improves those aspects. With both debug_pagealloc and
page_owner enabled, we can then get bug reports such as the example in Patch 4.

SLUB debug tracking additionaly stores cpu, pid and timestamp. This could be
added later, if deemed useful enough to justify the additional page_ext
structure size.

Vlastimil Babka (4):
  mm, page_owner: handle THP splits correctly
  mm, page_owner: record page owner for each subpage
  mm, page_owner: keep owner info when freeing the page
  mm, page_owner, debug_pagealloc: save and dump freeing stack trace

 .../admin-guide/kernel-parameters.txt         |   2 +
 include/linux/page_ext.h                      |   1 +
 mm/Kconfig.debug                              |   4 +-
 mm/huge_memory.c                              |   4 +
 mm/page_owner.c                               | 123 +++++++++++++-----
 5 files changed, 100 insertions(+), 34 deletions(-)

-- 
2.22.0

