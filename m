Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D524E64ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 00:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfGJWyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 18:54:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:43944 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfGJWyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:54:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 15:54:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; 
   d="scan'208";a="249610078"
Received: from bxing-desk.ccr.corp.intel.com (HELO [134.134.148.187]) ([134.134.148.187])
  by orsmga001.jf.intel.com with ESMTP; 10 Jul 2019 15:54:20 -0700
Subject: Re: [RFC PATCH v2 0/3] An alternative __vdso_sgx_enter_enclave() to
 allow enclave/host parameter passing using untrusted stack
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        kai.svahn@intel.com, kai.huang@intel.com
References: <cover.1555965327.git.cedric.xing@intel.com>
 <20190424062623.4345-1-cedric.xing@intel.com>
 <20190710111719.nnoedfo4wvbfghq7@linux.intel.com>
 <686e47d2-f45c-6828-39d1-48374925de6c@intel.com>
 <20190710224628.epjxwlpqqxdurmzo@linux.intel.com>
From:   "Xing, Cedric" <cedric.xing@intel.com>
Message-ID: <a2d2ba5c-c7b3-a76b-594f-df2e14234b1d@intel.com>
Date:   Wed, 10 Jul 2019 15:54:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710224628.epjxwlpqqxdurmzo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/2019 3:46 PM, Jarkko Sakkinen wrote:
> On Wed, Jul 10, 2019 at 11:08:37AM -0700, Xing, Cedric wrote:
>>> With these conclusions I think the current vDSO API is sufficient for
>>> Linux.
>>
>> The new vDSO API is to support data exchange on stack. It has nothing to do
>> with debugging. BTW, the community has closed on this.
> 
> And how that is useful?

There is a lengthy discussion on its usefulness so I don't want to 
repeat. In short, it allows using untrusted stack as a convenient method 
to exchange data with the enclave. It is currently being used by Intel's 
SGX SDK for e/o-calls parameters.

>> The CFI directives are for stack unwinding. They don't affect what the code
>> does so you can just treat them as NOPs if you don't understand what they
>> do. However, they are useful to not only debuggers but also exception
>> handling code. libunwind also has a setjmp()/longjmp() implementation based
>> on CFI directives.
> 
> Of course I won't merge code of which usefulness I don't understand.

Sure.

Any other questions I can help with?

> /Jarkko
> 
