Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3715DD7040
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 09:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfJOHfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 03:35:09 -0400
Received: from verein.lst.de ([213.95.11.211]:53300 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfJOHfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:35:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C96D68CEE; Tue, 15 Oct 2019 09:35:02 +0200 (CEST)
Date:   Tue, 15 Oct 2019 09:35:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ram Pai <linuxram@us.ibm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        mpe@ellerman.id.au, paulus@ozlabs.org, mdroth@linux.vnet.ibm.com,
        aik@linux.ibm.com, paul.burton@mips.com, robin.murphy@arm.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com, hch@lst.de,
        jasowang@redhat.com, andmike@us.ibm.com, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] virtio_ring: Use DMA API if memory is encrypted
Message-ID: <20191015073501.GA32345@lst.de>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com> <1570843519-8696-2-git-send-email-linuxram@us.ibm.com> <1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 06:25:19PM -0700, Ram Pai wrote:
> From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> Normally, virtio enables DMA API with VIRTIO_F_IOMMU_PLATFORM, which must
> be set by both device and guest driver. However, as a hack, when DMA API
> returns physical addresses, guest driver can use the DMA API; even though
> device does not set VIRTIO_F_IOMMU_PLATFORM and just uses physical
> addresses.

Sorry, but this is a complete bullshit hack.  Driver must always use
the DMA API if they do DMA, and if virtio devices use physical addresses
that needs to be returned through the platform firmware interfaces for
the dma setup.  If you don't do that yet (which based on previous
informations you don't), you need to fix it, and we can then quirk
old implementations that already are out in the field.

In other words: we finally need to fix that virtio mess and not pile
hacks on top of hacks.
