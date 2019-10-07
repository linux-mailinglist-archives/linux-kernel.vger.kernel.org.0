Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD3FCDE18
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 11:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfJGJSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 05:18:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:44532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727295AbfJGJSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:18:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 417FCAE37;
        Mon,  7 Oct 2019 09:18:34 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Qian Cai <cai@lca.pw>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v3 0/3] followups to debug_pagealloc improvements through page_owner
Date:   Mon,  7 Oct 2019 11:18:05 +0200
Message-Id: <20191007091808.7096-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 [3]:

- Qian Cai suggested that the extra boot option and page_ext ops is unnecessary
  for a debugging option, unless somebody really complains about the overhead,
  with numbers. So patch 2 is greatly simplified.

These are followups to [1] which made it to Linus meanwhile. Patches 1 and 3
are based on Kirill's review, patch 2 on KASAN request [2]. It would be nice
if all of this made it to 5.4 with [1] already there (or at least Patch 1).

[1] https://lore.kernel.org/linux-mm/20190820131828.22684-1-vbabka@suse.cz/
[2] https://lore.kernel.org/linux-arm-kernel/20190911083921.4158-1-walter-zh.wu@mediatek.com/
[3] https://lore.kernel.org/linux-mm/20190930122916.14969-1-vbabka@suse.cz/

Vlastimil Babka (3):
  mm, page_owner: fix off-by-one error in __set_page_owner_handle()
  mm, page_owner: decouple freeing stack trace from debug_pagealloc
  mm, page_owner: rename flag indicating that page is allocated

 Documentation/dev-tools/kasan.rst |  3 ++
 include/linux/page_ext.h          | 10 +++++-
 mm/page_ext.c                     | 23 +++++--------
 mm/page_owner.c                   | 55 +++++++++++--------------------
 4 files changed, 41 insertions(+), 50 deletions(-)

-- 
2.23.0

