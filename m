Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 015ED91E51
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 09:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfHSHvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 03:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHSHvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:51:53 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECFAB2184E;
        Mon, 19 Aug 2019 07:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566201112;
        bh=2/vZ0TTiRM4QnAl22MZxwHQZvlNisoqFM1RJui0gC4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0B1qKbNH+o4DMmEwui7F3RpwvGKKc9/Lw1t8PYcSpKx+hDIRkEgWovjezQ+ySixZ/
         QlBIW8TQ7LQvIY7a1K2wavjZJ6C7W3CYncb8leNxGC7DVdI+Fm1U9JGu2QaA1rjpBO
         388CHZGw5plMGz82kCVv/3w3MilzMWp+3Y/3YkGU=
Date:   Mon, 19 Aug 2019 09:51:40 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: imx: stop adjusting ar8031 phy tx delay
Message-ID: <20190819075139.GF5999@X250>
References: <20190809031256.3594-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190809031256.3594-1-git@andred.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 04:12:56AM +0100, André Draszik wrote:
> Recent changes to the Atheros at803x driver cause
> the approach taken here to stop working because
> commit 6d4cd041f0af
> ("net: phy: at803x: disable delay only for RGMII mode")
> and commit cd28d1d6e52e
> ("net: phy: at803x: Disable phy delay for RGMII mode")
> fix the AR8031 driver to configure the phy's (RX/TX)
> delays as per the 'phy-mode' in the device tree.
> 
> In particular, the phy tx (and rx) delays are updated
> again as per the 'phy-mode' *after* the code in here
> runs.
> 
> Things worked before above commits, because the AR8031
> comes out of reset with RX delay enabled, and the
> at803x driver didn't touch the delay configuration at
> all when "rgmii" mode was selected.
> 
> It appears the code in here tries to make device
> trees work that incorrectly specify "rgmii", but
> that can't work any more and it is imperative since
> above commits to have the phy-mode configured
> correctly in the device tree.
> 
> I suspect there are a few imx7d based boards using
> the ar8031 phy and phy-mode = "rgmii", but given I
> don't know which ones exactly, I am not in a
> position to update the respective device trees.
> 
> Hence this patch is simply removing the superfluous
> code from the imx7d initialisation. An alternative
> could be to add a warning instead, but that would
> penalize all boards that have been updated already.
> 
> Signed-off-by: André Draszik <git@andred.net>
> CC: Russell King <linux@armlinux.org.uk>
> CC: Shawn Guo <shawnguo@kernel.org>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Pengutronix Kernel Team <kernel@pengutronix.de>
> CC: Fabio Estevam <festevam@gmail.com>
> CC: NXP Linux Team <linux-imx@nxp.com>
> CC: Kate Stewart <kstewart@linuxfoundation.org>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Leonard Crestez <leonard.crestez@nxp.com>
> CC: linux-arm-kernel@lists.infradead.org

Applied, thanks.
