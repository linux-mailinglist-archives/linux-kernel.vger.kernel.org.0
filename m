Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 326D9AA9A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 19:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390947AbfIERFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 13:05:55 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35120 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387843AbfIERFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:05:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 4EBF340398;
        Thu,  5 Sep 2019 19:05:52 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="PTYFDp0k";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tXyyiTu5CGNe; Thu,  5 Sep 2019 19:05:47 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id AAAB84038E;
        Thu,  5 Sep 2019 19:05:44 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id C7C21360160;
        Thu,  5 Sep 2019 19:05:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567703143; bh=zbo7MfbN20OAj7pa0T+w7Sryr+tQQ3711/fYDNixx7Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PTYFDp0kadm6+tXepdvek8stFaFRRFxkM8IF8Rz9NE15xdppg324LS271aAl+WAUM
         WdAKEZNq7xwWY4iG21mxxIDn7gtVf11CgKnNDFZEsIVmbOZJp4to+6fWvWLjCm0+nf
         kHYKWs97WwTV+TwpRQ/2pjvYWtm2m/t0wGcqNP9o=
Subject: dma_mmap_fault discussion
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
 <20190905103541.4161-2-thomas_os@shipmail.org>
 <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com>
 <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
 <20190905152438.GA18286@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <cbbb0e95-8df1-9ab8-59ad-81bd7f3933fa@shipmail.org>
Date:   Thu, 5 Sep 2019 19:05:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190905152438.GA18286@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph,


On 9/5/19 5:24 PM, Christoph Hellwig wrote:
> On Thu, Sep 05, 2019 at 05:21:24PM +0200, Thomas Hellström (VMware) wrote:
>> On 9/5/19 4:15 PM, Dave Hansen wrote:
>>> Hi Thomas,
>>>
>>> Thanks for the second batch of patches!  These look much improved on all
>>> fronts.
>> Yes, although the TTM functionality isn't in yet. Hopefully we won't have to
>> bother you with those though, since this assumes TTM will be using the dma
>> API.
> Please take a look at dma_mmap_prepare and dma_mmap_fault in this
> branch:
>
> 	http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-mmap-improvements
>
> they should allow to fault dma api pages in the page fault handler.  But
> this is totally hot off the press and not actually tested for the last
> few patches.  Note that I've also included your two patches from this
> series to handle SEV.

I took a quick look at the interfaces and have two questions:

1) dma_mmap_prepare(), would it be possible to drop the references to 
the actual coherent region? The thing is that TTM doesn't know at mmap 
time what memory will be backing the region. It can be VRAM, coherent 
memory or system memory. Also see below:

2) @cpu_addr and @dma_addr are the values pointing at the beginning of 
an allocated chunk, right? The reason I'm asking is that TTM's coherent 
memory pool is sub-allocating from larger chunks into smaller PAGE_SIZE 
chunks, which means that a TTM buffer object may be randomly split 
across larger chunks, which means we have to store these values for each 
PAGE_SiZE chunk.

Thanks,
Thomas


