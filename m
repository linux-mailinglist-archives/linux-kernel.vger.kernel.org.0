Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8518BA17
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfHMN0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 09:26:21 -0400
Received: from verein.lst.de ([213.95.11.211]:57266 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbfHMN0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:26:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 77F5C68B02; Tue, 13 Aug 2019 15:26:17 +0200 (CEST)
Date:   Tue, 13 Aug 2019 15:26:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Christoph Hellwig <hch@lst.de>, Ram Pai <linuxram@us.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-devel@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is
 encrypted
Message-ID: <20190813132617.GA6426@lst.de>
References: <87zhrj8kcp.fsf@morokweng.localdomain> <20190810143038-mutt-send-email-mst@kernel.org> <20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de> <20190812095156.GD3947@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812095156.GD3947@umbus.fritz.box>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 07:51:56PM +1000, David Gibson wrote:
> AFAICT we already kind of abuse this for the VIRTIO_F_IOMMU_PLATFORM,
> because to handle for cases where it *is* a device limitation, we
> assume that if the hypervisor presents VIRTIO_F_IOMMU_PLATFORM then
> the guest *must* select it.
> 
> What we actually need here is for the hypervisor to present
> VIRTIO_F_IOMMU_PLATFORM as available, but not required.  Then we need
> a way for the platform core code to communicate to the virtio driver
> that *it* requires the IOMMU to be used, so that the driver can select
> or not the feature bit on that basis.

I agree with the above, but that just brings us back to the original
issue - the whole bypass of the DMA OPS should be an option that the
device can offer, not the other way around.  And we really need to
fix that root cause instead of doctoring around it.
