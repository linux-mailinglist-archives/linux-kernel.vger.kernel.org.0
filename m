Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD52932DBF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfFCKjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 06:39:05 -0400
Received: from 8bytes.org ([81.169.241.247]:41048 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfFCKjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:39:05 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 31E7336B; Mon,  3 Jun 2019 12:39:04 +0200 (CEST)
Date:   Mon, 3 Jun 2019 12:39:02 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] iommu/dma: Fix condition check in iommu_dma_unmap_sg
Message-ID: <20190603103902.GK12745@8bytes.org>
References: <20190529081532.73585-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529081532.73585-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 01:15:32AM -0700, Nathan Chancellor wrote:
> Fixes: 06d60728ff5c ("iommu/dma: move the arm64 wrappers to common code")
> Link: https://github.com/ClangBuiltLinux/linux/issues/497
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
