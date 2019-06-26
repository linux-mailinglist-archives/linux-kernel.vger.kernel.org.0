Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4415644B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfFZIPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 04:15:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:57078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfFZIPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:15:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3DF6BAD09;
        Wed, 26 Jun 2019 08:15:19 +0000 (UTC)
Date:   Wed, 26 Jun 2019 10:15:16 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, pasha.tatashin@soleen.com,
        Jonathan.Cameron@huawei.com, anshuman.khandual@arm.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Allocate memmap from hotadded memory
Message-ID: <20190626081516.GC30863@linux>
References: <20190625075227.15193-1-osalvador@suse.de>
 <2ebfbd36-11bd-9576-e373-2964c458185b@redhat.com>
 <20190626080249.GA30863@linux>
 <2750c11a-524d-b248-060c-49e6b3eb8975@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2750c11a-524d-b248-060c-49e6b3eb8975@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:11:06AM +0200, David Hildenbrand wrote:
> Back then, I already mentioned that we might have some users that
> remove_memory() they never added in a granularity it wasn't added. My
> concerns back then were never fully sorted out.
> 
> arch/powerpc/platforms/powernv/memtrace.c
> 
> - Will remove memory in memory block size chunks it never added
> - What if that memory resides on a DIMM added via MHP_MEMMAP_DEVICE?
> 
> Will it at least bail out? Or simply break?
> 
> IOW: I am not yet 100% convinced that MHP_MEMMAP_DEVICE is save to be
> introduced.

Uhm, I will take a closer look and see if I can clear your concerns.
TBH, I did not try to use arch/powerpc/platforms/powernv/memtrace.c
yet.

I will get back to you once I tried it out.

-- 
Oscar Salvador
SUSE L3
