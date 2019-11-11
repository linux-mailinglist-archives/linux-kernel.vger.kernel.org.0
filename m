Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C8DF7815
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 16:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKKPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 10:53:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:62213 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfKKPxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:53:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 07:53:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="287210461"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 11 Nov 2019 07:53:38 -0800
Received: from [10.252.3.28] (abudanko-mobl.ccr.corp.intel.com [10.252.3.28])
        by linux.intel.com (Postfix) with ESMTP id 6754E5802E4;
        Mon, 11 Nov 2019 07:53:36 -0800 (PST)
Subject: Re: [RFC] perf session: Fix compression processing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20191103222441.GE8251@krava>
 <d57725e6-e62f-b37e-6cb4-28bf521faaea@linux.intel.com>
 <20191111145640.GB26980@krava>
 <69782f54-f5f5-f89f-9c8d-172d4de331d0@linux.intel.com>
 <20191111154612.GC26980@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <84f6c330-95bc-b615-4366-8a243d1f5c20@linux.intel.com>
Date:   Mon, 11 Nov 2019 18:53:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191111154612.GC26980@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.2019 18:46, Jiri Olsa wrote:
> On Mon, Nov 11, 2019 at 06:41:47PM +0300, Alexey Budankov wrote:
>> On 11.11.2019 17:56, Jiri Olsa wrote:
>>> On Mon, Nov 11, 2019 at 05:38:49PM +0300, Alexey Budankov wrote:
>>>>
>>>> On 04.11.2019 1:24, Jiri Olsa wrote:
>>>>> hi,
>>>> <SNIP>
>>>>> ---
>>>>> The compressed data processing occasionally fails with:
>>>>>   $ perf report --stdio -vv
>>>>>   decomp (B): 44519 to 163000
>>>>>   decomp (B): 48119 to 174800
>>>>>   decomp (B): 65527 to 131072
>>>>>   fetch_mmaped_event: head=0x1ffe0 event->header_size=0x28, mmap_size=0x20000: fuzzed perf.data?
>>>>>   Error:
>>>>>   failed to process sample
>>>>>   ...
>>>>>
>>>>> It's caused by recent fuzzer fix that does not take into account
>>>>> that compressed data do not need to by fully present in the buffer,
>>>>> so it's ok to just return NULL and not to fail.
>>>>>
>>>>> Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
>>>>> Link: http://lkml.kernel.org/n/tip-q1biqscs4stcmc9bs1iokfro@git.kernel.org
>>>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>>>> ---
>>>>>  tools/perf/util/session.c | 8 +++++---
>>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>>>>> index f07b8ecb91bc..3589ed14a629 100644
>>>>> --- a/tools/perf/util/session.c
>>>>> +++ b/tools/perf/util/session.c
>>>>> @@ -1959,7 +1959,7 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>>>>>  
>>>>>  static union perf_event *
>>>>>  fetch_mmaped_event(struct perf_session *session,
>>>>> -		   u64 head, size_t mmap_size, char *buf)
>>>>> +		   u64 head, size_t mmap_size, char *buf, bool decomp)
>>>>
>>>> bools in interface make code less transparent.
>>>>
>>>>>  {
>>>>>  	union perf_event *event;
>>>>>  
>>>>> @@ -1979,6 +1979,8 @@ fetch_mmaped_event(struct perf_session *session,
>>>>>  		/* We're not fetching the event so swap back again */
>>>>>  		if (session->header.needs_swap)
>>>>>  			perf_event_header__bswap(&event->header);
>>>>> +		if (decomp)
>>>>> +			return NULL;
>>>>>  		pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx: fuzzed perf.data?\n",
>>>>>  			 __func__, head, event->header.size, mmap_size);
>>>>>  		return ERR_PTR(-EINVAL);
>>>>> @@ -1997,7 +1999,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>>>>>  		return 0;
>>>>>  
>>>>>  	while (decomp->head < decomp->size && !session_done()) {
>>>>> -		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
>>>>> +		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data, true);
>>>>
>>>> It looks like this call can be skipped, at all, in this case.
>>>
>>> not sure what you mean, we are in decomp code no?
>>
>> Ok, it is inside "not fetching" branch. 
>> NULL return value means to proceed getting further over the trace.
>> Checking record type == COMPRESSED at the higher level could 
>> probably be cleaner fix and also work faster.
> 
> any chance you could post the fix? the patch I did was a
> quick fix to get the feature working for presentation ;-)
> you're probably thinking of the proper approach

Please share the exact reproducing steps 
so I could come up with something.

~Alexey

> 
> thanks,
> jirka
> 
> 
