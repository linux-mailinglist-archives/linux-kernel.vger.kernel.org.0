Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8608D7A5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 12:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbfG3KUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 06:20:54 -0400
Received: from verein.lst.de ([213.95.11.211]:49954 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbfG3KUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:20:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ADBA968AFE; Tue, 30 Jul 2019 12:20:50 +0200 (CEST)
Date:   Tue, 30 Jul 2019 12:20:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>, laurent.pinchart@ideasonboard.com,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove dma_{alloc,free,mmap}_writecombine
Message-ID: <20190730102050.GA1663@lst.de>
References: <20190730061849.29686-1-hch@lst.de> <5f73f400-eff2-6c7b-887d-c768642d8df1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f73f400-eff2-6c7b-887d-c768642d8df1@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:50:32AM +0300, Tomi Valkeinen wrote:
> On 30/07/2019 09:18, Christoph Hellwig wrote:
>> We can already use DMA_ATTR_WRITE_COMBINE or the _wc prefixed version,
>> so remove the third way of doing things.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/gpu/drm/omapdrm/dss/dispc.c | 11 +++++------
>>   include/linux/dma-mapping.h         |  9 ---------
>>   2 files changed, 5 insertions(+), 15 deletions(-)
>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>
> Which tree should this be applied to?

I'd like to add it to the dma-mapping tree if possible.
