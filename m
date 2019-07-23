Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C238471BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 17:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbfGWPhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 11:37:41 -0400
Received: from verein.lst.de ([213.95.11.211]:42762 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfGWPhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:37:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 56C4968B02; Tue, 23 Jul 2019 17:37:39 +0200 (CEST)
Date:   Tue, 23 Jul 2019 17:37:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-mapping: Use dma_get_mask in
 dma_addressing_limited
Message-ID: <20190723153739.GC720@lst.de>
References: <20190722165149.3763-1-eric.auger@redhat.com> <77ba1061-08b6-421e-a6dd-d5db9851325b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ba1061-08b6-421e-a6dd-d5db9851325b@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 06:56:49PM +0200, Auger Eric wrote:
> Hi Christoph,
> 
> On 7/22/19 6:51 PM, Eric Auger wrote:
> > We currently have cases where the dma_addressing_limited() gets
> > called with dma_mask unset. This causes a NULL pointer dereference.
> > 
> > Use dma_get_mask() accessor to prevent the crash.
> > 
> > Fixes: b866455423e0 ("dma-mapping: add a dma_addressing_limited helper")
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> As a follow-up of my last email, here is a patch featuring
> dma_get_mask(). But you don't have the WARN_ON_ONCE anymore, pointing
> out suspect users.
> 
> Feel free to pick up your preferred approach

I can take this for now as we are past the merge window.
