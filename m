Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D2E83E5C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 02:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfHGAbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 20:31:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:58950 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfHGAbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:31:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 17:31:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="176033856"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 06 Aug 2019 17:31:31 -0700
Date:   Wed, 7 Aug 2019 08:31:09 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap.c: refine data locality of find_vma_prev
Message-ID: <20190807003109.GB24750@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190806081123.22334-1-richardw.yang@linux.intel.com>
 <3e57ba64-732b-d5be-1ad6-eecc731ef405@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e57ba64-732b-d5be-1ad6-eecc731ef405@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 11:29:52AM +0200, Vlastimil Babka wrote:
>On 8/6/19 10:11 AM, Wei Yang wrote:
>> When addr is out of the range of the whole rb_tree, pprev will points to
>> the biggest node. find_vma_prev gets is by going through the right most
>
>s/biggest/last/ ? or right-most?
>
>> node of the tree.
>> 
>> Since only the last node is the one it is looking for, it is not
>> necessary to assign pprev to those middle stage nodes. By assigning
>> pprev to the last node directly, it tries to improve the function
>> locality a little.
>
>In the end, it will always write to the cacheline of pprev. The caller has most
>likely have it on stack, so it's already hot, and there's no other CPU stealing
>it. So I don't understand where the improved locality comes from. The compiler
>can also optimize the patched code so the assembly is identical to the previous
>code, or vice versa. Did you check for differences?

Vlastimil

Thanks for your comment.

I believe you get a point. I may not use the word locality. This patch tries
to reduce some unnecessary assignment of pprev.

Original code would assign the value on each node during iteration, this is
what I want to reduce.

The generated code looks different from my side. Would you mind sharing me how
you compare the generated code?

>
>The previous code is somewhat more obvious to me, so unless I'm missing
>something, readability and less churn suggests to not change.
>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  mm/mmap.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>> 
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 7e8c3e8ae75f..284bc7e51f9c 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2271,11 +2271,10 @@ find_vma_prev(struct mm_struct *mm, unsigned long addr,
>>  		*pprev = vma->vm_prev;
>>  	} else {
>>  		struct rb_node *rb_node = mm->mm_rb.rb_node;
>> -		*pprev = NULL;
>> -		while (rb_node) {
>> -			*pprev = rb_entry(rb_node, struct vm_area_struct, vm_rb);
>> +		while (rb_node && rb_node->rb_right)
>>  			rb_node = rb_node->rb_right;
>> -		}
>> +		*pprev = rb_node ? NULL
>> +			 : rb_entry(rb_node, struct vm_area_struct, vm_rb);
>>  	}
>>  	return vma;
>>  }
>> 

-- 
Wei Yang
Help you, Help me
