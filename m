Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8476F7761
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 16:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKKPIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 10:08:19 -0500
Received: from 8bytes.org ([81.169.241.247]:51344 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbfKKPIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:08:18 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 26B381E6; Mon, 11 Nov 2019 16:08:17 +0100 (CET)
Date:   Mon, 11 Nov 2019 16:08:15 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] iommu/vt-d: Turn off translations at shutdown
Message-ID: <20191111150815.GG18333@8bytes.org>
References: <20191110172744.12541-1-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110172744.12541-1-deepa.kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 09:27:44AM -0800, Deepa Dinamani wrote:
> The intel-iommu driver assumes that the iommu state is
> cleaned up at the start of the new kernel.
> But, when we try to kexec boot something other than the
> Linux kernel, the cleanup cannot be relied upon.
> Hence, cleanup before we go down for reboot.
> 
> Keeping the cleanup at initialization also, in case BIOS
> leaves the IOMMU enabled.
> 
> I considered turning off iommu only during kexec reboot, but a clean
> shutdown seems always a good idea. But if someone wants to make it
> conditional, such as VMM live update, we can do that.  There doesn't
> seem to be such a condition at this time.
> 
> Tested that before, the info message
> 'DMAR: Translation was enabled for <iommu> but we are not in kdump mode'
> would be reported for each iommu. The message will not appear when the
> DMA-remapping is not enabled on entry to the kernel.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
> Changes since v1:
> * move shutdown registration to iommu detection
> 
>  drivers/iommu/dmar.c        |  5 ++++-
>  drivers/iommu/intel-iommu.c | 20 ++++++++++++++++++++
>  include/linux/dmar.h        |  2 ++
>  3 files changed, 26 insertions(+), 1 deletion(-)

Applied, thanks.
