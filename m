Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A835129201
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 07:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfLWGnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 01:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfLWGnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:43:33 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D697420709;
        Mon, 23 Dec 2019 06:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577083413;
        bh=jzHTI8WiVGxPNfK1Jb/+TploBriVtYYWmvmKPhAOjOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=blI3EauGJ8VEsiIryOqTagcs7fQ4PQzc8A8xgxjYMmeGkwwYnJeR3VTmigWGeorBf
         qkMkMcRdgf3XJbtRNhsIZ+BEq1v2Dk8Gsk1FFi7/KaonabSv3Tyj8y8hAIWXU7IB1W
         258MsF/Q1mChsD5Tvm3g/9h4o6k/9jEl5hxRUCYA=
Date:   Mon, 23 Dec 2019 14:43:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, xiaobo.xie@nxp.com,
        jiafei.pan@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: ls1028a-rdb: enable emmc hs400 mode
Message-ID: <20191223064311.GN11523@dragon>
References: <20191213021839.23517-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213021839.23517-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 10:18:38AM +0800, Yinbo Zhu wrote:
> This patch is to enable emmc hs400 mode for ls1028ardb
> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> Acked-by: Shawn Guo <shawnguo@kernel.org>

Did I?  You can only add the tag when people explicitly gave it.

Applied, thanks.

Shawn

> Acked-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Change in v2:
> 		add Acked-by 
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index 9720a190049f..61c4f772e3a6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -93,6 +93,8 @@
>  
>  &esdhc1 {
>  	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	bus-width = <8>;
>  	status = "okay";
>  };
>  
> -- 
> 2.17.1
> 
