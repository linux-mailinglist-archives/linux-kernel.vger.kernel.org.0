Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 113F754ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 14:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbfFYM2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 08:28:41 -0400
Received: from verein.lst.de ([213.95.11.211]:34433 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfFYM2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:28:40 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 02DC568B05; Tue, 25 Jun 2019 14:28:09 +0200 (CEST)
Date:   Tue, 25 Jun 2019 14:28:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Helge Deller <deller@gmx.de>
Cc:     Christoph Hellwig <hch@lst.de>, Vineet Gupta <vgupta@synopsys.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] dma-direct: handle DMA_ATTR_NON_CONSISTENT in
 common code
Message-ID: <20190625122808.GB4421@lst.de>
References: <20190614144431.21760-1-hch@lst.de> <20190614144431.21760-6-hch@lst.de> <3eb32e0b-5aa4-fe1e-e581-038750e11cef@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eb32e0b-5aa4-fe1e-e581-038750e11cef@gmx.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 02:23:45PM +0200, Helge Deller wrote:
> On 14.06.19 16:44, Christoph Hellwig wrote:
> > Only call into arch_dma_alloc if we require an uncached mapping,
> > and remove the parisc code manually doing normal cached
> > DMA_ATTR_NON_CONSISTENT allocations.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Helge Deller <deller@gmx.de> # parisc
> 
> Boot-tested 32-bit kernel on PCX-L and PCX-W2 machines (although
> the patches don't cleanly apply any longer against git head).

The series was against the dma-mapping tree, which might have diverged
a bit already.

Thanks for testing!
