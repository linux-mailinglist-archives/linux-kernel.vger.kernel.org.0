Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4289842569
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 14:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438799AbfFLMUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 08:20:24 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:46845 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438786AbfFLMUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:20:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id B32C43F792;
        Wed, 12 Jun 2019 14:20:15 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=vmwopensource.org header.i=@vmwopensource.org header.b=g9JQd7iX;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -3.099
X-Spam-Level: 
X-Spam-Status: No, score=-3.099 tagged_above=-999 required=6.31
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, DKIM_SIGNED=0.1,
        DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
        URIBL_RED=0.001] autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=vmwopensource.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YFDHihGaaJKs; Wed, 12 Jun 2019 14:20:05 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id D94A63F771;
        Wed, 12 Jun 2019 14:20:03 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 6C3313619A3;
        Wed, 12 Jun 2019 14:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=vmwopensource.org;
        s=mail; t=1560342003;
        bh=6NfMWfvQeoRy9SPu4DRek4214/12osldJKiSUF/Om8o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=g9JQd7iXbBFiJ9k/DFvRCemp/a055P3v1B/2XGHSPrmLckFXXamHhLxVJb7ZMt9f5
         jYLGqeoMp1N46VhXUk47+FPdynyWNASQeTHzpZ9jHQ6CUrTYeWqqkzDzRovkQI4o8Z
         Sf04V6HvJKonDRhebjhwGvZ/BTi//2F1blpTwSKE=
Subject: Re: [PATCH v5 3/9] mm: Add write-protect and clean utilities for
 address space ranges
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org, nadav.amit@gmail.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>
References: <20190612064243.55340-1-thellstrom@vmwopensource.org>
 <20190612064243.55340-4-thellstrom@vmwopensource.org>
 <20190612112349.GA20226@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thellstrom@vmwopensource.org>
Organization: VMware Inc.
Message-ID: <a004e1a5-bdc5-6508-039e-8d97a9d3cb68@vmwopensource.org>
Date:   Wed, 12 Jun 2019 14:20:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612112349.GA20226@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 1:23 PM, Christoph Hellwig wrote:
> On Wed, Jun 12, 2019 at 08:42:37AM +0200, Thomas Hellström (VMware) wrote:
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> Add two utilities to a) write-protect and b) clean all ptes pointing into
>> a range of an address space.
>> The utilities are intended to aid in tracking dirty pages (either
>> driver-allocated system memory or pci device memory).
>> The write-protect utility should be used in conjunction with
>> page_mkwrite() and pfn_mkwrite() to trigger write page-faults on page
>> accesses. Typically one would want to use this on sparse accesses into
>> large memory regions. The clean utility should be used to utilize
>> hardware dirtying functionality and avoid the overhead of page-faults,
>> typically on large accesses into small memory regions.
> Please use EXPORT_SYMBOL_GPL, just like for apply_to_page_range and
> friends.

Sounds reasonable if this uses already EXPORT_SYMBOL_GPL'd 
functionality. I'll respin.

>    Also in general new core functionality like this should go
> along with the actual user, we don't need to repeat the hmm disaster.

I see in your later message that you noticed the other patches. There's 
also user-space functionality in mesa that excercises this.

/Thomas


