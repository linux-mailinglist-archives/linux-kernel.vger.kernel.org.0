Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3584A541
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 17:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfFRPZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 11:25:21 -0400
Received: from 8bytes.org ([81.169.241.247]:59816 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbfFRPZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:25:21 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 188C34B5; Tue, 18 Jun 2019 17:25:19 +0200 (CEST)
Date:   Tue, 18 Jun 2019 17:25:17 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Julien Grall <julien.grall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: fix integer truncation
Message-ID: <20190618152517.GB21128@8bytes.org>
References: <20190617133101.2817807-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617133101.2817807-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 03:30:54PM +0200, Arnd Bergmann wrote:
> On 32-bit architectures, phys_addr_t may be different from dma_add_t,
> both smaller and bigger. This can lead to an overflow during an assignment
> that clang warns about:
> 
> drivers/iommu/dma-iommu.c:230:10: error: implicit conversion from 'dma_addr_t' (aka 'unsigned long long') to
>       'phys_addr_t' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Werror,-Wconstant-conversion]
> 
> Use phys_addr_t here because that is the type that the variable was
> declared as.
> 
> Fixes: aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
