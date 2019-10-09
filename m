Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 899A0D0D65
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 13:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfJILJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 07:09:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727228AbfJILJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:09:34 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 311C1DA3E4D34CCC7F61;
        Wed,  9 Oct 2019 19:09:32 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.182) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 19:09:23 +0800
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
        "Al Grant" <Al.Grant@arm.com>, nd <nd@arm.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
 <1564738813-10944-3-git-send-email-tanxiaojun@huawei.com>
 <0ac06995-273c-034d-52a3-921ea0337be2@arm.com>
 <016c1ce8-7220-75a2-43fa-0efe150f897c@huawei.com>
 <805660ca-1cf3-4c7f-3aa2-61fed59afa8b@arm.com>
 <637836d6-c884-1a55-7730-eeb45b590d39@huawei.com>
 <b7e5ca2d-8c6c-8ab8-637e-a9aaebaf62a5@arm.com>
From:   Tan Xiaojun <tanxiaojun@huawei.com>
Message-ID: <2b1fc8c7-c0b9-f4b9-a24f-444bc22129af@huawei.com>
Date:   Wed, 9 Oct 2019 19:09:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <b7e5ca2d-8c6c-8ab8-637e-a9aaebaf62a5@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.215.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/9 17:48, James Clark wrote:
> Hi Xiaojun,
> 
>> By the way, you mentioned before that you want the spe event to be in the form of "event:pp" like pebs. Is that the whole framework should be made similar to pebs? Or is it just a modification to the command format? 
> 
> We're currently still investigating if it makes sense to modify the Perf event open syscall to use SPE when the "precise_ip" attribute is set. And then synthesize samples using the SPE data when available. This would keep the syscall interface more consistent between architectures.
> 
> And if tools other than Perf want more precise data, they don't have to be aware of SPE or any of the implementation defined details of it. For example the 'data source' encoding can be different from one micro architecture to the next. The kernel is probably the best place to handle this.
> 
> At the moment, every tool that wants to use the Perf syscall to get precise data on ARM would have to be aware of SPE and implement their own decoding.
> 

Hi James,

What do you mean when the user specifies "event:pp", if the SPE is available, configure and record the spe data directly via the perf event open syscall?
(perf.data itself is the same as using -e arm_spe_0//xxx?)

OK. If I have not misunderstood, I think I know how to do it.
Thank you.

>> For the former, this may be a bit difficult. For the latter, there is currently no modification to the record part, so "-c -F, etc." is only for instructions rather than events, so it may be misunderstood by users.
>>
>> So I haven't figured out how to do. What do you think of this?
> 
> I think the patch at the moment is a good start to make SPE more accessible. And the changes I mentioned above wouldn't change the fact that the raw SPE data would still be available via the SPE PMU. So I think continuing with the patch as-is for now is the best idea.
> 

Yes. I agree.

Xiaojun.

> 
> James
> 
> 


