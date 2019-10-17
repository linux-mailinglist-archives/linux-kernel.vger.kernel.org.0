Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14FA5DA5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 09:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407904AbfJQHIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 03:08:52 -0400
Received: from verein.lst.de ([213.95.11.211]:37276 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390955AbfJQHIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:08:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3C21968B05; Thu, 17 Oct 2019 09:08:48 +0200 (CEST)
Date:   Thu, 17 Oct 2019 09:08:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/vt-d: Return the correct dma mask when we are
 bypassing the IOMMU
Message-ID: <20191017070847.GA15037@lst.de>
References: <20191008143357.GA599223@rani.riverdale.lan> <85123533-2e9c-af73-3014-782dd6f925cb@linux.intel.com> <20191016191551.GA2692557@rani>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016191551.GA2692557@rani>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:15:52PM -0400, Arvind Sankar wrote:
> > > Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > Tested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > Originally-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Fixed-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > 
> > This patch looks good to me.
> > 
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> 
> Hi Christoph, will you be taking this through your dma-mapping branch?

Given this is a patch to intel-iommu I expect Joerg to pick it up.
But if he is fine with that I can also queue it up instead.
