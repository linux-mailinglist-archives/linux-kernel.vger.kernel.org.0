Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC3937AC53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 17:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbfG3P0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 11:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbfG3P0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:26:06 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46D89206E0;
        Tue, 30 Jul 2019 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564500365;
        bh=cyeRiBni7SuzwXceJSbBai+SAVPR79ccBM2xDiF7Qsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqV1ZTJo+V6m8AOFtBhU9I32ADwWfOw/v5O54IHwgGH9d6LTFPbEo5tcntliWrtRB
         xP3CnUpzrubt1AH+/OzUsf5kgjV6+Uv3oh6HfTa2E5YFSEnxge64zSwPPnW9UtURRp
         KSadpsgy9Rp680FRBFXkOhVzfeaWaIUI2E2ZxH5g=
Date:   Tue, 30 Jul 2019 16:26:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com
Subject: Re: [PATCH v2] iommu: arm-smmu-v3: Mark expected switch fall-through
Message-ID: <20190730152600.643mg43y6567pchi@willie-the-truck>
References: <20190730152012.2615-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730152012.2615-1-anders.roxell@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 05:20:11PM +0200, Anders Roxell wrote:
> Now that -Wimplicit-fallthrough is passed to GCC by default, the
> following warning shows up:
> 
> ../drivers/iommu/arm-smmu-v3.c: In function ‘arm_smmu_write_strtab_ent’:
> ../drivers/iommu/arm-smmu-v3.c:1189:7: warning: this statement may fall
>  through [-Wimplicit-fallthrough=]
>     if (disable_bypass)
>        ^
> ../drivers/iommu/arm-smmu-v3.c:1191:3: note: here
>    default:
>    ^~~~~~~
> 
> Rework so that the compiler doesn't warn about fall-through. Make it
> clearer by calling 'BUG_ON()' when disable_bypass is set, and always
> 'break;'
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index a9a9fabd3968..c5c93e48b4db 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1186,8 +1186,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  			ste_live = true;
>  			break;
>  		case STRTAB_STE_0_CFG_ABORT:
> -			if (disable_bypass)
> -				break;
> +			BUG_ON(!disable_bypass);
> +			break;
>  		default:
>  			BUG(); /* STE corruption */
>  		}
> -- 
> 2.20.1

Acked-by: Will Deacon <will@kernel.org>

Joerg -- if you'd like to pick this up as a fix, feel free, otherwise I'll
include it in my pull request for 5.4.

Cheers,

Will
