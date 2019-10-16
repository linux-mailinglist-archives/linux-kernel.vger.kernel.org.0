Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47173D8DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 12:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404551AbfJPKbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 06:31:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:51693 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfJPKbp (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:31:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 03:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="189639624"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.210.124]) ([10.254.210.124])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2019 03:31:42 -0700
Subject: Re: [PATCH] perf list: Hide deprecated events by default
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191015025357.8708-1-yao.jin@linux.intel.com>
 <20191015091401.GE10951@krava>
 <627305a7-3aec-037a-1c36-6ca884f35d1d@linux.intel.com>
 <20191016072741.GA15031@krava>
 <2a1d1883-ca28-2dae-4ae3-fbae81174d55@linux.intel.com>
 <20191016102742.GA30251@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <64a29c2f-cbd3-1aa8-94b7-3d46c2325cd1@linux.intel.com>
Date:   Wed, 16 Oct 2019 18:31:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016102742.GA30251@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2019 6:27 PM, Jiri Olsa wrote:
> On Wed, Oct 16, 2019 at 06:22:06PM +0800, Jin, Yao wrote:
>>
>>
>> On 10/16/2019 3:27 PM, Jiri Olsa wrote:
>>> On Wed, Oct 16, 2019 at 08:59:13AM +0800, Jin, Yao wrote:
>>>>
>>>>
>>>> On 10/15/2019 5:14 PM, Jiri Olsa wrote:
>>>>> On Tue, Oct 15, 2019 at 10:53:57AM +0800, Jin Yao wrote:
>>>>>> There are some deprecated events listed by perf list. But we can't remove
>>>>>> them from perf list with ease because some old scripts may use them.
>>>>>>
>>>>>> Deprecated events are old names of renamed events.  When an event gets
>>>>>> renamed the old name is kept around for some time and marked with
>>>>>> Deprecated. The newer Intel event lists in the tree already have these
>>>>>> headers.
>>>>>>
>>>>>> So we need to keep them in the event list, but provide a new option to
>>>>>> show them. The new option is "--deprecated".
>>>>>>
>>>>>> With this patch, the deprecated events are hidden by default but they can
>>>>>> be displayed when option "--deprecated" is enabled.
>>>>>
>>>>> not sure it's wise to hide them, because people will not read man page
>>>>> to find --deprecated option, they will rather complain right away ;-)
>>>>>
>>>>> how about to display them as another topic, like:
>>>>>
>>>>> pipeline:
>>>>> 	...
>>>>> uncore:
>>>>> 	...
>>>>> deprecated:
>>>>> 	...
>>>>>
>>>>> jirka
>>>>>
>>>>
>>>> Hi Jiri,
>>>>
>>>> I don't know if we add a new topic "deprecated" in perf list output, does
>>>> the old script need to be modified as well?
>>>>
>>>> Say the events are moved to the "deprecated" section, I just guess the
>>>> script needs the modification.
>>>>
>>>> That's just my personal guess. :)
>>>
>>> i did not mean adding new topic all the way down,
>>> just to display the deprecated events like that
>>>
>>> jirka
>>>
>>
>> Sorry, maybe I misunderstood what you suggested. Correct me if my
>> understanding is wrong.
>>
>> Now the perf list output is like:
>>
>> pipeline:
>>    event1
>>    event2
>> uncore:
>>    event3
>>    event4
>>
>> My understanding for your suggestion is, we need to add "deprecated", for
>> example:
>>
>> pipeline:
>>    event1
>>    event2
>> uncore:
>>    event4
>> deprecated:
>>    event3
>>
>> In above example, I assume the event3 is deprecated.
>>
>> So my worry is, the user's old script may not find the event3 if we move it
>> from "uncore" to "deprecated". Maybe I'm worried a lot. :(
> 
> well, your patch removes it unless you specify --deprecated
> option of course
> 
> perhaps we could do
> 
> deprecated:
> uncore:
>    event3
> 
> jirka
> 

OK, thanks! Let me check how to do that. :)

Thanks
Jin Yao
