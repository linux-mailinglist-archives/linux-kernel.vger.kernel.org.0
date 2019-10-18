Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 372E2DC1C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 11:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442326AbfJRJuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 05:50:40 -0400
Received: from 8bytes.org ([81.169.241.247]:48002 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730808AbfJRJuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:50:40 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 74B54300; Fri, 18 Oct 2019 11:50:38 +0200 (CEST)
Date:   Fri, 18 Oct 2019 11:50:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Return the correct dma mask when we are
 bypassing the IOMMU
Message-ID: <20191018095036.GB4670@8bytes.org>
References: <20191008143357.GA599223@rani.riverdale.lan>
 <85123533-2e9c-af73-3014-782dd6f925cb@linux.intel.com>
 <20191016191551.GA2692557@rani>
 <20191017070847.GA15037@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017070847.GA15037@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 09:08:47AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 16, 2019 at 03:15:52PM -0400, Arvind Sankar wrote:
> > > > Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Tested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Originally-by: Christoph Hellwig <hch@lst.de>
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > Fixed-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > 
> > > This patch looks good to me.
> > > 
> > > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > 
> > 
> > Hi Christoph, will you be taking this through your dma-mapping branch?
> 
> Given this is a patch to intel-iommu I expect Joerg to pick it up.
> But if he is fine with that I can also queue it up instead.

Fine with me.

Acked-by: Joerg Roedel <jroedel@suse.de>
