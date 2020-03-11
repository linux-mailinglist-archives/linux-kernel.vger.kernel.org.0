Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C99181D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgCKQPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:15:55 -0400
Received: from verein.lst.de ([213.95.11.211]:60211 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730104AbgCKQPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:15:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B1DE468C65; Wed, 11 Mar 2020 17:15:51 +0100 (CET)
Date:   Wed, 11 Mar 2020 17:15:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
        aros@gmx.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] device core: fix dma_mask handling in
 platform_device_register_full
Message-ID: <20200311161551.GA24878@lst.de>
References: <20200311160710.376090-1-hch@lst.de> <20200311161423.GA3941932@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311161423.GA3941932@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 05:14:23PM +0100, Greg KH wrote:
> On Wed, Mar 11, 2020 at 05:07:10PM +0100, Christoph Hellwig wrote:
> > Ever since the generic platform device code started allocating DMA masks
> > itself the code to allocate and leak a private DMA mask in
> > platform_device_register_full has been superflous.  More so the fact that
> > it unconditionally frees the DMA mask allocation in the failure path
> > can lead to slab corruption if the function fails later on for a device
> > where it didn't allocate the mask.  Just remove the offending code.
> > 
> > Fixes: cdfee5623290 ("driver core: initialize a default DMA mask for platform device")
> > Reported-by: Artem S. Tashkinov <aros@gmx.com>
> > Tested-by: Artem S. Tashkinov <aros@gmx.com>
> 
> No s-o-b from you?  :(
> 
> I can take this, or Linus, you can take this now if you want to as well:

Sorry, here it is:

Signed-off-by: Christoph Hellwig <hch@lst.de>
