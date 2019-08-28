Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16DA0319
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfH1NYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 09:24:00 -0400
Received: from foss.arm.com ([217.140.110.172]:59282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfH1NYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:24:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DBF928;
        Wed, 28 Aug 2019 06:23:59 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61DF03F246;
        Wed, 28 Aug 2019 06:23:58 -0700 (PDT)
Subject: Re: cleanup the walk_page_range interface
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190808154240.9384-1-hch@lst.de>
 <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
 <20190816062751.GA16169@infradead.org> <20190823134308.GH12847@mellanox.com>
 <20190824222654.GA28766@infradead.org> <20190827013408.GC31766@mellanox.com>
 <20190827163431.65a284b295004d1ed258fbd5@linux-foundation.org>
 <20190827233619.GB28814@mellanox.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <1a0e8f03-d1c6-9325-1db3-2c3e2fd0f7d5@arm.com>
Date:   Wed, 28 Aug 2019 14:23:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827233619.GB28814@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2019 00:36, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2019 at 04:34:31PM -0700, Andrew Morton wrote:
>> On Tue, 27 Aug 2019 01:34:13 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
>>
>>> On Sat, Aug 24, 2019 at 03:26:55PM -0700, Christoph Hellwig wrote:
>>>> On Fri, Aug 23, 2019 at 01:43:12PM +0000, Jason Gunthorpe wrote:
>>>>>> So what is the plan forward?  Probably a little late for 5.3,
>>>>>> so queue it up in -mm for 5.4 and deal with the conflicts in at least
>>>>>> hmm?  Queue it up in the hmm tree even if it doesn't 100% fit?
>>>>>
>>>>> Did we make a decision on this? Due to travel & LPC I'd like to
>>>>> finalize the hmm tree next week.
>>>>
>>>> I don't think we've made any decision.  I'd still love to see this
>>>> in hmm.git.  It has a minor conflict, but I can resend a rebased
>>>> version.
>>>
>>> I'm looking at this.. The hmm conflict is easy enough to fix.
>>>
>>> But the compile conflict with these two patches in -mm requires some
>>> action from Andrew:
>>>
>>> commit 027b9b8fd9ee3be6b7440462102ec03a2d593213
>>> Author: Minchan Kim <minchan@kernel.org>
>>> Date:   Sun Aug 25 11:49:27 2019 +1000
>>>
>>>     mm: introduce MADV_PAGEOUT
>>>
>>> commit f227453a14cadd4727dd159782531d617f257001
>>> Author: Minchan Kim <minchan@kernel.org>
>>> Date:   Sun Aug 25 11:49:27 2019 +1000
>>>
>>>     mm: introduce MADV_COLD
>>>     
>>>     Patch series "Introduce MADV_COLD and MADV_PAGEOUT", v7.
>>>
>>> I'm inclined to suggest you send this series in the 2nd half of the
>>> merge window after this MADV stuff lands for least disruption? 
>>
>> Just merge it, I'll figure it out.  Probably by staging Minchan's
>> patches after linux-next.
> 
> Okay, I'll get it on a branch and merge it toward hmm.git tomorrow
> 
> Steven, do you need the branch as well for your patch series? Let me know

Since my series is (mostly) just refactoring I'm planning on rebasing it
after -rc1 and aim for v5.4 - I don't really have the time just now to
do that.

But please keep me in the loop because it'll reduce the surprises when I
do do the rebase.

Thanks,

Steve
