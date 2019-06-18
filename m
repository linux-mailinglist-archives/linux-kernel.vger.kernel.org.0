Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0588D4A571
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 17:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfFRPc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 11:32:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:49260 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729189AbfFRPc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:32:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A46EAF79;
        Tue, 18 Jun 2019 15:32:25 +0000 (UTC)
Date:   Tue, 18 Jun 2019 17:32:24 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     baolu.lu@linux.intel.com, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/intel: silence a variable set but not used
Message-ID: <20190618153223.GQ8151@suse.de>
References: <1559570719-16285-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559570719-16285-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 10:05:19AM -0400, Qian Cai wrote:
> The commit "iommu/vt-d: Probe DMA-capable ACPI name space devices"
> introduced a compilation warning due to the "iommu" variable in
> for_each_active_iommu() but never used the for each element, i.e,
> "drhd->iommu".
> 
> drivers/iommu/intel-iommu.c: In function 'probe_acpi_namespace_devices':
> drivers/iommu/intel-iommu.c:4639:22: warning: variable 'iommu' set but
> not used [-Wunused-but-set-variable]
>   struct intel_iommu *iommu;
> 
> Silence the warning the same way as in the commit d3ed71e5cc50
> ("drivers/iommu/intel-iommu.c: fix variable 'iommu' set but not used")
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/iommu/intel-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

