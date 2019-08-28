Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E9E9F77A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 02:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfH1Aj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 20:39:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:63039 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfH1Aj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 20:39:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 17:39:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,439,1559545200"; 
   d="scan'208";a="381112530"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2019 17:39:25 -0700
Date:   Wed, 28 Aug 2019 08:39:03 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Qian Cai <cai@lca.pw>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Don't manually decrement num_poisoned_pages
Message-ID: <20190828003903.GB15462@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190827053656.32191-1-alastair@au1.ibm.com>
 <20190827053656.32191-2-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827053656.32191-2-alastair@au1.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:36:54PM +1000, Alastair D'Silva wrote:
>From: Alastair D'Silva <alastair@d-silva.org>
>
>Use the function written to do it instead.
>
>Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> mm/sparse.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/mm/sparse.c b/mm/sparse.c
>index 72f010d9bff5..e41917a7e844 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -11,6 +11,8 @@
> #include <linux/export.h>
> #include <linux/spinlock.h>
> #include <linux/vmalloc.h>
>+#include <linux/swap.h>
>+#include <linux/swapops.h>
> 
> #include "internal.h"
> #include <asm/dma.h>
>@@ -898,7 +900,7 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
> 
> 	for (i = 0; i < nr_pages; i++) {
> 		if (PageHWPoison(&memmap[i])) {
>-			atomic_long_sub(1, &num_poisoned_pages);
>+			num_poisoned_pages_dec();
> 			ClearPageHWPoison(&memmap[i]);
> 		}
> 	}
>-- 
>2.21.0

-- 
Wei Yang
Help you, Help me
