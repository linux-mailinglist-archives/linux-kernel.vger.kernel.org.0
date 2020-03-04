Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B56179350
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 16:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbgCDPZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 10:25:30 -0500
Received: from 8bytes.org ([81.169.241.247]:50014 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgCDPZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:25:29 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DCA7420A; Wed,  4 Mar 2020 16:25:27 +0100 (CET)
Date:   Wed, 4 Mar 2020 16:25:23 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Suman Anna <s-anna@ti.com>
Subject: Re: [RESEND PATCH 1/4] iommu/omap: Fix pointer cast
 -Wpointer-to-int-cast warnings on 64 bit
Message-ID: <20200304152522.GA3315@8bytes.org>
References: <20200303202751.5153-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200303202751.5153-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 09:27:48PM +0100, Krzysztof Kozlowski wrote:
> pointers should be casted to unsigned long to avoid
> -Wpointer-to-int-cast warnings when compiling on 64-bit platform (e.g.
> with COMPILE_TEST):
> 
>     drivers/iommu/omap-iommu.c: In function ‘omap2_iommu_enable’:
>     drivers/iommu/omap-iommu.c:170:25: warning:
>         cast from pointer to integer of different size [-Wpointer-to-int-cast]
>       if (!obj->iopgd || !IS_ALIGNED((u32)obj->iopgd,  SZ_16K))
>                              ^
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied all, thanks.
