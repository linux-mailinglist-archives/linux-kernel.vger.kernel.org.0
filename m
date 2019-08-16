Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63418901A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 14:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfHPMeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 08:34:15 -0400
Received: from verein.lst.de ([213.95.11.211]:55173 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfHPMeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:34:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E3D2B68B05; Fri, 16 Aug 2019 14:34:12 +0200 (CEST)
Date:   Fri, 16 Aug 2019 14:34:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct
 hmm_vma_walk
Message-ID: <20190816123412.GB22140@lst.de>
References: <20190815180325.GA4920@redhat.com> <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com> <20190815194339.GC9253@redhat.com> <CAPcyv4jid8_=-8hBpn_Qm=c4S8BapL9B9RGT7e9uu303yH=Yqw@mail.gmail.com> <20190815203306.GB25517@redhat.com> <20190815204128.GI22970@mellanox.com> <20190815205132.GC25517@redhat.com> <20190816004303.GC9929@mellanox.com> <20190816044448.GB4093@lst.de> <20190816123036.GD5412@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816123036.GD5412@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 12:30:41PM +0000, Jason Gunthorpe wrote:
> 
> For instance, a system may have multiple DEVICE_PRIVATE map's owned by
> the same driver - but multiple physical devices using that driver.
> 
> Each physical device's driver should only ever get DEVICE_PRIVATE
> pages for it's own on-device memory. Never a DEVICE_PRIVATE for
> another device's memory.
> 
> The dev_pagemap_ops would not be unique enough, right?

True.

> 
> Probably also clusters of same-driver struct device can share a
> DEVICE_PRIVATE, at least high end GPU's now have private memory
> coherency busses between their devices.
> 
> Since we want to trigger migration to CPU on incompatible
> DEVICE_PRIVATE pages, it seems best to sort this out in the
> hmm_range_fault?
> 
> Maybe some sort of unique ID inside the page->pgmap and passed as
> input?

Yes, we'll probably need an owner field.  And it's not just
hmm_range_fault, the migrate_vma_* routines as affected in the same
way.
