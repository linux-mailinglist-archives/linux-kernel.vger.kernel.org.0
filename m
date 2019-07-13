Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6933467B82
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfGMR3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 13:29:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:41843 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbfGMR3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 13:29:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 10:29:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,487,1557212400"; 
   d="scan'208";a="318289249"
Received: from bxing-mobl.amr.corp.intel.com (HELO [10.255.230.48]) ([10.255.230.48])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2019 10:29:13 -0700
Subject: Re: [RFC PATCH v4 1/3] selftests/x86/sgx: Fix Makefile for SGX
 selftest
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        kai.svahn@intel.com, kai.huang@intel.com
References: <cover.1563000446.git.cedric.xing@intel.com>
 <757d44a0e67bfa09d97eea918bc0d20383b5e80e.1563000446.git.cedric.xing@intel.com>
 <c6a99c107c1e6b814c1968146c87291c3e84aa2f.camel@linux.intel.com>
 <8bf125023ad2e99a8620112a393ca95f9939f4fd.camel@linux.intel.com>
From:   "Xing, Cedric" <cedric.xing@intel.com>
Message-ID: <84c792d8-a5ef-1030-9072-9670b6ba966c@intel.com>
Date:   Sat, 13 Jul 2019 10:29:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8bf125023ad2e99a8620112a393ca95f9939f4fd.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/2019 8:15 AM, Jarkko Sakkinen wrote:
> On Sat, 2019-07-13 at 18:10 +0300, Jarkko Sakkinen wrote:
>> On Fri, 2019-07-12 at 23:51 -0700, Cedric Xing wrote:
>>> The original x86/sgx/Makefile didn't work when "x86/sgx" was specified as the
>>> test target, nor did it work with "run_tests" as the make target. Yet another
>>> problem was that it breaks 32-bit only build. This patch fixes those problems,
>>> along with adjustments to compiler/linker options and simplifications to the
>>> build rules.
>>>
>>> Signed-off-by: Cedric Xing <cedric.xing@intel.com>
>>
>> You must split this in quite a few separate patches:
>>
>> 1. One for each fix.
>> 2. At least one patch for each change in compiler and linker options with a
>>     commit message clearly expalaining why the change was made.
>> 3. One for each simplification.
>>
>> We don't support 32-bit build:
>>
>> config INTEL_SGX
>> 	bool "Intel SGX core functionality"
>> 	depends on X86_64 && CPU_SUP_INTEL
> 
> This is not to say that changes suck. This just in "unreviewable" state as far
> as the kernel processes go...

Please note that your patchset hasn't been upstreamed yet. Your Makefile 
is problematic to begin with. Technically it's your job to make it work 
before sending out any patches. You didn't explain what's done for each 
line of Makefile in your commit message either.

Not saying documentation is unimportant, but the purposes for those 
changes are obvious and easy to understand for anyone having reasonable 
knowledge on how Makefile works.

I'm totally fine not fixing the Makefile. You can just leave them out.

> /Jarkko
> 
