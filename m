Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5956217F5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 12:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgCJLPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 07:15:06 -0400
Received: from 8bytes.org ([81.169.241.247]:50800 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgCJLPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:15:06 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8344F364; Tue, 10 Mar 2020 12:15:04 +0100 (CET)
Date:   Tue, 10 Mar 2020 12:15:03 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/6] Replace private domain with per-group default
Message-ID: <20200310111503.GF3794@8bytes.org>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307062014.3288-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Sat, Mar 07, 2020 at 02:20:08PM +0800, Lu Baolu wrote:
> Lu Baolu (5):
>   iommu: Configure default domain with dev_def_domain_type
>   iommu/vt-d: Don't force 32bit devices to uses DMA domain
>   iommu/vt-d: Don't force PCI sub-hierarchy to use DMA domain
>   iommu/vt-d: Add dev_def_domain_type callback
>   iommu/vt-d: Apply per-device dma_ops
> 
> Sai Praneeth Prakhya (1):
>   iommu: Add dev_def_domain_type() callback in iommu_ops

I like this patch-set, but I fear some regressions from patch
"iommu/vt-d: Don't force 32bit devices to uses DMA domain". Have you
tested this series on a couple of machines, ideally even older ones from
the first generation of VT-d hardware?

Regards,

	Joerg
