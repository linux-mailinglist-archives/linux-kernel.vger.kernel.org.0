Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8911F906
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 18:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfEOQ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 12:58:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:43946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726796AbfEOQ6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:58:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CCF40ADAB;
        Wed, 15 May 2019 16:58:48 +0000 (UTC)
Date:   Wed, 15 May 2019 18:58:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mgorman@techsingularity.net,
        james.morse@arm.com, mark.rutland@arm.com, robin.murphy@arm.com,
        cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, osalvador@suse.de, david@redhat.com,
        cai@lca.pw, logang@deltatee.com, ira.weiny@intel.com
Subject: Re: [PATCH V3 2/4] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
Message-ID: <20190515165847.GH16651@dhcp22.suse.cz>
References: <1557824407-19092-1-git-send-email-anshuman.khandual@arm.com>
 <1557824407-19092-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557824407-19092-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-05-19 14:30:05, Anshuman Khandual wrote:
> The arm64 pagetable dump code can race with concurrent modification of the
> kernel page tables. When a leaf entries are modified concurrently, the dump
> code may log stale or inconsistent information for a VA range, but this is
> otherwise not harmful.
> 
> When intermediate levels of table are freed, the dump code will continue to
> use memory which has been freed and potentially reallocated for another
> purpose. In such cases, the dump code may dereference bogus addressses,
> leading to a number of potential problems.
> 
> Intermediate levels of table may by freed during memory hot-remove, or when
> installing a huge mapping in the vmalloc region. To avoid racing with these
> cases, take the memory hotplug lock when walking the kernel page table.

Why is this a problem only on arm64 and why do we even care for debugfs?
Does anybody rely on this thing to be reliable? Do we even need it? Who
is using the file?

I am asking because I would really love to make mem hotplug locking less
scattered outside of the core MM than more. Most users simply shouldn't
care. Pfn walkers should rely on pfn_to_online_page.

-- 
Michal Hocko
SUSE Labs
