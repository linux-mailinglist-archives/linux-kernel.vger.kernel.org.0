Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4912154F4C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 00:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgBFXRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 18:17:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:40466 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBFXRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:17:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 15:17:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,411,1574150400"; 
   d="scan'208";a="226308897"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 06 Feb 2020 15:17:29 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        david@redhat.com, Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 0/3] Fixes "mm/sparsemem: support sub-section hotplug"
Date:   Fri,  7 Feb 2020 07:16:26 +0800
Message-Id: <20200206231629.14151-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During reviewing David's code, I found current sub-section hotplug is
broken in several places.

The following link fix one potential issue, while David and I still spot
some suspicious points.

https://lkml.org/lkml/2020/2/6/334

The problem here is mainly about the memmap manipulation:

  * memmap would be overwrite if not use SPARSEMEM_VMEMMAP
  * only need to adjust memmap for SPARSEMEM_VMEMMAP

Wei Yang (3):
  mm/sparsemem: adjust memmap only for SPARSEMEM_VMEMMAP
  mm/sparsemem: get physical address to page struct instead of virtual
    address to pfn
  mm/sparsemem: avoid memmap overwrite for non-SPARSEMEM_VMEMMAP

 mm/sparse.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.17.1

