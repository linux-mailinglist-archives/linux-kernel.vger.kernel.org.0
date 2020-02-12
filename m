Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDAC15A6F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 11:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgBLKtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 05:49:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbgBLKtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:49:08 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA3D32082F;
        Wed, 12 Feb 2020 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581504548;
        bh=e7/KyaTyypq+Fd/F2Np5hVC5zzZzRMc32NuzncQ3qr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3CZSF6H7D/ew3dYU1hxbYGV9FK3JiiBQCudA+bcHr5Dk5IZycoxRNeIIAczEJqZx
         If5vFyX31y5yq6FxhPyHwSCDqIAJJh6SwTK1/8xMwNCt3TKZ/W20LPfEpWgZrOpiXN
         VIfGeiSbNiAu4H64sjCjLwY8SP/gbnSeWNK9h0qc=
Date:   Wed, 12 Feb 2020 10:49:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu: fix the module name to be consistent
 with older kernel
Message-ID: <20200212104902.GA3664@willie-the-truck>
References: <1581467841-25397-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581467841-25397-1-git-send-email-leoyang.li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 06:37:20PM -0600, Li Yang wrote:
> Commit cd221bd24ff5 ("iommu/arm-smmu: Allow building as a module")
> introduced a side effect that changed the module name from arm-smmu to
> arm-smmu-mod.  This breaks the users of kernel parameters for the driver
> (e.g. arm-smmu.disable_bypass).  This patch changes the module name back
> to be consistent.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/iommu/Makefile                          | 4 ++--
>  drivers/iommu/{arm-smmu.c => arm-smmu-common.c} | 0
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename drivers/iommu/{arm-smmu.c => arm-smmu-common.c} (100%)

Can't we just override MODULE_PARAM_PREFIX instead of renaming the file?

Will
