Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7804290B1A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 00:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfHPWkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 18:40:46 -0400
Received: from foss.arm.com ([217.140.110.172]:34200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbfHPWkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:40:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 028F6344;
        Fri, 16 Aug 2019 15:40:46 -0700 (PDT)
Received: from [10.37.12.84] (unknown [10.37.12.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8B533F718;
        Fri, 16 Aug 2019 15:40:44 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH 07/11] swiotlb-xen: provide a single
 page-coherent.h header
To:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190816130013.31154-1-hch@lst.de>
 <20190816130013.31154-8-hch@lst.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <9a3261c6-5d92-cf6b-1ae8-3a8e8b5ef0d4@arm.com>
Date:   Fri, 16 Aug 2019 23:40:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816130013.31154-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/16/19 2:00 PM, Christoph Hellwig wrote:
> Merge the various page-coherent.h files into a single one that either
> provides prototypes or stubs depending on the need for cache
> maintainance.
> 
> For extra benefits alo include <xen/page-coherent.h> in the file
> actually implementing the interfaces provided.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm/include/asm/xen/page-coherent.h   |  2 --
>   arch/arm/xen/mm.c                          |  1 +
>   arch/arm64/include/asm/xen/page-coherent.h |  2 --
>   arch/x86/include/asm/xen/page-coherent.h   | 22 ------------------
>   drivers/xen/swiotlb-xen.c                  |  4 +---
>   include/Kbuild                             |  2 +-
>   include/xen/{arm => }/page-coherent.h      | 27 +++++++++++++++++++---

I am not sure I agree with this rename. The implementation of the 
helpers are very Arm specific as this is assuming Dom0 is 1:1 mapped.

This was necessary due to the lack of IOMMU on Arm platforms back then.
But this is now a pain to get rid of it on newer platform...

Cheers,

-- 
Julien Grall
