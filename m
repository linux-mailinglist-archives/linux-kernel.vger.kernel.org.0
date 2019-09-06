Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 283B0AB30F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 09:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbfIFHKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 03:10:14 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:24744 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731486AbfIFHKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:10:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 699053F6C6;
        Fri,  6 Sep 2019 09:10:11 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=buQfI/mr;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4ixBRuMY-L4Q; Fri,  6 Sep 2019 09:10:10 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 7DE5D3F6BB;
        Fri,  6 Sep 2019 09:10:08 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id A05333605D3;
        Fri,  6 Sep 2019 09:10:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567753808; bh=FB65Rj3GcD4Ldfov0vz/hqx02T2cTvUugB7Vb70P7F0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=buQfI/mr9tW7P1UIN482/LKW64dDcNBWDTWSVURqbg8ocHxrMV/gpCBY50rO5TMhP
         jsanvRv0/45tI5rxtq7qzdubh1yrrezITdzlulU1aXLDz9Hs6+VEW3E+HtUT4Y6vbi
         P50iInhPLEYFfnQkic2Je2fZhJ0jj4N3mdYWy4eM=
Subject: Re: dma_mmap_fault discussion
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
 <cbbb0e95-8df1-9ab8-59ad-81bd7f3933fa@shipmail.org>
 <20190906063203.GA25415@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <fcb71585-7fae-c6a0-81f0-1aa632ea621b@shipmail.org>
Date:   Fri, 6 Sep 2019 09:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190906063203.GA25415@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/19 8:32 AM, Christoph Hellwig wrote:
> On Thu, Sep 05, 2019 at 07:05:43PM +0200, Thomas Hellström (VMware) wrote:
>> I took a quick look at the interfaces and have two questions:
>>
>> 1) dma_mmap_prepare(), would it be possible to drop the references to the
>> actual coherent region? The thing is that TTM doesn't know at mmap time what
>> memory will be backing the region. It can be VRAM, coherent memory or system
> I guess we can shift the argument checking into the fault handler.
>
>> 2) @cpu_addr and @dma_addr are the values pointing at the beginning of an
>> allocated chunk, right?
> Yes.
>
>> The reason I'm asking is that TTM's coherent memory
>> pool is sub-allocating from larger chunks into smaller PAGE_SIZE chunks,
>> which means that a TTM buffer object may be randomly split across larger
>> chunks, which means we have to store these values for each PAGE_SiZE chunk.
> For implementations that remap non-contigous regions using vmap we need the
> start cpu address passed, as that is used to find the vm_struct structure
> for it.  That being said I don't see a problem with you keeping track
> of the original start and offset into in your suballocation helpers.

It's definitely possible. I was just wondering whether it was necessary, 
but it seems like it.

Thanks,

Thomas


