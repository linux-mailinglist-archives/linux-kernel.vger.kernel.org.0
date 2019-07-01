Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B858E1A9E2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 03:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfELBWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 21:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfELBWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:22:10 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92AFC2146F;
        Sun, 12 May 2019 01:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557624129;
        bh=5ZGZfSMt7JWFTmyD6eRpM78FKp9+Qug/MsjKRQtK8hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C6nDma1n8GEgfCgkDYhNrFm4VESoKik0IiYhT6nrTkYITtJ/RBk82j1qQoTNGWHX3
         qb28uTaxeDZUxLqhEliMRoa/RWthK3dHxJBI0+0xjLItPO3Jg4dv8p7U+KyRyAQaqy
         9ndIO+XjvD2Dk/bbGVIsk6y3fMqYeeXflapdCPK0=
Date:   Sun, 12 May 2019 09:21:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de, aisheng.dong@nxp.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, Anson.Huang@nxp.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] soc: imx: Fix build error without CONFIG_SOC_BUS
Message-ID: <20190512012134.GL15856@dragon>
References: <20190424075946.23124-1-yuehaibing@huawei.com>
 <20190424091517.41428-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424091517.41428-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 05:15:17PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> During randconfig builds, I occasionally run into an invalid configuration
> 
> drivers/soc/imx/soc-imx8.o: In function `imx8_soc_init':
> soc-imx8.c:(.init.text+0x144): undefined reference to `soc_device_register'
> 
> while CONFIG_SOC_BUS is not set, the building failed like this. This patch
> selects SOC_BUS to fix it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: a7e26f356ca1 ("soc: imx: Add generic i.MX8 SoC driver")
> Suggested-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: select SOC_BUS from CONFIG_ARCH_MXC directly
> ---

So this becomes a 'arm64: imx: ' change.  I updated the subject prefix
and applied the patch.

Shawn
