Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA68412283A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 11:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLQKCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 05:02:20 -0500
Received: from 8bytes.org ([81.169.241.247]:57650 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbfLQKCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:02:20 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 13033286; Tue, 17 Dec 2019 11:02:19 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:02:17 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Xiaotao Yin <xiaotao.yin@windriver.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Kexin.Hao@windriver.com
Subject: Re: [PATCH V2] iommu/iova: Init the struct iova to fix the possible
 memleak
Message-ID: <20191217100217.GH8689@8bytes.org>
References: <20191209082404.40166-1-xiaotao.yin@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209082404.40166-1-xiaotao.yin@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 04:24:04PM +0800, Xiaotao Yin wrote:
> The reason:
> When alloc_iova_mem() without initial with Zero, sometimes fpn_lo will equal to
> IOVA_ANCHOR by chance, so when return from __alloc_and_insert_iova_range() with
> -ENOMEM(iova32_full), the new_iova will not be freed in free_iova_mem().
> 
> Fixes: bb68b2fbfbd6 ("iommu/iova: Add rbtree anchor node")
> Signed-off-by: Xiaotao Yin <xiaotao.yin@windriver.com>
> ---
>  drivers/iommu/iova.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied for v5.5, thanks.
