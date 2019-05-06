Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA21615331
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 19:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfEFR5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 13:57:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:10127 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfEFR5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:57:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 10:57:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="297649416"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 06 May 2019 10:57:02 -0700
Date:   Mon, 6 May 2019 10:59:51 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 08/19] ioasid: Add custom IOASID allocator
Message-ID: <20190506105951.472ac4fd@jacob-builder>
In-Reply-To: <20190426081903.164dcff3@jacob-builder>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <4ef22c62-0947-8de5-3288-2835ce5fa7a9@redhat.com>
        <20190425142944.40661941@jacob-builder>
        <01fe1710-4022-0bf2-b2ff-307b15b9fabb@redhat.com>
        <20190426081903.164dcff3@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 08:19:03 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> > >>> +		default_allocator_used = 1;      
> > >> shouldn't default_allocator_used be protected as well?    
> >  [...]    
> > >> wouldn't it be possible to integrate the default io asid
> > >> allocator as any custom allocator, ie. implement an alloc
> > >> callback using xa_alloc. Then the active io allocator could be
> > >> either a custom or a default one.    
> > > That is an interesting idea. I think it is possible.
> > > But since default xa allocator is internal to ioasid
> > > infrastructure, why implement it as a callback?    
> > 
> > I mean your could directly define a static const default_allocator
> > in ioasid.c and assign it by default. Do I miss something?
> >   
> got it, seems cleaner. let me give it a try.

Hi Eric,

Just sent out v3 last week. I did look into this but could not find a
clean way of making the default allocator as another custom allocator.
The reason is that default allocator is not interchangeable with
other custom allocators, XArray is shared. So it ends up having lots of
special cases anyway. Feel free to change this.

Thanks,

Jacob
