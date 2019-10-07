Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB6C4CE10A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 13:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfJGL6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 07:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfJGL6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:58:45 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86EB8206C0;
        Mon,  7 Oct 2019 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570449524;
        bh=GzSOhDMJlVu7OkhBW0yc3aY0l4AKWtm9aeth+tDDsbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=reGfga5iHUnq499Iq95gCUW5qoDjH6oOPCpvTembWtg0OQ3dbvFUfEzPKLSZbxDxU
         5kZkULEjku0e4MIrdWCH12tZb9Fyw8imyQ/WF0l6eFZB3GJFHr+Keb3UCNHv9i2Nzi
         Xk/Jg4TP9bW4GoqCDl/4fStZjaqTr56gU/MQILvM=
Date:   Mon, 7 Oct 2019 19:58:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, Jun Nie <jun.nie@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH] ARM: zx: Use devm_platform_ioremap_resource() in
 zx296702_pd_probe()
Message-ID: <20191007115822.GH7150@dragon>
References: <30b6c588-6c4b-c8ff-6414-a3fc53867bfe@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b6c588-6c4b-c8ff-6414-a3fc53867bfe@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 07:57:05AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 07:40:26 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Shawn Guo <shawnguo@kernel.org>

@Arnd, can you please help apply it to arm-soc tree?

Shawn

> ---
>  arch/arm/mach-zx/zx296702-pm-domain.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-zx/zx296702-pm-domain.c b/arch/arm/mach-zx/zx296702-pm-domain.c
> index 7a08bf9dd792..ba4f556b7a13 100644
> --- a/arch/arm/mach-zx/zx296702-pm-domain.c
> +++ b/arch/arm/mach-zx/zx296702-pm-domain.c
> @@ -152,7 +152,6 @@ static struct generic_pm_domain *zx296702_pm_domains[] = {
>  static int zx296702_pd_probe(struct platform_device *pdev)
>  {
>  	struct genpd_onecell_data *genpd_data;
> -	struct resource *res;
>  	int i;
> 
>  	genpd_data = devm_kzalloc(&pdev->dev, sizeof(*genpd_data), GFP_KERNEL);
> @@ -161,14 +160,7 @@ static int zx296702_pd_probe(struct platform_device *pdev)
> 
>  	genpd_data->domains = zx296702_pm_domains;
>  	genpd_data->num_domains = ARRAY_SIZE(zx296702_pm_domains);
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "no memory resource defined\n");
> -		return -ENODEV;
> -	}
> -
> -	pcubase = devm_ioremap_resource(&pdev->dev, res);
> +	pcubase = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pcubase)) {
>  		dev_err(&pdev->dev, "ioremap fail.\n");
>  		return -EIO;
> --
> 2.23.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
