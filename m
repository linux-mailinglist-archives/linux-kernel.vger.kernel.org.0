Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDF819781F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 11:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgC3J4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 05:56:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:60342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbgC3J4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:56:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16A64AE0F;
        Mon, 30 Mar 2020 09:56:48 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] mm: mmap: add trace point of vm_unmapped_area
To:     Matthew Wilcox <willy@infradead.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     walken@google.com, bp@suse.de, akpm@linux-foundation.org,
        srostedt@vmware.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200320055823.27089-1-jaewon31.kim@samsung.com>
 <CGME20200320055839epcas1p189100549687530619d8a19919e8b5de0@epcas1p1.samsung.com>
 <20200320055823.27089-3-jaewon31.kim@samsung.com>
 <20200329161410.GW22483@bombadil.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1ccdcd2e-2a56-af61-5b37-26ad64da0e7d@suse.cz>
Date:   Mon, 30 Mar 2020 11:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200329161410.GW22483@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/20 6:14 PM, Matthew Wilcox wrote:
> On Fri, Mar 20, 2020 at 02:58:23PM +0900, Jaewon Kim wrote:
>> +	TP_printk("addr=%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",
>> +		IS_ERR_VALUE(__entry->addr) ? 0 : __entry->addr,
>> +		IS_ERR_VALUE(__entry->addr) ? __entry->addr : 0,
> 
> I didn't see the IS_ERR_VALUE problem that Vlastimil mentioned get resolved?

Steven is fixing it in trace-cmd:
https://lore.kernel.org/r/20200324200956.821799393@goodmis.org

> I might suggest ...
> 
> +++ b/include/linux/err.h
> @@ -19,7 +19,8 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
> +#define __IS_ERR_VALUE(x) ((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
> +#define IS_ERR_VALUE(x) unlikely(__IS_ERR_VALUE(x))

So this shouldn't be needed, as we are adding a new tracepoint, not "breaking"
an existing one?

>  static inline void * __must_check ERR_PTR(long error)
>  {
> 
> and then you can use __IS_ERR_VALUE() which removes the unlikely() problem.
> 

