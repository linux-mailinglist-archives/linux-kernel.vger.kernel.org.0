Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9181C3323E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 16:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfFCOfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 10:35:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:54862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728998AbfFCOfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:35:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC697ACCE;
        Mon,  3 Jun 2019 14:35:11 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/3] debug_pagealloc improvements
Date:   Mon,  3 Jun 2019 16:34:48 +0200
Message-Id: <20190603143451.27353-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been recently debugging some pcplist corruptions, where it would be
useful to perform struct page checks immediately as pages are allocated from
and freed to pcplists, which is now only possible by rebuilding the kernel with
CONFIG_DEBUG_VM (details in Patch 2 changelog).

To make this kind of debugging simpler in future on a distro kernel, I have
improved CONFIG_DEBUG_PAGEALLOC so that it has even smaller overhead when not
enabled at boot time (Patch 1) and also when enabled (Patch 3), and extended it
to perform the struct page checks more often when enabled (Patch 2). Now it can
be configured in when building a distro kernel without extra overhead, and
debugging page use after free or double free can be enabled simply by rebooting
with debug_pagealloc=on.

Vlastimil Babka (3):
  mm, debug_pagelloc: use static keys to enable debugging
  mm, page_alloc: more extensive free page checking with debug_pagealloc
  mm, debug_pagealloc: use a page type instead of page_ext flag

 .../admin-guide/kernel-parameters.txt         |  10 +-
 include/linux/mm.h                            |  25 ++--
 include/linux/page-flags.h                    |   6 +
 include/linux/page_ext.h                      |   1 -
 mm/Kconfig.debug                              |  14 ++-
 mm/page_alloc.c                               | 114 ++++++++++--------
 mm/page_ext.c                                 |   3 -
 7 files changed, 96 insertions(+), 77 deletions(-)

-- 
2.21.0

