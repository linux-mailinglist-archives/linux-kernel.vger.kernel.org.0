Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAD014EF81
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 16:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgAaPZP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Jan 2020 10:25:15 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:61171 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728839AbgAaPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:25:14 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20074443-1500050 
        for multiple; Fri, 31 Jan 2020 15:24:14 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1426784902-125149-10-git-send-email-kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@gentwo.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Steve Capper <steve.capper@linaro.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <1426784902-125149-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1426784902-125149-10-git-send-email-kirill.shutemov@linux.intel.com>
Message-ID: <158048425224.2430.4905670949721797624@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 09/16] page-flags: define PG_reserved behavior on compound pages
Date:   Fri, 31 Jan 2020 15:24:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kirill A. Shutemov (2015-03-19 17:08:15)
> As far as I can see there's no users of PG_reserved on compound pages.
> Let's use NO_COMPOUND here.

Much later than you would ever expect, but we just had a user update an
ancient device and trip over this.
https://gitlab.freedesktop.org/drm/intel/issues/1027

In drm_pci_alloc() we allocate a high-order page (for it to be physically
contiguous) and mark each page as Reserved.

        dmah->vaddr = dma_alloc_coherent(&dev->pdev->dev, size,
                                         &dmah->busaddr,
                                         GFP_KERNEL | __GFP_COMP);

        /* XXX - Is virt_to_page() legal for consistent mem? */
        /* Reserve */
        for (addr = (unsigned long)dmah->vaddr, sz = size;
             sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
                SetPageReserved(virt_to_page((void *)addr));
        }

It's been doing that since

commit ddf19b973be5a96d77c8467f657fe5bd7d126e0f
Author: Dave Airlie <airlied@linux.ie>
Date:   Sun Mar 19 18:56:12 2006 +1100

    drm: fixup PCI DMA support

I haven't found anything to say if we are meant to be reserving the
pages or not. So I bring it to your attention, asking for help.

Thanks,
-Chris
