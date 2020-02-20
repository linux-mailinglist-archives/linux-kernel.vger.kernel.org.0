Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41EF616553F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 03:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBTCtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 21:49:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:43079 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgBTCtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:49:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 18:49:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; 
   d="scan'208";a="228782315"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.162.231]) ([10.249.162.231])
  by fmsmga007.fm.intel.com with ESMTP; 19 Feb 2020 18:49:39 -0800
Subject: Re: question about iommu_need_mapping
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200219235516.zl44y7ydgqqja6x5@cantor>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <af5a148e-76bc-4aa4-dd1c-b04a5ffc56b1@linux.intel.com>
Date:   Thu, 20 Feb 2020 10:49:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219235516.zl44y7ydgqqja6x5@cantor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

On 2020/2/20 7:55, Jerry Snitselaar wrote:
> Is it possible for a device to end up with dev->archdata.iommu == NULL
> on iommu_need_mapping in the following instance:
> 
> 1. iommu_group has dma domain for default
> 2. device gets private identity domain in intel_iommu_add_device
> 3. iommu_need_mapping gets called with that device.
> 4. dmar_remove_one_dev_info sets dev->archdata.iommu = NULL via 
> unlink_domain_info.
> 5. request_default_domain_for_dev exits after checking that 
> group->default_domain
>     exists, and group->default_domain->type is dma.
> 6. iommu_request_dma_domain_for_dev returns 0 from 
> request_default_domain_for_dev
>     and a private dma domain isn't created for the device.
> 

Yes. It's possible.

> The case I was seeing went away with commit 9235cb13d7d1 ("iommu/vt-d:
> Allow devices with RMRRs to use identity domain"), because it changed
> which domain the group and devices were using, but it seems like it is
> still a possibility with the code. Baolu, you mentioned possibly
> removing the domain switch. Commit 98b2fffb5e27 ("iommu/vt-d: Handle
> 32bit device with identity default domain") makes it sound like the
> domain switch is required.

It's more "nice to have" than "required" if the iommu driver doesn't
disable swiotlb explicitly. The device access of system memory higher
than the device's addressing capability could go through the bounced
buffer implemented in swiotlb.

Best regards,
baolu
