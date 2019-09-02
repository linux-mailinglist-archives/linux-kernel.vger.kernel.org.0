Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233EAA5441
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 12:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbfIBKpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 06:45:06 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12279 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729805AbfIBKpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 06:45:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6cf2b30003>; Mon, 02 Sep 2019 03:45:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 02 Sep 2019 03:45:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 02 Sep 2019 03:45:05 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Sep
 2019 10:45:03 +0000
Subject: Re: [PATCH] soc/tegra: fuse: Add clock error check in
 tegra_fuse_readl
To:     Nagarjuna Kristam <nkristam@nvidia.com>,
        <thierry.reding@gmail.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1566991129-13479-1-git-send-email-nkristam@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <95734aa4-c7cb-17a2-fa4c-416a5a40b3e6@nvidia.com>
Date:   Mon, 2 Sep 2019 11:45:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566991129-13479-1-git-send-email-nkristam@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567421107; bh=23RK3bFsbXHJOcLJuWydUO0ViPES8WxSZ9tSvoPFM6Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pO+Ye//gYChuiGk6/8Yu6IiQseGoS+tMfJ3jAmIrD4dOSfut8k8TmkIXYU/4C7ANk
         rXszbX22n6Otx6F/nIs37wqNpxQZYsFImGwNLJcQayLzytfq9QV2+U69wyeQpqz+EL
         eBP99eN024dLFRy/cfBp/Kjr7bXckLNq0vOKm+/HpibljJi71bE1/0cI33QTratqBb
         piZy2Wq0QBIjAFumtOiXZsf4zwv/MIKTgk1Ji1ziu/U3kfsTrcEjm8G4oux2wP5DJi
         uppPMAy3bVv8z3L7St+KsDm5Z/tmiazQ1QegN4geX6xcrK+EkmXflH/1ZG3JjKjC9H
         op2el/9q1bxPA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/08/2019 12:18, Nagarjuna Kristam wrote:
> Tegra fuse clock handle is retrieved in tegra_fuse_probe().
> tegra_fuse_readl() is exported symbol, which can be called from drivers
> at any time. tegra_fuse_readl() enables fuse clock and reads corresponding
> fuse register offset.
> 
> Calling tegra_fuse_readl() before tegra_fuse_probe(), will cause data
> abort. Add DEFER_PROBE error check for fuse clock in tegra_fuse_readl(),
> to avoid enabling of fuse clock, before clock is available.
> 
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/fuse-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
> index 3eb44e6..21b39b7 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra.c
> @@ -186,7 +186,7 @@ u32 __init tegra_fuse_read_early(unsigned int offset)
>  
>  int tegra_fuse_readl(unsigned long offset, u32 *value)
>  {
> -	if (!fuse->read)
> +	if (!fuse->read || (PTR_ERR(fuse->clk) == -EPROBE_DEFER))
>  		return -EPROBE_DEFER;

What about the case where fuse->clk is NULL or a different error value?

Jon

-- 
nvpublic
