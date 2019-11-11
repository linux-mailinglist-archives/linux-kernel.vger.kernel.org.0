Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C46F775C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 16:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKKPGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 10:06:39 -0500
Received: from 8bytes.org ([81.169.241.247]:51336 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfKKPGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:06:38 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 872C61E6; Mon, 11 Nov 2019 16:06:32 +0100 (CET)
Date:   Mon, 11 Nov 2019 16:06:31 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yian Chen <yian.chen@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: Check VT-d RMRR region in BIOS is
 reported as reserved
Message-ID: <20191111150630.GF18333@8bytes.org>
References: <20191017113919.25424-1-yian.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017113919.25424-1-yian.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 04:39:19AM -0700, Yian Chen wrote:
> VT-d RMRR (Reserved Memory Region Reporting) regions are reserved
> for device use only and should not be part of allocable memory pool of OS.
> 
> BIOS e820_table reports complete memory map to OS, including OS usable
> memory ranges and BIOS reserved memory ranges etc.
> 
> x86 BIOS may not be trusted to include RMRR regions as reserved type
> of memory in its e820 memory map, hence validate every RMRR entry
> with the e820 memory map to make sure the RMRR regions will not be
> used by OS for any other purposes.
> 
> ia64 EFI is working fine so implement RMRR validation as a dummy function
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> ---
> v2:
> - return -EINVAL instead of -EFAULT when there is an error
> ---
>  arch/ia64/include/asm/iommu.h |  5 +++++
>  arch/x86/include/asm/iommu.h  | 18 ++++++++++++++++++
>  drivers/iommu/intel-iommu.c   |  8 +++++++-
>  3 files changed, 30 insertions(+), 1 deletion(-)

Applied, thanks.
