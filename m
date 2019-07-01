Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39326356B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 08:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFEGP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 02:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfFEGP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:15:29 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7528720673;
        Wed,  5 Jun 2019 06:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559715328;
        bh=vj0fFfzdCOMls6GQVlEHz6y/BCRJKDroJegL7QI4CL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwgU8DqD8UACR2n3eeozRuAzxl+1PJwElQg71iMelgD8veLbyjGZSbOPyca5XKcE7
         GuMDGRum0vE8deBmWBMWg4kqhtcvQvzaogxlUkwR4awAOH+TpucgL1b5qmuxXKL8dx
         ePkxmvmQzXQQr4IZXcsAh9hkJYtQXA/G9duTS8x0=
Date:   Wed, 5 Jun 2019 14:15:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, van.freenix@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH V3 RESEND AGAIN 1/2] defconfig: arm64: enable i.MX8 SCU
 octop driver
Message-ID: <20190605061508.GD29853@dragon>
References: <20190524063913.44171-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524063913.44171-1-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 02:39:12PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Build in CONFIG_NVMEM_IMX_OCOTP_SCU.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied both, thanks.
