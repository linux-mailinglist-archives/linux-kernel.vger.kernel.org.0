Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9BB19B892
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 00:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbgDAWkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 18:40:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:35883 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387854AbgDAWkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:40:03 -0400
IronPort-SDR: pmx6LV7zty16kp3d743RranwYvgRwX5OojLt0wSaTlh1Ga2PaVlvGLQ/zcQDfcIjyA3k9McFGH
 2xWaFZf1ewrQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 15:40:02 -0700
IronPort-SDR: wON8Mv2Y7vmNMgxffq6zVTWfkWxEp8c5nNy1rnrGL8PZHtpcaJbZ8VCC4w+pQacKjCPq0zOzu2
 5Jrbr6onsAug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; 
   d="scan'208";a="328616975"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 01 Apr 2020 15:40:02 -0700
Date:   Wed, 1 Apr 2020 15:45:50 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 06/10] iommu/ioasid: Convert to set aware allocations
Message-ID: <20200401154550.3775be8f@jacob-builder>
In-Reply-To: <20200401135525.GG882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585158931-1825-7-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200401135525.GG882512@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 15:55:25 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Wed, Mar 25, 2020 at 10:55:27AM -0700, Jacob Pan wrote:
> > The current ioasid_alloc function takes a token/ioasid_set then
> > record it on the IOASID being allocated. There is no alloc/free on
> > the ioasid_set.
> > 
> > With the IOASID set APIs, callers must allocate an ioasid_set before
> > allocate IOASIDs within the set. Quota and other ioasid_set level
> > activities can then be enforced.
> > 
> > This patch converts existing API to the new ioasid_set model.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> [...]
> 
> > @@ -379,6 +391,9 @@ ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max, }
> >  	data->id = id;
> >  
> > +	/* Store IOASID in the per set data */
> > +	xa_store(&sdata->xa, id, data, GFP_KERNEL);  
> 
> I couldn't figure out why you're maintaining an additional xarray for
> each set. We're already storing that data in active_allocator->xa,
> why the duplication?  If it's for the gPASID -> hPASID translation
> mentioned by the cover letter, maybe you could add this xa when
> introducing that change?
> 
Sounds good. I will add that later. I was hoping to get common code in
place.
