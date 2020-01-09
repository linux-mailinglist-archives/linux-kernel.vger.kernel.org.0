Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6C413575D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 11:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgAIKs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 05:48:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbgAIKs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:48:57 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7688D2067D;
        Thu,  9 Jan 2020 10:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578566936;
        bh=5kjb4RoCfMIaDZCVnC/sXJA7vuX0Fa/Imd5LZVK+Nn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9wUrSCV2mkeS2OiIkXfip54plZvxVLGk2MZmBPamu9qbuk+vo3JJstzZhZC/geNM
         RE2SE78G4pCdk4k+JJIQPEFGnl+N1G+G9p8n1dAjPO6V0przfF4sVN7Nn8kiye6r73
         HIhSZALp6BYOdxRh6VBT1h+fL85B99xe+zHbalkI=
Date:   Thu, 9 Jan 2020 18:48:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: only select ARM_ERRATA_814220 for ARMv7-A
Message-ID: <20200109104847.GS4456@T480>
References: <20200107215157.1450319-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107215157.1450319-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:51:39PM +0100, Arnd Bergmann wrote:
> i.MX7D is supported for either the v7-A or the v7-M cores,
> but the latter causes a warning:
> 
> WARNING: unmet direct dependencies detected for ARM_ERRATA_814220
>   Depends on [n]: CPU_V7 [=n]
>   Selected by [y]:
>   - SOC_IMX7D [=y] && ARCH_MXC [=y] && (ARCH_MULTI_V7 [=n] || ARM_SINGLE_ARMV7M [=y])
> 
> Make the select statement conditional.
> 
> Fixes: 4562fa4c86c9 ("ARM: imx: Enable ARM_ERRATA_814220 for i.MX6UL and i.MX7D")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
