Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB65C9B25
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 11:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfJCJxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 05:53:04 -0400
Received: from foss.arm.com ([217.140.110.172]:39940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbfJCJxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:53:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B9D91000;
        Thu,  3 Oct 2019 02:52:59 -0700 (PDT)
Received: from [10.162.40.180] (p8cg001049571a15.blr.arm.com [10.162.40.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84E9F3F739;
        Thu,  3 Oct 2019 02:52:56 -0700 (PDT)
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
To:     Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
References: <1570090257-25001-1-git-send-email-anshuman.khandual@arm.com>
 <7FA7CBE1-E0A9-40E2-B3CA-0896F6D491E5@lca.pw>
 <37b43978-5652-576c-8990-451e751b7c67@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f0f8b62f-fd49-c915-3f96-b4821e7fb986@arm.com>
Date:   Thu, 3 Oct 2019 15:23:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <37b43978-5652-576c-8990-451e751b7c67@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2019 03:02 PM, Anshuman Khandual wrote:
> 
> On 10/03/2019 02:35 PM, Qian Cai wrote:
>>
>>> On Oct 3, 2019, at 4:10 AM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>>
>>> Having unmovable pages on a given pageblock should be reported correctly
>>> when required with REPORT_FAILURE flag. But there can be a scenario where a
>>> reserved page in the page block will get reported as a generic "unmovable"
>>> reason code. Instead this should be changed to a more appropriate reason
>>> code like "Reserved page".
>> Isn’t this redundant as it dumps the flags in dump_page() anyway?
> Even though page flags does contain reserved bit information, the problem
> is that we are explicitly printing the reason for this page dump. In this
> case it is caused by the fact that it is a reserved page.
> 
> page dumped because: <reason>
> 
> The proposed change makes it explicit that the dump is caused because a
> non movable page with reserved bit set. It also helps in differentiating 
> between reserved bit condition and the last one "if (found > count)"

Instead, will it better to rename the reason codes as

1. "Unmovable (CMA)"
2. "Unmovable (Reserved)"
3. "Unmovable (Private/non-LRU)"
