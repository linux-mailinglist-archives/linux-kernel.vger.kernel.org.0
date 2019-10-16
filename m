Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E510BD8FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbfJPLtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 07:49:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:45500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728323AbfJPLtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:49:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 737E8B435;
        Wed, 16 Oct 2019 11:49:35 +0000 (UTC)
Date:   Wed, 16 Oct 2019 13:49:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Make alloc_gigantic_page() available for
 general use
Message-ID: <20191016114934.GZ317@dhcp22.suse.cz>
References: <1571211293-29974-1-git-send-email-anshuman.khandual@arm.com>
 <c7ac9f99-a34f-c553-b216-b847d093cae9@redhat.com>
 <20191016085123.GO317@dhcp22.suse.cz>
 <679b5c66-8f1b-ec4d-64dd-13fbc440917d@redhat.com>
 <20191016110831.GV317@dhcp22.suse.cz>
 <eb2406d5-1327-1365-be0e-ee319ab92088@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb2406d5-1327-1365-be0e-ee319ab92088@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 13:10:41, David Hildenbrand wrote:
> On 16.10.19 13:08, Michal Hocko wrote:
> > On Wed 16-10-19 10:56:16, David Hildenbrand wrote:
[...]
> > > Gigantic pages have to be aligned AFAIK.
> > 
> > Aligned to what? I do not see any guarantee like that in the existing
> > code.
> > 
> 
> pfn = ALIGN(zone->zone_start_pfn, nr_pages);

I am obviously blind! Sorry about the confusion.

-- 
Michal Hocko
SUSE Labs
