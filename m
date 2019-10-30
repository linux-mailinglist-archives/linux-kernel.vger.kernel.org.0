Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5D6E9909
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 10:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfJ3JRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 05:17:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:49076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:17:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6950FAF99;
        Wed, 30 Oct 2019 09:17:03 +0000 (UTC)
Date:   Wed, 30 Oct 2019 10:17:01 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        geert+renesas@glider.be
Subject: Re: [PATCH -next] iommu/ipmmu-vmsa: Remove dev_err() on
 platform_get_irq() failure
Message-ID: <20191030091701.GN838@suse.de>
References: <20191023135941.15000-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023135941.15000-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 09:59:41PM +0800, YueHaibing wrote:
> platform_get_irq() will call dev_err() itself on failure,
> so there is no need for the driver to also do this.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied for v5.4, thanks.
