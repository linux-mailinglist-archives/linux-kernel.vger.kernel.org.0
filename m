Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F9891E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 09:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfHSHvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 03:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHSHvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:51:35 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 119D92082C;
        Mon, 19 Aug 2019 07:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566201094;
        bh=YYr+sOzCSeA4C3uJqftbtG0MGcaU4L5Jif35BaA4Eeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XkPMjR9kuQYoRQFea2vw8zhFvepVrwta4FDt0MBDl3vuCiPOXC9CX+uxyms8h9ObM
         lVnSTdfyABWFjGSXGqiaA7jEMJha02Ui/xq8ZZldXeCRmhMMnlHr8KDrN1Yxy+kBPk
         P3spAEPt2fVETl5G5eZQoUISn2kecFpSHI+5s3Zs=
Date:   Mon, 19 Aug 2019 09:51:22 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
Cc:     linux-kernel@vger.kernel.org, Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx7d: cl-som-imx7: make ethernet work again
Message-ID: <20190819075121.GE5999@X250>
References: <20190809031227.3319-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190809031227.3319-1-git@andred.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 04:12:27AM +0100, Andr� Draszik wrote:
> Recent changes to the atheros at803x driver caused
> ethernet to stop working on this board.
> In particular commit 6d4cd041f0af
> ("net: phy: at803x: disable delay only for RGMII mode")
> and commit cd28d1d6e52e
> ("net: phy: at803x: Disable phy delay for RGMII mode")
> fix the AR8031 driver to configure the phy's (RX/TX)
> delays as per the 'phy-mode' in the device tree.
> 
> This now prevents ethernet from working on this board.
> 
> It used to work before those commits, because the
> AR8031 comes out of reset with RX delay enabled, and
> the at803x driver didn't touch the delay configuration
> at all when "rgmii" mode was selected, and because
> arch/arm/mach-imx/mach-imx7d.c:ar8031_phy_fixup()
> unconditionally enables TX delay.
> 
> Since above commits ar8031_phy_fixup() also has no
> effect anymore, and the end-result is that all delays
> are disabled in the phy, no ethernet.
> 
> Update the device tree to restore functionality.
> 
> Signed-off-by: Andr� Draszik <git@andred.net>
> CC: Ilya Ledvich <ilya@compulab.co.il>
> CC: Igor Grinberg <grinberg@compulab.co.il>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Shawn Guo <shawnguo@kernel.org>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Pengutronix Kernel Team <kernel@pengutronix.de>
> CC: Fabio Estevam <festevam@gmail.com>
> CC: NXP Linux Team <linux-imx@nxp.com>
> CC: devicetree@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org

Applied, thanks.
