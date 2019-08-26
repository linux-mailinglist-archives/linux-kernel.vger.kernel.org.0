Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152CE9CA75
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfHZHbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 03:31:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:50867 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfHZHbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:31:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 00:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="191648428"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga002.jf.intel.com with ESMTP; 26 Aug 2019 00:31:39 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 0/2] mm/mmap.c: reduce subtree gap propagation a little
Date:   Mon, 26 Aug 2019 15:31:04 +0800
Message-Id: <20190826073106.29971-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When insert and delete a vma, it will compute and propagate related subtree
gap. After some investigation, we can reduce subtree gap propagation a little.

[1]: This one reduce the propagation by update *next* gap after itself, since
     *next* must be a parent in this case.
[2]: This one achieve this by unlinking vma from list.

After applying these two patches, test shows it reduce 0.4% function all for
vma_compute_subtree_gap.

Wei Yang (2):
  mm/mmap.c: update *next* gap after itself
  mm/mmap.c: unlink vma before rb_erase

 mm/mmap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.17.1

