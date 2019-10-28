Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9ACE755D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 16:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389823AbfJ1Pnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 11:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfJ1Pnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:43:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7068F208C0;
        Mon, 28 Oct 2019 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572277410;
        bh=C+rKFmVAW85HqF5Q2tZqbzx2fR29+zHePsntThp0M3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xDSbs4LDfq5owyR8M7SUXS6b2FrPZq5WAQu7iLhwsmwAVHF0ZrUBIlBp0NR1A2Fvg
         QdukwEXPRHwuWf3MB2P9hlffBmctRTbd3pyujaJdwwFnLTKC5Mfu4I0ph2//7Zxhvh
         XVG+ukIh+waIeL89u/0sj9tysP9mgsvREuBK8xpA=
Date:   Mon, 28 Oct 2019 15:43:26 +0000
From:   Will Deacon <will@kernel.org>
To:     Marek Bykowski <marek.bykowski@gmail.com>
Cc:     mark.rutland@arm.com, will.deacon@arm.com, pawel.moll@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] perf: arm-ccn: Enable stats for CCN-512
 interconnect
Message-ID: <20191028154325.GC5576@willie-the-truck>
References: <1570454475-2848-1-git-send-email-marek.bykowski@gmail.com>
 <20191016110612.17381ad6@gmail.com>
 <20191016115739.0d5d2272@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016115739.0d5d2272@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:57:39AM +0200, Marek Bykowski wrote:
> Add compatible string for the ARM CCN-512 interconnect
> 
> Signed-off-by: Marek Bykowski <marek.bykowski@gmail.com>
> Signed-off-by: Boleslaw Malecki <boleslaw.malecki@tieto.com>

I've queued this (and the docs change), but does it really need two
sign-offs for a one-line change? Boleslaw isn't even on cc!

Will

>  drivers/perf/arm-ccn.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> index 7dd850e02f19..b6e00f35a448 100644
> --- a/drivers/perf/arm-ccn.c
> +++ b/drivers/perf/arm-ccn.c
> @@ -1545,6 +1545,7 @@ static int arm_ccn_remove(struct platform_device *pdev)
>  static const struct of_device_id arm_ccn_match[] = {
>         { .compatible = "arm,ccn-502", },
>         { .compatible = "arm,ccn-504", },
> +       { .compatible = "arm,ccn-512", },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, arm_ccn_match);
