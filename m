Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEF72DB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfE2Kuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 06:50:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43426 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfE2Kuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:50:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1F13341;
        Wed, 29 May 2019 03:50:49 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C21743F59C;
        Wed, 29 May 2019 03:50:47 -0700 (PDT)
Subject: Re: [RFC 4/7] arm64: pmu: Add function implementation to update event
 index in userpage.
To:     Raphael Gault <raphael.gault@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, acme@kernel.org, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org
References: <20190528150320.25953-1-raphael.gault@arm.com>
 <20190528150320.25953-5-raphael.gault@arm.com>
 <20190529094659.GK2623@hirez.programming.kicks-ass.net>
 <42a937dd-5cf6-6738-6f69-005fce64138f@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d6f40c6c-6a73-bd7f-e384-050bd9428631@arm.com>
Date:   Wed, 29 May 2019 11:50:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <42a937dd-5cf6-6738-6f69-005fce64138f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2019 11:46, Raphael Gault wrote:
> Hi Peter,
> 
> On 5/29/19 10:46 AM, Peter Zijlstra wrote:
>> On Tue, May 28, 2019 at 04:03:17PM +0100, Raphael Gault wrote:
>>> +static int armv8pmu_access_event_idx(struct perf_event *event)
>>> +{
>>> +    if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
>>> +        return 0;
>>> +
>>> +    /*
>>> +     * We remap the cycle counter index to 32 to
>>> +     * match the offset applied to the rest of
>>> +     * the counter indeces.
>>> +     */
>>> +    if (event->hw.idx == ARMV8_IDX_CYCLE_COUNTER)
>>> +        return 32;
>>> +
>>> +    return event->hw.idx;
>>
>> Is there a guarantee event->hw.idx is never 0? Or should you, just like
>> x86, use +1 here?
>>
> 
> You are right, I should use +1 here. Thanks for pointing that out.

Isn't that already the case though, since we reserve index 0 for the 
cycle counter? I'm looking at ARMV8_IDX_TO_COUNTER() here...

Robin.
