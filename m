Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 657625234F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 08:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfFYGLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 02:11:37 -0400
Received: from verein.lst.de ([213.95.11.211]:59765 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfFYGLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:11:36 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 413AB68B02; Tue, 25 Jun 2019 08:11:04 +0200 (CEST)
Date:   Tue, 25 Jun 2019 08:11:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>, Vineet Gupta <vgupta@synopsys.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] dma-direct: handle DMA_ATTR_NON_CONSISTENT in
 common code
Message-ID: <20190625061104.GB28986@lst.de>
References: <20190614144431.21760-1-hch@lst.de> <20190614144431.21760-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614144431.21760-6-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 06:08:40PM +0800, Hillf Danton wrote:
> Literally, any cpu (call it cpuW) other than pcx12 and pcx1 will no longer do
> dma alloc for any device with this patch applied.

Yes.  And that is not a chance from the previous code, where only
pcx1 and pcx12 could do coherent allocations,

> On the other hand, 
> !dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT) will ask
> any cpu to do dma alloc, regardless of pcx1. This patch works imo unless cpuW
> plays games only with devices that are dma coherent. I doubt it is true.

I can't parse these two sentences.  But to explains the bits mentioned
here - dev_is_dma_coherent will return if a device is coherently
attached vs the cpu.  This will never be true for the parisc direct
mapping.  DMA_ATTR_NON_CONSISTENT asks for a non-coherent mapping that
needs to be explicitly synced.  This support now is in the dma-direct
core code, and this is what the parisc specific devices used on the
non-pcxl systems use, as they do not support dma coherency at all.
(the story slightly changes when using an iommu, but that is irrelevant
here)
