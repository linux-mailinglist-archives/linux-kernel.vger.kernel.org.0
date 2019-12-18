Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251EE123BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 01:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfLRAsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 19:48:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:50534 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfLRAsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:48:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 16:48:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; 
   d="scan'208";a="417036239"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2019 16:48:17 -0800
Date:   Wed, 18 Dec 2019 08:48:15 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>, g@richard
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove dead code totalram_pages_set()
Message-ID: <20191218004815.GA23703@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191217064401.18047-1-richardw.yang@linux.intel.com>
 <64835f9c-3ead-ef6e-3eeb-5de2b9725fa2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64835f9c-3ead-ef6e-3eeb-5de2b9725fa2@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:01:11PM +0100, David Hildenbrand wrote:
>On 17.12.19 07:44, Wei Yang wrote:
>> No one use totalram_pages_set(), just remote it.
>
>s/use/uses/
>s/remote/remove/
>

Thanks, my bad.

>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  include/linux/mm.h | 5 -----
>>  1 file changed, 5 deletions(-)
>> 
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 74232b28949b..4cf023c4c6b3 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -70,11 +70,6 @@ static inline void totalram_pages_add(long count)
>>  	atomic_long_add(count, &_totalram_pages);
>>  }
>>  
>> -static inline void totalram_pages_set(long val)
>> -{
>> -	atomic_long_set(&_totalram_pages, val);
>> -}
>> -
>>  extern void * high_memory;
>>  extern int page_cluster;
>>  
>> 
>
>Reviewed-by: David Hildenbrand <david@redhat.com>
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
