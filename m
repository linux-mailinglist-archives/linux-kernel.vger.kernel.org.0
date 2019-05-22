Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A352640B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 14:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfEVMuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 08:50:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49898 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfEVMuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:50:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64CBC80D;
        Wed, 22 May 2019 05:50:50 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED6273F575;
        Wed, 22 May 2019 05:50:48 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <20190522072018.10660-1-horia.geanta@nxp.com>
 <20190522123243.GA26390@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6cbe5470-16a6-17e9-337d-6ba18b16b6e8@arm.com>
Date:   Wed, 22 May 2019 13:50:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522123243.GA26390@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2019 13:32, Christoph Hellwig wrote:
> I'm a little worried about this.  While it looks functionally correct
> we have surived without it, and doing another copy for every swiotlb
> dma mapping from the device looks extremely painful for the typical use
> cases where we expect the device to transfer the whole mapping.
> 
> I'd be tempted to instead properl document the current behavior and
> introduce a new DMA_ATTR_PARTIAL flag to allow for partial mappings.

Would that work out any different from the existing 
DMA_ATTR_SKIP_CPU_SYNC? If drivers are prepared to handle this issue 
from their end, they can already do so for single mappings by using that 
attr along with explicit partial syncs via dma_sync_single(). For 
page/sg mappings we'd still have the problem of identifying what part of 
"partial" actually matters, and probably having to add some additional 
new sync operations to cope.

Robin.
