Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA1114C3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 01:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgA2A1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 19:27:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:18597 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgA2A1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 19:27:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 16:27:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,375,1574150400"; 
   d="scan'208";a="223688949"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jan 2020 16:27:04 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        kirill@shutemov.name, dan.j.williams@intel.com,
        yang.shi@linux.alibaba.com, thellstrom@vmware.com,
        richardw.yang@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com
Subject: [Patch v2 0/4] mm/mremap: cleanup move_page_tables() a little
Date:   Wed, 29 Jan 2020 08:26:38 +0800
Message-Id: <20200129002642.13508-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move_page_tables() tries to move page table by PMD or PTE.

The root reason is if it tries to move PMD, both old and new range should
be PMD aligned. But current code calculate old range and new range
separately.  This leads to some redundant check and calculation.

This cleanup tries to consolidate the range check in one place to reduce
some extra range handling.

v2:
  * remove 3rd patch which doesn't work on ARM platform. Thanks report from
    Dmitry Osipenko

Wei Yang (4):
  mm/mremap: format the check in move_normal_pmd() same as
    move_huge_pmd()
  mm/mremap: it is sure to have enough space when extent meets
    requirement
  mm/mremap: calculate extent in one place
  mm/mremap: start addresses are properly aligned

 include/linux/huge_mm.h |  2 +-
 mm/huge_memory.c        |  8 +-------
 mm/mremap.c             | 17 ++++++-----------
 3 files changed, 8 insertions(+), 19 deletions(-)

-- 
2.17.1

