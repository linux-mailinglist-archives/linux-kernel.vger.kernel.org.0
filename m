Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9609A4A0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfFRM2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 08:28:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36055 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRM2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:28:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45SnRn1qLNz9s9y;
        Tue, 18 Jun 2019 22:28:21 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, peterz@infradead.org
Cc:     jolsa@redhat.com, maddy@linux.vnet.ibm.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v2] perf ioctl: Add check for the sample_period value
In-Reply-To: <e1d0fcf5-d7f8-44a0-a3b8-339f2b79fb2c@linux.ibm.com>
References: <87h89eq55e.fsf@concordia.ellerman.id.au> <20190604042953.914-1-ravi.bangoria@linux.ibm.com> <e1d0fcf5-d7f8-44a0-a3b8-339f2b79fb2c@linux.ibm.com>
Date:   Tue, 18 Jun 2019 22:28:19 +1000
Message-ID: <87k1djoz6k.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:
> Peter / mpe,
>
> Is the v2 looks good? If so, can anyone of you please pick this up.

I usually wouldn't take it, it's generic perf code. Unless
peter/ingo/acme tell me otherwise.

It's sort of a bug fix for 0819b2e30ccb, should it have a fixes and/or
stable tag?

  Fixes: 0819b2e30ccb ("perf: Limit perf_event_attr::sample_period to 63 bits")
  Cc: stable@vger.kernel.org # v3.15+

cheers

> On 6/4/19 9:59 AM, Ravi Bangoria wrote:
>> perf_event_open() limits the sample_period to 63 bits. See
>> commit 0819b2e30ccb ("perf: Limit perf_event_attr::sample_period
>> to 63 bits"). Make ioctl() consistent with it.
>> 
>> Also on powerpc, negative sample_period could cause a recursive
>> PMIs leading to a hang (reported when running perf-fuzzer).
>> 
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> ---
>>  kernel/events/core.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index abbd4b3b96c2..e44c90378940 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -5005,6 +5005,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
>>  	if (perf_event_check_period(event, value))
>>  		return -EINVAL;
>>  
>> +	if (!event->attr.freq && (value & (1ULL << 63)))
>> +		return -EINVAL;
>> +
>>  	event_function_call(event, __perf_event_period, &value);
>>  
>>  	return 0;
>> 
