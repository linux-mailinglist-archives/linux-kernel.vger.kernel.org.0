Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A91BC430
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 10:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440678AbfIXIlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 04:41:02 -0400
Received: from foss.arm.com ([217.140.110.172]:55808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439012AbfIXIlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:41:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB404142F;
        Tue, 24 Sep 2019 01:41:01 -0700 (PDT)
Received: from [10.162.40.141] (p8cg001049571a15.blr.arm.com [10.162.40.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 789293F59C;
        Tue, 24 Sep 2019 01:40:55 -0700 (PDT)
Subject: Re: [PATCH V8 2/2] arm64/mm: Enable memory hot remove
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        mhocko@suse.com, david@redhat.com, cai@lca.pw, logang@deltatee.com,
        cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com,
        broonie@kernel.org, valentin.schneider@arm.com,
        Robin.Murphy@arm.com, steven.price@arm.com, suzuki.poulose@arm.com,
        ira.weiny@intel.com
References: <1569217425-23777-1-git-send-email-anshuman.khandual@arm.com>
 <1569217425-23777-3-git-send-email-anshuman.khandual@arm.com>
 <20190923111745.GG15392@bombadil.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <962f7849-f42d-9154-92ae-3125d2f19504@arm.com>
Date:   Tue, 24 Sep 2019 14:11:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190923111745.GG15392@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/23/2019 04:47 PM, Matthew Wilcox wrote:
> On Mon, Sep 23, 2019 at 11:13:45AM +0530, Anshuman Khandual wrote:
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +static void free_hotplug_page_range(struct page *page, size_t size)
>> +{
>> +	WARN_ON(!page || PageReserved(page));
> 
> WARN_ON(!page) isn't terribly useful.  You're going to crash on the very
> next line when you call page_address() anyway.  If this line were
> 
> 	if (WARN_ON(!page || PageReserved(page)))
> 		return;
> 
> it would make sense, or if it were just
> 
> 	WARN_ON(PageReserved(page))
> 
> it would also make sense.

I guess WARN_ON(PageReserved(page)) should be good enough to make sure
that page being freed here was originally allocated at runtime for a
previous memory hot add operation and did not some how come from the
memblock reserved area. That was the original objective for this check.
Will change it.

> 
>> +	free_pages((unsigned long)page_address(page), get_order(size));
>> +}
> 
