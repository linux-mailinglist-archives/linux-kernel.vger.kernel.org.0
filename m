Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFB515D027
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 03:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgBNCoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 21:44:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgBNCoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:44:21 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9797D20848;
        Fri, 14 Feb 2020 02:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581648261;
        bh=0UJhuKGAYdnYJjJ52HOZ9X/15LDeFbdp2hBicgTmaVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9J+IaR2ZlqMSergpAtvMx5N239+ofHV43GulsZx6GkYLH58wONeBrn2WtpLmxnGo
         YT2d0Uhg+ybB5lw8BDm97R9eOObCY/SRGTZmyaPbxYyS1hAsubEWAF6ecKzy2W8g7B
         0/Doij3rIBlo+cVimA5CvdOLqb1jz59M5EGwRx3A=
Date:   Fri, 14 Feb 2020 10:44:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 2/2] soc: imx: increase build coverage for imx8m soc
 driver
Message-ID: <20200214024414.GG22842@dragon>
References: <1580191098-5886-1-git-send-email-peng.fan@nxp.com>
 <1580191098-5886-3-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580191098-5886-3-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 06:03:17AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The soc-imx8.c driver is actually for i.MX8M family, so rename it
> to soc-imx8m.c.
> 
> Use CONFIG_SOC_IMX8M as build gate, not CONFIG_ARCH_MXC, to control
> whether build this driver, also make it possible for compile test.
> 
> Default set it to y for ARCH_MXC && ARM64
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
