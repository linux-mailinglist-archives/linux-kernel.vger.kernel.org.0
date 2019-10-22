Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 329BEE0076
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbfJVJOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 05:14:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731314AbfJVJOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:14:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 360B2B954;
        Tue, 22 Oct 2019 09:14:32 +0000 (UTC)
Date:   Tue, 22 Oct 2019 11:14:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 0/2] mm: Memory offlining + page isolation cleanups
Message-ID: <20191022091431.GG9379@dhcp22.suse.cz>
References: <20191021172353.3056-1-david@redhat.com>
 <25d3f071-3268-298b-e0c8-9c307d1015fe@redhat.com>
 <20191022080835.GZ9379@dhcp22.suse.cz>
 <1f56744d-2c22-6c12-8fe8-4a71e791c467@redhat.com>
 <20191022082131.GC9379@dhcp22.suse.cz>
 <de39873c-ae55-88ed-0b4e-4f67a75ef81c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de39873c-ae55-88ed-0b4e-4f67a75ef81c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 10:32:11, David Hildenbrand wrote:
[...]
> E.g., arch/x86/kvm/mmu.c:kvm_is_mmio_pfn()

Thanks for these references. I am not really familiar with kvm so I
cannot really comment on the specific code but I am wondering why
it simply doesn't check for ZONE_DEVICE explicitly? Also we do care
about holes in RAM (from the early boot), those should be reserved
already AFAIR. So we are left with hotplugged memory with holes and
I am not really sure we should bother with this until there is a clear
usecase in sight.
-- 
Michal Hocko
SUSE Labs
