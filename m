Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D7C21C10
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfEQQ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 12:56:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:31655 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfEQQ4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:56:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 09:56:31 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 17 May 2019 09:56:31 -0700
Received: from [10.252.17.14] (abudanko-mobl.ccr.corp.intel.com [10.252.17.14])
        by linux.intel.com (Postfix) with ESMTP id B22865803E4;
        Fri, 17 May 2019 09:56:28 -0700 (PDT)
Subject: Re: [PATCH v10 09/12] perf record: implement
 -z,--compression_level[=<n>] option
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190515123802.GA23162@kernel.org>
 <175a0cd8-226f-dee4-8919-89f844a6dc8b@linux.intel.com>
 <20190517150122.GF8945@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f182d845-2b1e-66f4-b627-210bb6e09327@linux.intel.com>
Date:   Fri, 17 May 2019 19:56:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517150122.GF8945@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.2019 18:01, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 15, 2019 at 06:44:29PM +0300, Alexey Budankov escreveu:
>> On 15.05.2019 15:59, Arnaldo Carvalho de Melo wrote:
<SNIP>
>>> Em Wed, May 15, 2019 at 11:43:30AM +0300, Alexey Budankov escreveu:
>>>> On 15.05.2019 0:46, Arnaldo Carvalho de Melo wrote:
>>>>> Em Tue, May 14, 2019 at 05:20:41PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>> Em Mon, Mar 18, 2019 at 08:44:42PM +0300, Alexey Budankov escreveu:
>>>
>>>>>>> Implemented -z,--compression_level[=<n>] option that enables compression
>>>>>>> of mmaped kernel data buffers content in runtime during perf record
>>>>>>> mode collection. Default option value is 1 (fastest compression).
>>>
>>>>> <SNIP>
>>>
>>>>>> [root@quaco ~]# perf record -z2
>>>>>> ^C[ perf record: Woken up 1 times to write data ]
>>>>>> 0x1746e0 [0x76]: failed to process type: 81 [Invalid argument]
>>>>>> [ perf record: Captured and wrote 1.568 MB perf.data, compressed (original 0.452 MB, ratio is 3.995) ]
>>>
>>>>>> [root@quaco ~]#
>>>
>>>>> So, its the buildid processing at the end, so we can't do build-id
>>>>> processing when using PERF_RECORD_COMPRESSED, otherwise we'd have to
>>>>> uncompress at the end to find the PERF_RECORD_FORK/PERF_RECORD_MMAP,
>>>>> etc.
>>>
>>>>> [root@quaco ~]# perf record -z2  --no-buildid sleep 1
>>>>> [ perf record: Woken up 1 times to write data ]
>>>>> [ perf record: Captured and wrote 0.020 MB perf.data, compressed (original 0.001 MB, ratio is 2.153) ]
>>>>> [root@quaco ~]# perf report -D | grep PERF_RECORD_COMP
>>>>> 0x4f40 [0x195]: failed to process type: 81 [Invalid argument]
>>>>> Error:
>>>>> failed to process sample
>>>>> 0 0x4f40 [0x195]: PERF_RECORD_COMPRESSED
>>>>> [root@quaco ~]#
>>>
>>>>> I'll play with it tomorrow.
>>>
>>>> Applied the whole patch set on top of the current perf/core 
>>>> and the whole thing functions as expected.
>>>
>>> It doesn't, see the reported error above, these three lines, that
>>> shouldn't be there:
>>>
>>> 0x4f40 [0x195]: failed to process type: 81 [Invalid argument]
>>> Error:
>>> failed to process sample
>>>
>>> That is because at this point in the patch series a record was
>>> introduced that is not being handled by the build id processing done, by
>>> default, at the end of the 'perf record' session, and, as explained
>>> above, needs fixing so that when we do 'git bisect' looking for a non
>>> expected "failed to process type: 81" kind of error, this doesn't
>>> appear.
>>>
>>> I added the changes below to this cset and will continue from there:
>>>
>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>> index d84a4885e341..f8d21991f94c 100644
>>> --- a/tools/perf/builtin-record.c
>>> +++ b/tools/perf/builtin-record.c
>>> @@ -2284,6 +2284,12 @@ int cmd_record(int argc, const char **argv)
>>>  			"cgroup monitoring only available in system-wide mode");
>>>  
>>>  	}
>>> +
>>> +	if (rec->opts.comp_level != 0) {
>>> +		pr_debug("Compression enabled, disabling build id collection at the end of the session\n");
>>> +		rec->no_buildid = true;
>>> +	}
>>> +
>>>  	if (rec->opts.record_switch_events &&
>>>  	    !perf_can_record_switch_events()) {
>>>  		ui__error("kernel does not support recording context switch events\n");
>>>
>>> ---------------------------------------------------------------------------
>>>
>>> [acme@quaco perf]$ perf record -z2 sleep 1
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 0.001 MB perf.data, compressed (original 0.001 MB, ratio is 2.292) ]
>>> [acme@quaco perf]$ perf record -v -z2 sleep 1
>>> Compression enabled, disabling build id collection at the end of the session
>>> Using CPUID GenuineIntel-6-8E-A
>>> nr_cblocks: 0
>>> affinity: SYS
>>> mmap flush: 1
>>> comp level: 2
>>> mmap size 528384B
>>> Couldn't start the BPF side band thread:
>>> BPF programs starting from now on won't be annotatable
>>> perf_event__synthesize_bpf_events: can't get next program: Operation not permitted
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 0.001 MB perf.data, compressed (original 0.001 MB, ratio is 2.305) ]
>>> [acme@quaco perf]$
>>>
>>> Will check if its possible to get rid of the following in this patch, to
>>> keep bisection working for this case as well:
>>>
>>> [acme@quaco perf]$ perf report -D | grep COMPRESS
>>> 0x1b8 [0x169]: failed to process type: 81 [Invalid argument]
>>> Error:
>>> failed to process sample
>>> 0 0x1b8 [0x169]: PERF_RECORD_COMPRESSED
>>> [acme@quaco perf]$
>>
>> Makes sense. Thanks.
> 
> I did it yesterday, all is in my acme/perf/core branch, now testing it
> together with the large pile of patches there accumulated while I was in
> LSF/MM + vacations :-)
> 
> All have already passed through most of my test build containers, with
> most of the distros that have libzstd being updated to include it, and
> the make_minimal test build target was updated to build explicitely
> disabling zstd, i.e. with NO_LIBZSTD=1, so that we test with/without it
> in systems where it is installed and also in systems where zstd is not
> even available.

Good news. Thanks!

~Alexey

> 
> - Arnaldo
> 
