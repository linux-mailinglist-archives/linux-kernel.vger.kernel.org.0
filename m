Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C08FBE00E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437270AbfIYObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 10:31:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437135AbfIYObV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:31:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F15E2B044;
        Wed, 25 Sep 2019 14:31:18 +0000 (UTC)
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
Subject: [PATCH 0/3] followups to debug_pagealloc improvements through page_owner
Date:   Wed, 25 Sep 2019 16:30:49 +0200
Message-Id: <20190925143056.25853-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are followups to [1] which made it to Linus meanwhile. Patches 1 and 3
are based on Kirill's review, patch 2 on KASAN request [2]. It would be nice
if all of this made it to 5.4 with [1] already there (or at least Patch 1).

[1] https://lore.kernel.org/linux-mm/20190820131828.22684-1-vbabka@suse.cz/
[2] https://lore.kernel.org/linux-arm-kernel/20190911083921.4158-1-walter-zh.wu@mediatek.com/

Vlastimil Babka (3):
  mm, page_owner: fix off-by-one error in __set_page_owner_handle()
  mm, debug, kasan: save and dump freeing stack trace for kasan
  mm, page_owner: rename flag indicating that page is allocated

 Documentation/dev-tools/kasan.rst |  4 +++
 include/linux/page_ext.h          | 10 +++++-
 mm/Kconfig.debug                  |  4 +++
 mm/page_ext.c                     | 23 +++++-------
 mm/page_owner.c                   | 58 +++++++++++++++++--------------
 5 files changed, 57 insertions(+), 42 deletions(-)

-- 
2.23.0

