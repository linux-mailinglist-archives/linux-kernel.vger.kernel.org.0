Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2F37A28A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 09:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfG3Hv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 03:51:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:44240 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfG3Hv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:51:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 00:51:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,326,1559545200"; 
   d="scan'208";a="171844937"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jul 2019 00:51:23 -0700
Subject: Re: [PATCH 3/3] Fix insn.c misaligned address error
To:     Ian Rogers <irogers@google.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, mbd@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20190724184512.162887-1-nums@google.com>
 <20190724184512.162887-4-nums@google.com> <20190726193806.GB24867@kernel.org>
 <20190727184638.3263eb76c3cbde95f9896210@kernel.org>
 <2bc0fcc6-0477-ba1d-7418-5497efa7d571@intel.com>
 <CAP-5=fU2XBoOa2=00VCuWYqsLUzMSMzUXY63ZJt9rz-NJ+vYwA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <07436d28-73c3-bda4-11cc-4bab7d7b1547@intel.com>
Date:   Tue, 30 Jul 2019 10:50:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fU2XBoOa2=00VCuWYqsLUzMSMzUXY63ZJt9rz-NJ+vYwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 10:32 PM, Ian Rogers wrote:
> On Mon, Jul 29, 2019 at 1:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 27/07/19 12:46 PM, Masami Hiramatsu wrote:
>>> On Fri, 26 Jul 2019 16:38:06 -0300
>>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>
>>>> Em Wed, Jul 24, 2019 at 11:45:12AM -0700, Numfor Mbiziwo-Tiapo escreveu:
>>>>> The ubsan (undefined behavior sanitizer) version of perf throws an
>>>>> error on the 'x86 instruction decoder - new instructions' function
>>>>> of perf test.
>>>>>
>>>>> To reproduce this run:
>>>>> make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"
>>>>>
>>>>> then run: tools/perf/perf test 62 -v
>>>>>
>>>>> The error occurs in the __get_next macro (line 34) where an int is
>>>>> read from a potentially unaligned address. Using memcpy instead of
>>>>> assignment from an unaligned pointer.
>>>>
>>>> Since this came from the kernel, don't we have to fix it there as well?
>>>> Masami, Adrian?
>>>
>>> I guess we don't need it, since x86 can access "unaligned address" and
>>> x86 insn decoder in kernel runs only on x86. I'm not sure about perf's
>>> that part. Maybe if we run it on other arch as cross-arch application,
>>> it may cause unaligned pointer issue.
> 
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
> "A pointer to an object or incomplete type may be converted to a
> pointer to a different object or incomplete type. If the resulting
> pointer is not correctly aligned for the pointed-to type, the behavior
> is undefined."
> I agree the code will generally run on x86.
> 
>> Yes, theoretically Intel PT decoding can be done on any arch.
>>
>> But the memcpy is probably sub-optimal for x86, so the patch as it stands
>> does not seem suitable.  I notice the kernel has get_unaligned() and
>> put_unaligned().
> 
> Why is a fixed sized memcpy suboptimal? The compiler can should turn
> into a load.

True, I didn't click it was fixed size.
