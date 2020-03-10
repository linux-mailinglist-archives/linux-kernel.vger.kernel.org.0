Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6074F17F57E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 11:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgCJK6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 06:58:17 -0400
Received: from 8bytes.org ([81.169.241.247]:50788 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgCJK6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:58:17 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 73287364; Tue, 10 Mar 2020 11:58:15 +0100 (CET)
Date:   Tue, 10 Mar 2020 11:58:14 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/6] iommu/vt-d: Don't force 32bit devices to uses DMA
 domain
Message-ID: <20200310105813.GE3794@8bytes.org>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com>
 <20200307062014.3288-4-baolu.lu@linux.intel.com>
 <20200307142144.GB26190@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307142144.GB26190@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 03:21:44PM +0100, Christoph Hellwig wrote:
> Can we add a new AUTO domain which will allow using the identity
> mapping when available?  That somewhat matches the existing x86
> default, and also what powerpc does.  I have a series to lift
> that bypass mode into the core dma-mapping code that I need
> to repost, which I think would be suitable for intel-iommu as well.

Please Cc me on that series when you re-post it.


Thanks,

	Joerg
