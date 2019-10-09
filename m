Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7ABCD05C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 05:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfJIDHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 23:07:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53878 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbfJIDHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:07:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3F036C0ABBE7FE6CE930;
        Wed,  9 Oct 2019 11:07:00 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.182) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 11:06:43 +0800
From:   Tan Xiaojun <tanxiaojun@huawei.com>
Subject: Re: [RFC PATCH 2/3] perf tools: Add support for "report" for some spe
 events
To:     James Clark <James.Clark@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Kim Phillips <Kim.Phillips@amd.com>
CC:     "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Al Grant" <Al.Grant@arm.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
 <1564738813-10944-3-git-send-email-tanxiaojun@huawei.com>
 <0ac06995-273c-034d-52a3-921ea0337be2@arm.com>
 <016c1ce8-7220-75a2-43fa-0efe150f897c@huawei.com>
 <805660ca-1cf3-4c7f-3aa2-61fed59afa8b@arm.com>
Message-ID: <2a9ace55-c7c2-09b2-1d46-368cef1d8b5d@huawei.com>
Date:   Wed, 9 Oct 2019 11:06:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <805660ca-1cf3-4c7f-3aa2-61fed59afa8b@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.215.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/4 21:46, James Clark wrote:
> Hi Xiaojun,
> 
> I wanted to ask if you are still working on this?
> 
> I've noticed that it doesn't apply cleanly to perf/core anymore and I was working on re-basing it.
> Would you be interested in me posting my progress?
> 
> I was also interested in decoding the "data source" of events and displaying that information. Does this
> clash with any of your current work?
> 
> 
> Thanks
> James
> 

(Sorry, you may have received a lot of this email because I am suddenly not on the mail-list, I need to confirm it.)

Hi, James,

Sorry, I did not respond in time because of the National Day holiday in China.

I am still doing this, but I have been scheduled for other tasks some time ago, so that there is no obvious progress on spe.

By the way, you mentioned before that you want the spe event to be in the form of "event:pp" like pebs. Is that the whole framework should be made similar to pebs? Or is it just a modification to the command format? For the former, this may be a bit difficult. For the latter, there is currently no modification to the record part, so "-c -F, etc." is only for instructions rather than events, so it may be misunderstood by users.

So I haven't figured out how to do. What do you think of this?

Thanks.
Xiaojun.

> On 09/08/2019 07:12, Tan Xiaojun wrote:
>> On 2019/8/9 5:00, Jeremy Linton wrote:
>>> Hi,
>>>
>>> First thanks for posting this!
>>>
>>> I ran this on our DAWN platform and it does what it says. Its a pretty reasonable start, but I get -1's in the command row rather than "dd" (or similar) and this also results in [unknown] for the shared object and most userspace addresses. This is quite possibly something I'm not doing right, but I didn't spend a lot of time testing/debugging it.
>>>
>>> I did a quick glance at the code to, and had a couple comments, although I'm not a perf tool expert.
>>>
>>
>> Hi,
>>
>> Thank you for your reply.
>>
>> I have only recently started working on this aspect of the perf tool, so your reply is very important to me.
>>
>> I need to be sorry, my example here is not complete, until you said that I found that I only posted a part of the example. The complete example is as follows:
>>
>> Example usage:
>>
>> # perf record -e arm_spe/ts_enable=1,pa_enable=1/ dd if=/dev/zero of=/dev/null count=10000
>> # perf report
>>
>> --------------------------------------------------------------------
>> ...
>> # Samples: 37  of event 'llc-miss'
>> # Event count (approx.): 37
>> #
>> # Children      Self  Command  Shared Object      Symbol
>> # ........  ........  .......  .................  ....................................
>> #
>>     37.84%    37.84%  dd       [kernel.kallsyms]  [k] perf_iterate_ctx.constprop.64
>>     16.22%    16.22%  dd       [kernel.kallsyms]  [k] copy_page
>>      5.41%     5.41%  dd       [kernel.kallsyms]  [k] find_vma
>>      5.41%     5.41%  dd       [kernel.kallsyms]  [k] perf_event_mmap
>>      5.41%     5.41%  dd       [kernel.kallsyms]  [k] zap_pte_range
>>      5.41%     5.41%  dd       ld-2.28.so         [.] _dl_lookup_symbol_x
>>      5.41%     5.41%  dd       libc-2.28.so       [.] _nl_intern_locale_data
>>      2.70%     2.70%  dd       [kernel.kallsyms]  [k] __remove_shared_vm_struct.isra.1
>>      2.70%     2.70%  dd       [kernel.kallsyms]  [k] kmem_cache_free
>>      2.70%     2.70%  dd       [kernel.kallsyms]  [k] ttwu_do_wakeup.isra.19
>>      2.70%     2.70%  dd       dd                 [.] 0x000000000000d9d8
>>      2.70%     2.70%  dd       ld-2.28.so         [.] _dl_relocate_object
>>      2.70%     2.70%  dd       libc-2.28.so       [.] __unregister_atfork
>>      2.70%     2.70%  dd       libc-2.28.so       [.] _dl_addr
>>
>>
>> # Samples: 8  of event 'tlb-miss'
>> # Event count (approx.): 8
>> #
>> # Children      Self  Command  Shared Object      Symbol
>> # ........  ........  .......  .................  .................................
>> #
>>     12.50%    12.50%  dd       [kernel.kallsyms]  [k] __audit_syscall_entry
>>     12.50%    12.50%  dd       [kernel.kallsyms]  [k] kmem_cache_free
>>     12.50%    12.50%  dd       [kernel.kallsyms]  [k] perf_iterate_ctx.constprop.64
>>     12.50%    12.50%  dd       [kernel.kallsyms]  [k] ttwu_do_wakeup.isra.19
>>     12.50%    12.50%  dd       dd                 [.] 0x000000000000d9d8
>>     12.50%    12.50%  dd       libc-2.28.so       [.] __unregister_atfork
>>     12.50%    12.50%  dd       libc-2.28.so       [.] _nl_intern_locale_data
>>     12.50%    12.50%  dd       libc-2.28.so       [.] vfprintf
>>
>>
>> # Samples: 12  of event 'branch-miss'
>> # Event count (approx.): 12
>> #
>> # Children      Self  Command  Shared Object      Symbol
>> # ........  ........  .......  .................  ..........................
>> #
>>     16.67%    16.67%  dd       libc-2.28.so       [.] read_alias_file
>>      8.33%     8.33%  dd       [kernel.kallsyms]  [k] __arch_copy_from_user
>>      8.33%     8.33%  dd       [kernel.kallsyms]  [k] __arch_copy_to_user
>>      8.33%     8.33%  dd       [kernel.kallsyms]  [k] lookup_fast
>>      8.33%     8.33%  dd       [kernel.kallsyms]  [k] strncpy_from_user
>>      8.33%     8.33%  dd       ld-2.28.so         [.] _dl_lookup_symbol_x
>>      8.33%     8.33%  dd       ld-2.28.so         [.] check_match
>>      8.33%     8.33%  dd       libc-2.28.so       [.] __GI___printf_fp_l
>>      8.33%     8.33%  dd       libc-2.28.so       [.] _dl_addr
>>      8.33%     8.33%  dd       libc-2.28.so       [.] _int_malloc
>>      8.33%     8.33%  dd       libc-2.28.so       [.] _nl_intern_locale_data
>>
>>
>>
>>>
>>> On 8/2/19 4:40 AM, Tan Xiaojun wrote:
>>>> After the commit ffd3d18c20b8 ("perf tools: Add ARM Statistical
>>>> Profiling Extensions (SPE) support") is merged, "perf record" and
>>>> "perf report --dump-raw-trace" have been supported. However, the
>>>> raw data that is dumped cannot be used without parsing.
>>>>
>>>> This patch is to improve the "perf report" support for spe, and
>>>> further process the data. Currently, support for the three events
>>>> of llc-miss, tlb-miss, and branch-miss is added.
>>>>
>>>> Example usage:
>>>>
>>>> --------------------------------------------------------------------
>>>> ...
>>>>      37.84%    37.84%  dd       [kernel.kallsyms]  [k] perf_iterate_ctx.constprop.64
>>>>      16.22%    16.22%  dd       [kernel.kallsyms]  [k] copy_page
>>>>       5.41%     5.41%  dd       [kernel.kallsyms]  [k] find_vma
>>>>       5.41%     5.41%  dd       [kernel.kallsyms]  [k] perf_event_mmap
>>>>       5.41%     5.41%  dd       [kernel.kallsyms]  [k] zap_pte_range
>>>>       5.41%     5.41%  dd       ld-2.28.so         [.] _dl_lookup_symbol_x
>>>>       5.41%     5.41%  dd       libc-2.28.so       [.] _nl_intern_locale_data
>>>>       2.70%     2.70%  dd       [kernel.kallsyms]  [k] __remove_shared_vm_struct.isra.1
>>>>       2.70%     2.70%  dd       [kernel.kallsyms]  [k] kmem_cache_free
>>>>       2.70%     2.70%  dd       [kernel.kallsyms]  [k] ttwu_do_wakeup.isra.19
>>>>       2.70%     2.70%  dd       dd                 [.] 0x000000000000d9d8
>>>>       2.70%     2.70%  dd       ld-2.28.so         [.] _dl_relocate_object
>>>>       2.70%     2.70%  dd       libc-2.28.so       [.] __unregister_atfork
>>>>       2.70%     2.70%  dd       libc-2.28.so       [.] _dl_addr
>>>>
>>>>      12.50%    12.50%  dd       [kernel.kallsyms]  [k] __audit_syscall_entry
>>>>      12.50%    12.50%  dd       [kernel.kallsyms]  [k] kmem_cache_free
>>>>      12.50%    12.50%  dd       [kernel.kallsyms]  [k] perf_iterate_ctx.constprop.64
>>>>      12.50%    12.50%  dd       [kernel.kallsyms]  [k] ttwu_do_wakeup.isra.19
>>>>      12.50%    12.50%  dd       dd                 [.] 0x000000000000d9d8
>>>>      12.50%    12.50%  dd       libc-2.28.so       [.] __unregister_atfork
>>>>      12.50%    12.50%  dd       libc-2.28.so       [.] _nl_intern_locale_data
>>>>      12.50%    12.50%  dd       libc-2.28.so       [.] vfprintf
>>>>
>>>>      16.67%    16.67%  dd       libc-2.28.so       [.] read_alias_file
>>>>       8.33%     8.33%  dd       [kernel.kallsyms]  [k] __arch_copy_from_user
>>>>       8.33%     8.33%  dd       [kernel.kallsyms]  [k] __arch_copy_to_user
>>>>       8.33%     8.33%  dd       [kernel.kallsyms]  [k] lookup_fast
>>>>       8.33%     8.33%  dd       [kernel.kallsyms]  [k] strncpy_from_user
>>>>       8.33%     8.33%  dd       ld-2.28.so         [.] _dl_lookup_symbol_x
>>>>       8.33%     8.33%  dd       ld-2.28.so         [.] check_match
>>>>       8.33%     8.33%  dd       libc-2.28.so       [.] __GI___printf_fp_l
>>>>       8.33%     8.33%  dd       libc-2.28.so       [.] _dl_addr
>>>>       8.33%     8.33%  dd       libc-2.28.so       [.] _int_malloc
>>>>       8.33%     8.33%  dd       libc-2.28.so       [.] _nl_intern_locale_data
>>>>
>>>> --------------------------------------------------------------------
>>>>
>>>> After that, more analysis and processing of the raw data of spe
>>>> will be done.
>>>>
>>>> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
>>>> ---
>>>>   tools/perf/builtin-report.c                        |   5 +
>>>>   tools/perf/util/arm-spe-decoder/Build              |   2 +-
>>>>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  | 214 ++++++
>>>>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |  51 ++
>>>>   .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   2 +
>>>>   tools/perf/util/arm-spe.c                          | 715 ++++++++++++++++++++-
>>>>   tools/perf/util/auxtrace.c                         |  45 ++
>>>>   tools/perf/util/auxtrace.h                         |  27 +
>>>>   tools/perf/util/session.h                          |   2 +
>>>>   9 files changed, 1028 insertions(+), 35 deletions(-)
>>>>   create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>>>>   create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>>>>
>>>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>>>> index abf0b9b..fadc8eb 100644
>>>> --- a/tools/perf/builtin-report.c
>>>> +++ b/tools/perf/builtin-report.c
>>>> @@ -1007,6 +1007,7 @@ int cmd_report(int argc, const char **argv)
>>>>   {
>>>>       struct perf_session *session;
>>>>       struct itrace_synth_opts itrace_synth_opts = { .set = 0, };
>>>> +    struct arm_spe_synth_opts arm_spe_synth_opts;
>>>>       struct stat st;
>>>>       bool has_br_stack = false;
>>>>       int branch_mode = -1;
>>>> @@ -1165,6 +1166,9 @@ int cmd_report(int argc, const char **argv)
>>>>       OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
>>>>                   "Instruction Tracing options\n" ITRACE_HELP,
>>>>                   itrace_parse_synth_opts),
>>>> +    OPT_CALLBACK_OPTARG(0, "spe", &arm_spe_synth_opts, NULL, "spe opts",
>>>> +                "ARM SPE Tracing options",
>>>> +                arm_spe_parse_synth_opts),
>>>>       OPT_BOOLEAN(0, "full-source-path", &srcline_full_filename,
>>>>               "Show full source file name path for source lines"),
>>>>       OPT_BOOLEAN(0, "show-ref-call-graph", &symbol_conf.show_ref_callgraph,
>>>> @@ -1266,6 +1270,7 @@ int cmd_report(int argc, const char **argv)
>>>>       }
>>>>         session->itrace_synth_opts = &itrace_synth_opts;
>>>> +    session->arm_spe_synth_opts = &arm_spe_synth_opts;
>>>>         report.session = session;
>>>>   diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
>>>> index 16efbc2..f8dae13 100644
>>>> --- a/tools/perf/util/arm-spe-decoder/Build
>>>> +++ b/tools/perf/util/arm-spe-decoder/Build
>>>> @@ -1 +1 @@
>>>> -perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
>>>> +perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o arm-spe-decoder.o
>>>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>>>> new file mode 100644
>>>> index 0000000..8008375
>>>> --- /dev/null
>>>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>>>> @@ -0,0 +1,214 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * arm_spe_decoder.c: ARM SPE support
>>>> + */
>>>> +
>>>> +#ifndef _GNU_SOURCE
>>>> +#define _GNU_SOURCE
>>>> +#endif
>>>> +#include <stdlib.h>
>>>> +#include <stdbool.h>
>>>> +#include <string.h>
>>>> +#include <errno.h>
>>>> +#include <stdint.h>
>>>> +#include <inttypes.h>
>>>> +#include <linux/compiler.h>
>>>> +#include <linux/zalloc.h>
>>>> +
>>>> +#include "../util.h"
>>>> +#include "../auxtrace.h"
>>>> +
>>>> +#include "arm-spe-pkt-decoder.h"
>>>> +#include "arm-spe-decoder.h"
>>>> +
>>>> +struct arm_spe_decoder {
>>>> +    int (*get_trace)(struct arm_spe_buffer *buffer, void *data);
>>>> +    void *data;
>>>> +    struct arm_spe_state state;
>>>> +    const unsigned char *buf;
>>>> +    size_t len;
>>>> +    uint64_t pos;
>>>> +    struct arm_spe_pkt packet;
>>>> +    int pkt_step;
>>>> +    int pkt_len;
>>>> +    int last_packet_type;
>>>> +
>>>> +    uint64_t last_ip;
>>>> +    uint64_t ip;
>>>> +    uint64_t timestamp;
>>>> +    uint64_t sample_timestamp;
>>>> +    const unsigned char *next_buf;
>>>> +    size_t next_len;
>>>> +    unsigned char temp_buf[ARM_SPE_PKT_MAX_SZ];
>>>> +};
>>>> +
>>>> +static uint64_t arm_spe_calc_ip(uint64_t payload)
>>>> +{
>>>> +    uint64_t ip = (payload & ~(0xffULL << 56));
>>>> +
>>>> +    /* fill high 8 bits for kernel virtual address */
>>>> +    if (ip & 0x1000000000000ULL)
>>>
>>> It might be better to use VA_START here if possible.
>>>
>>
>> Yes, it's better, but I don't know how to use VA_START in user mode code. So I wrote it directly.
>>
>>>> +        ip |= (uint64_t)0xff00000000000000ULL;
>>>> +
>>>> +    return ip;
>>>> +}
>>>> +
>>>> +struct arm_spe_decoder *arm_spe_decoder_new(struct arm_spe_params *params)
>>>> +{
>>>> +    struct arm_spe_decoder *decoder;
>>>> +
>>>> +    if (!params->get_trace)
>>>> +        return NULL;
>>>> +
>>>> +    decoder = zalloc(sizeof(struct arm_spe_decoder));
>>>> +    if (!decoder)
>>>> +        return NULL;
>>>> +
>>>> +    decoder->get_trace          = params->get_trace;
>>>> +    decoder->data               = params->data;
>>>> +
>>>> +    return decoder;
>>>> +}
>>>> +
>>>> +void arm_spe_decoder_free(struct arm_spe_decoder *decoder)
>>>> +{
>>>> +    free(decoder);
>>>> +}
>>>> +
>>>> +static int arm_spe_bad_packet(struct arm_spe_decoder *decoder)
>>>> +{
>>>> +    decoder->pkt_len = 1;
>>>> +    decoder->pkt_step = 1;
>>>> +    pr_debug("ERROR: Bad packet\n");
>>>> +
>>>> +    return -EBADMSG;
>>>> +}
>>>> +
>>>> +
>>>> +static int arm_spe_get_data(struct arm_spe_decoder *decoder)
>>>> +{
>>>> +    struct arm_spe_buffer buffer = { .buf = 0, };
>>>> +    int ret;
>>>> +
>>>> +    decoder->pkt_step = 0;
>>>> +
>>>> +    pr_debug("Getting more data\n");
>>>> +    ret = decoder->get_trace(&buffer, decoder->data);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    decoder->buf = buffer.buf;
>>>> +    decoder->len = buffer.len;
>>>> +    if (!decoder->len) {
>>>> +        pr_debug("No more data\n");
>>>> +        return -ENODATA;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int arm_spe_get_next_data(struct arm_spe_decoder *decoder)
>>>> +{
>>>> +    return arm_spe_get_data(decoder);
>>>> +}
>>>> +
>>>> +static int arm_spe_get_next_packet(struct arm_spe_decoder *decoder)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    decoder->last_packet_type = decoder->packet.type;
>>>> +
>>>> +    do {
>>>> +        decoder->pos += decoder->pkt_step;
>>>> +        decoder->buf += decoder->pkt_step;
>>>> +        decoder->len -= decoder->pkt_step;
>>>> +
>>>> +
>>>> +        if (!decoder->len) {
>>>> +            ret = arm_spe_get_next_data(decoder);
>>>> +            if (ret)
>>>> +                return ret;
>>>> +        }
>>>> +
>>>> +        ret = arm_spe_get_packet(decoder->buf, decoder->len,
>>>> +                &decoder->packet);
>>>> +        if (ret <= 0)
>>>> +            return arm_spe_bad_packet(decoder);
>>>> +
>>>> +        decoder->pkt_len = ret;
>>>> +        decoder->pkt_step = ret;
>>>> +    } while (decoder->packet.type == ARM_SPE_PAD);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int arm_spe_walk_trace(struct arm_spe_decoder *decoder)
>>>> +{
>>>> +    int err;
>>>> +    int idx;
>>>> +    uint64_t payload;
>>>> +
>>>> +    while (1) {
>>>> +        err = arm_spe_get_next_packet(decoder);
>>>> +        if (err)
>>>> +            return err;
>>>> +
>>>> +        idx = decoder->packet.index;
>>>> +        payload = decoder->packet.payload;
>>>> +
>>>> +        switch (decoder->packet.type) {
>>>> +        case ARM_SPE_TIMESTAMP:
>>>> +            decoder->sample_timestamp = payload;
>>>> +            return 0;
>>>> +        case ARM_SPE_END:
>>>> +            decoder->sample_timestamp = 0;
>>>> +            return 0;
>>>> +        case ARM_SPE_ADDRESS:
>>>> +            decoder->ip = arm_spe_calc_ip(payload);
>>>> +            if (idx == 0)
>>>> +                decoder->state.from_ip = decoder->ip;
>>>> +            else if (idx == 1)
>>>> +                decoder->state.to_ip = decoder->ip;
>>>> +            break;
>>>> +        case ARM_SPE_COUNTER:
>>>> +            break;
>>>> +        case ARM_SPE_CONTEXT:
>>>> +            break;
>>>> +        case ARM_SPE_OP_TYPE:
>>>> +            break;
>>>> +        case ARM_SPE_EVENTS:
>>>> +            if (payload & 0x20)
>>>> +                decoder->state.type |= ARM_SPE_TLB_MISS;
>>>> +            if (payload & 0x80)
>>>> +                decoder->state.type |= ARM_SPE_BRANCH_MISS;
>>>> +            if (idx > 1 && (payload & 0x200))
>>>> +                decoder->state.type |= ARM_SPE_LLC_MISS;
>>>> +
>>>> +            break;
>>>> +        case ARM_SPE_DATA_SOURCE:
>>>> +            break;
>>>> +        case ARM_SPE_BAD:
>>>> +            break;
>>>> +        case ARM_SPE_PAD:
>>>> +            break;
>>>> +        default:
>>>> +            pr_err("Get Packet Error!\n");
>>>> +            return -ENOSYS;
>>>> +        }
>>>> +    }
>>>> +}
>>>
>>> This code looks very similar to  arm_spe_pkt_desc(), I can't help but think they should be consolidated in some way. If nothing else the magic 0x20, 0x80, etc ARM_SPE_EVENTS should be defined somewhere and shared.
>>>
>>
>> Yes, I wrote it with reference to it. What you said makes sense. I will try to modify it later.
>>
>> Xiaojun.
>>
>>>
>>>> +
>>>> +const struct arm_spe_state *arm_spe_decode(struct arm_spe_decoder *decoder)
>>>> +{
>>>> +    int err;
>>>> +
>>>> +    decoder->state.type = 0;
>>>> +
>>>> +    err = arm_spe_walk_trace(decoder);
>>>> +    if (err)
>>>> +        decoder->state.err = err;
>>>> +
>>>> +    decoder->state.timestamp = decoder->sample_timestamp;
>>>> +
>>>> +    return &decoder->state;
>>>
>>> (trimming remainder)
>>>
>>>
>>> .
>>>
>>
>>
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
> 


