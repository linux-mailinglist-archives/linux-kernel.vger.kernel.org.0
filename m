Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E441B31291
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfEaQjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 12:39:35 -0400
Received: from verein.lst.de ([213.95.11.211]:41791 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfEaQje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:39:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9B79C68AA6; Fri, 31 May 2019 18:39:07 +0200 (CEST)
Date:   Fri, 31 May 2019 18:39:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com,
        natechancellor@gmail.com, vdumpa@nvidia.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, chris@zankel.net,
        jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org,
        tony@atomide.com, akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        dann.frazier@canonical.com
Subject: Re: [PATCH] dma-contiguous: Fix !CONFIG_DMA_CMA version of
 dma_{alloc,free}_contiguous()
Message-ID: <20190531163907.GA27525@lst.de>
References: <20190530005425.7184-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530005425.7184-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping tree.
