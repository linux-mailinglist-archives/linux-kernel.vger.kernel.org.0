Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8ADBBBF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 02:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503633AbfIXAaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 20:30:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:63376 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503566AbfIXAaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 20:30:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 17:30:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,542,1559545200"; 
   d="scan'208";a="195529558"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Sep 2019 17:30:02 -0700
Date:   Tue, 24 Sep 2019 08:29:43 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        dave.hansen@linux.intel.com, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm: replace a goto by merging two if clause
Message-ID: <20190924002942.GA1813@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190919020844.27461-1-richardw.yang@linux.intel.com>
 <20190919020844.27461-2-richardw.yang@linux.intel.com>
 <20190923092231.GJ2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923092231.GJ2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:22:31AM +0200, Peter Zijlstra wrote:
>On Thu, Sep 19, 2019 at 10:08:44AM +0800, Wei Yang wrote:
>> There is only one place to use good_area jump, which could be reduced by
>> merging the following two if clause.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  arch/x86/mm/fault.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 9d18b73b5f77..72ce6c69e195 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -1390,18 +1390,17 @@ void do_user_addr_fault(struct pt_regs *regs,
>>  	vma = find_vma(mm, address);
>>  	if (unlikely(!vma))
>>  		goto bad_area;
>> -	if (likely(vma->vm_start <= address))
>> -		goto good_area;
>> -	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
>> -		goto bad_area;
>> -	if (unlikely(expand_stack(vma, address)))
>> +	if (likely(vma->vm_start <= address)) {
>> +		/* good area, do nothing */
>> +	} else if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)) ||
>> +		   unlikely(expand_stack(vma, address))) {
>>  		goto bad_area;
>> +	}
>>  
>>  	/*
>>  	 * Ok, we have a good vm_area for this memory access, so
>>  	 * we can handle it..
>>  	 */
>> -good_area:
>>  	if (unlikely(access_error(hw_error_code, vma))) {
>>  		bad_area_access_error(regs, hw_error_code, address, vma);
>>  		return;
>
>I find the old code far easier to read... is there any actual reason to
>do this?

No, just want to make it easy to read.

-- 
Wei Yang
Help you, Help me
