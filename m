Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E64172F71
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 04:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbgB1Dih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 22:38:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:36522 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730586AbgB1Dih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:38:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 19:38:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="232107346"
Received: from yhuang-dev.sh.intel.com ([10.239.159.23])
  by orsmga008.jf.intel.com with ESMTP; 27 Feb 2020 19:38:33 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: [RFC 0/3] mm: Discard lazily freed pages when migrating
Date:   Fri, 28 Feb 2020 11:38:16 +0800
Message-Id: <20200228033819.3857058-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

MADV_FREE is a lazy free mechanism in Linux.  According to the manpage
of mavise(2), the semantics of MADV_FREE is,

  The application no longer requires the pages in the range specified
  by addr and len.  The kernel can thus free these pages, but the
  freeing could be delayed until memory pressure occurs. ...

Originally, the pages freed lazily by MADV_FREE will only be freed
really by page reclaiming when there is memory pressure or when
unmapping the address range.  In addition to that, there's another
opportunity to free these pages really, when we try to migrate them.

The main value to do that is to avoid to create the new memory
pressure immediately if possible.  Instead, even if the pages are
required again, they will be allocated gradually on demand.  That is,
the memory will be allocated lazily when necessary.  This follows the
common philosophy in the Linux kernel, allocate resources lazily on
demand.

This patchset implement this in addition to some cleanup to migration
and MADV_FREE code.

Best Regards,
Huang, Ying
