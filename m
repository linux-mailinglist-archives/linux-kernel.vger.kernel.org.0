Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FECB16AA84
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 16:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgBXPxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 10:53:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:30204 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgBXPxd (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:53:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 07:53:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="349942304"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.211.36]) ([10.254.211.36])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2020 07:53:29 -0800
Subject: Re: [PATCH v3 2/2] Support interactive annotation of code without
 symbols
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     alexander.shishkin@linux.intel.com, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200224022225.30264-1-yao.jin@linux.intel.com>
 <20200224022225.30264-3-yao.jin@linux.intel.com>
 <6d8858e7-01a7-70fd-5c22-7b79b308fb95@linux.ibm.com>
 <20200224135141.GH16664@krava>
 <e8f944f5-0cca-44d3-dec2-3985e72bacc8@linux.ibm.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <0c76f0d9-89d5-1913-0736-3b991c742e8c@linux.intel.com>
Date:   Mon, 24 Feb 2020 23:53:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e8f944f5-0cca-44d3-dec2-3985e72bacc8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2020 10:04 PM, Ravi Bangoria wrote:
> 
> 
> On 2/24/20 7:21 PM, Jiri Olsa wrote:
>> On Mon, Feb 24, 2020 at 06:55:12PM +0530, Ravi Bangoria wrote:
>>> Hi Jin,
>>>
>>> On 2/24/20 7:52 AM, Jin Yao wrote:
>>>> For perf report on stripped binaries it is currently impossible to do
>>>> annotation. The annotation state is all tied to symbols, but there are
>>>> either no symbols, or symbols are not covering all the code.
>>>>
>>>> We should support the annotation functionality even without symbols.
>>>>
>>>> This patch fakes a symbol and the symbol name is the string of address.
>>>> After that, we just follow current annotation working flow.
>>>>
>>>> For example,
>>>>
>>>> 1. perf report
>>>>
>>>> Overhead  Command  Shared Object     Symbol
>>>>     20.67%  div      libc-2.27.so      [.] __random_r
>>>>     17.29%  div      libc-2.27.so      [.] __random
>>>>     10.59%  div      div               [.] 0x0000000000000628
>>>>      9.25%  div      div               [.] 0x0000000000000612
>>>>      6.11%  div      div               [.] 0x0000000000000645
>>>>
>>>> 2. Select the line of "10.59%  div      div               [.] 
>>>> 0x0000000000000628" and ENTER.
>>>>
>>>> Annotate 0x0000000000000628
>>>> Zoom into div thread
>>>> Zoom into div DSO (use the 'k' hotkey to zoom directly into the kernel)
>>>> Browse map details
>>>> Run scripts for samples of symbol [0x0000000000000628]
>>>> Run scripts for all samples
>>>> Switch to another data file in PWD
>>>> Exit
>>>>
>>>> 3. Select the "Annotate 0x0000000000000628" and ENTER.
>>>>
>>>> Percent│
>>>>          │
>>>>          │
>>>>          │     Disassembly of section .text:
>>>>          │
>>>>          │     0000000000000628 <.text+0x68>:
>>>>          │       divsd %xmm4,%xmm0
>>>>          │       divsd %xmm3,%xmm1
>>>>          │       movsd (%rsp),%xmm2
>>>>          │       addsd %xmm1,%xmm0
>>>>          │       addsd %xmm2,%xmm0
>>>>          │       movsd %xmm0,(%rsp)
>>>>
>>>> Now we can see the dump of object starting from 0x628.
>>>
>>> If I press 'a' on address, it's not annotating. But if I annotate
>>> by pressing enter, like you explained, it works. Is it intentional?
>>
>> I saw that too, but I thought it's unrelated issue,
>> because we played with that just recently
>>
>> if you go through the 'enter' way and back, then the
>> next time 'a' works ;-)
> 
> Yes.
> 
> I liked the series so I was trying out the patches. Just reporting 
> issues I found...
> 
> jump/call arrows are also screwed up.. Like jump instruction is showing 
> call arrows.
> But these all are minor issues and can be fixed later on. I don't mind ;)
> 
> Ravi
> 

Some jumps will show arrow '->". For example,

→ jne   120

Yes, we can check and fix that later.

Thanks
Jin Yao
