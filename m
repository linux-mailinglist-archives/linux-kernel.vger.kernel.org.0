Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA4E165D94
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 13:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgBTM1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 07:27:43 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:23429 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgBTM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:27:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id DD9EA3F65E;
        Thu, 20 Feb 2020 13:27:40 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=YUVwVNYx;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id suS8Fnzl-PuE; Thu, 20 Feb 2020 13:27:39 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D77BD3F481;
        Thu, 20 Feb 2020 13:27:34 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 10D7536016C;
        Thu, 20 Feb 2020 13:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1582201654; bh=IXNf/Qbi8TyXfdlIfuX8eOlUFvlWatv8T9EkfzwiBlM=;
        h=From:To:Cc:Subject:Date:From;
        b=YUVwVNYxXZ8kFmNnFRiXwjX0URvz/NEyhVNuWQ3Cmhu+eSHIBGq+ggUWDS/XMDWfr
         49Y5X+zRVYCGXGTPCVOWEWBRsmEyyhI725h/K/v3wQkp2ruPcdo5D2gwS2CwACljtl
         u7su0Wm7s2eqin4yCC6/sYLO541Css8WqirycZ+E=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v4 0/9] Huge page-table entries for TTM
Date:   Thu, 20 Feb 2020 13:27:10 +0100
Message-Id: <20200220122719.4302-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce TLB misses and CPU usage this patchset enables huge-
and giant page-table entries for TTM and TTM-enabled graphics drivers.

Patch 1 and 2 introduce a vma_is_special_huge() function to make the mm code
take the same path as DAX when splitting huge- and giant page table entries,
(which currently means zapping the page-table entry and rely on re-faulting).

Patch 3 makes the mm code split existing huge page-table entries
on huge_fault fallbacks. Typically on COW or on buffer-objects that want
write-notify. COW and write-notification is always done on the lowest
page-table level. See the patch log message for additional considerations.

Patch 4 introduces functions to allow the graphics drivers to manipulate
the caching- and encryption flags of huge page-table entries without ugly
hacks.

Patch 5 implements the huge_fault handler in TTM.
This enables huge page-table entries, provided that the kernel is configured
to support transhuge pages, either by default or using madvise().
However, they are unlikely to be inserted unless the kernel buffer object
pfns and user-space addresses align perfectly. There are various options
here, but since buffer objects that reside in system pages typically start
at huge page boundaries if they are backed by huge pages, we try to enforce
buffer object starting pfns and user-space addresses to be huge page-size
aligned if their size exceeds a huge page-size. If pud-size transhuge
("giant") pages are enabled by the arch, the same holds for those.

Patch 6 implements a specialized huge_fault handler for vmwgfx.
The vmwgfx driver may perform dirty-tracking and needs some special code
to handle that correctly.

Patch 7 implements a drm helper to align user-space addresses according
to the above scheme, if possible.

Patch 8 implements a TTM range manager for vmwgfx that does the same for
graphics IO memory. This may later be reused by other graphics drivers
if necessary.

Patch 9 finally hooks up the helpers of patch 7 and 8 to the vmwgfx driver.
A similar change is needed for graphics drivers that want a reasonable
likelyhood of actually using huge page-table entries.

If a buffer object size is not huge-page or giant-page aligned,
its size will NOT be inflated by this patchset. This means that the buffer
object tail will use smaller size page-table entries and thus no memory
overhead occurs. Drivers that want to pay the memory overhead price need to
implement their own scheme to inflate buffer-object sizes.

PMD size huge page-table-entries have been tested with vmwgfx and found to
work well both with system memory backed and IO memory backed buffer objects.

PUD size giant page-table-entries have seen limited (fault and COW) testing
using a modified kernel (to support 1GB page allocations) and a fake vmwgfx
TTM memory type. The vmwgfx driver does otherwise not support 1GB-size IO
memory resources.

Comments and suggestions welcome.
Thomas

Changes since RFC:
* Check for buffer objects present in contigous IO Memory (Christian König)
* Rebased on the vmwgfx emulated coherent memory functionality. That rebase
  adds patch 5.
Changes since v1:
* Make the new TTM range manager vmwgfx-specific. (Christian König)
* Minor fixes for configs that don't support or only partially support
  transhuge pages.
Changes since v2:
* Minor coding style and doc fixes in patch 5/9 (Christian König)
* Patch 5/9 doesn't touch mm. Remove from the patch title.
Changes since v3:
* Added reviews and acks
* Implemented ugly but generic ttm_pgprot_is_wrprotecting() instead of arch
  specific code.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>


