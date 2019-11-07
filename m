Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935FBF248A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 02:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbfKGBvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 20:51:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:60118 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbfKGBvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:51:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 17:51:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; 
   d="scan'208";a="403938336"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2019 17:51:35 -0800
Subject: Re: [kbuild-all] Re: [PATCH v3] x86: Add trace points to (nearly) all
 vectors
To:     Andi Kleen <ak@linux.intel.com>, kbuild test robot <lkp@intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, kbuild-all@lists.01.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20191030195619.22244-1-andi@firstfloor.org>
 <201911020848.LOEtnDnd%lkp@intel.com>
 <20191105014606.GC25308@tassilo.jf.intel.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <1b7cd867-c465-40ec-6250-f92ebea2bb4f@intel.com>
Date:   Thu, 7 Nov 2019 09:51:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191105014606.GC25308@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/19 9:46 AM, Andi Kleen wrote:
> On Sat, Nov 02, 2019 at 08:47:59AM +0800, kbuild test robot wrote:
>> Hi Andi,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on tip/auto-latest]
>> [also build test ERROR on v5.4-rc5 next-20191031]
>> [if your patch is applied to the wrong git tree, please drop us a note to help
>> improve the system. BTW, we also suggest to use '--base' option to specify the
>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>
>> url:    https://github.com/0day-ci/linux/commits/Andi-Kleen/x86-Add-trace-points-to-nearly-all-vectors/20191102-063457
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a5b576bfb3ba85d3e356f9900dce1428d4760582
>> config: i386-tinyconfig (attached as .config)
>> compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
>> reproduce:
>>          # save the attached .config to linux build tree
>>          make ARCH=i386
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     arch/x86/kernel/traps.c: In function 'do_error_trap':
>>>> arch/x86/kernel/traps.c:264:2: error: implicit declaration of function 'trace_other_vector_entry'; did you mean 'frame_vector_destroy'? [-Werror=implicit-function-declaration]
>>       trace_other_vector_entry(trapnr);
>>       ^~~~~~~~~~~~~~~~~~~~~~~~
>
> Also cannot reproduce and the config file seems to be not matching the kernel.
>
> The file has the correct include:
>
> vi +60 arch/x86/kernel/traps.c
>
> ...
>   60 #include <asm/trace/irq_vectors.h>
>

Hi Andi,

I think it's a kconfig issue, CONFIG_X86_LOCAL_APIC  is necessary 
according to your patch,
but i386-tinyconfig doesn't contain it.

arch/x86/include/asm/trace/irq_vectors.h:

  11 #ifdef CONFIG_X86_LOCAL_APIC

Best Regards,
Rong Chen
