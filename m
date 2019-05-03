Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3364212FBD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfECOEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 10:04:12 -0400
Received: from 8bytes.org ([81.169.241.247]:39236 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfECOEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:04:12 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 83CEA41A; Fri,  3 May 2019 16:04:10 +0200 (CEST)
Date:   Fri, 3 May 2019 16:04:10 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, robin.murphy@arm.com,
        bigeasy@linutronix.de, linux-rt-users@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 7/7] iommu/dma-iommu: Remove iommu_dma_map_msi_msg()
Message-ID: <20190503140410.GD6731@8bytes.org>
References: <20190501135824.25586-1-julien.grall@arm.com>
 <20190501135824.25586-8-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501135824.25586-8-julien.grall@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 02:58:24PM +0100, Julien Grall wrote:
> A recent change split iommu_dma_map_msi_msg() in two new functions. The
> function was still implemented to avoid modifying all the callers at
> once.
> 
> Now that all the callers have been reworked, iommu_dma_map_msi_msg() can
> be removed.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Acked-by: Joerg Roedel <jroedel@suse.de>
