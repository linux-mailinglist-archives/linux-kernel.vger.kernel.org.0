Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404F11353D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 08:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgAIHqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 02:46:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbgAIHqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:46:38 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1253D2067D;
        Thu,  9 Jan 2020 07:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578555998;
        bh=5kEr0u1VL0RVCwXJ5D5DyrjSAR6ubRRHXNB3Tn2+kUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=My95OLCIH3fNhtG/BT0QDkUNPENm7oe3ZmqkqBp1nwT+apxm9rLhSq720X9s5RyL5
         Ovh9k4XKwK5HCWjdTVYv85CnIVdM4XdEVjy1hHHF7q05AzdMjLZwCPLN7TLObkRX0C
         CNsws39nqA9qFIV5jEcOJOMcYtoAzyZP6gxfWZQQ=
Date:   Thu, 9 Jan 2020 15:46:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH v2 1/3] ARM: dts: imx6q-icore-mipi: Use 1.5 version of
 i.Core MX6DL
Message-ID: <20200109074625.GE4456@T480>
References: <20191230120021.32630-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230120021.32630-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 05:30:19PM +0530, Jagan Teki wrote:
> The EDIMM STARTER KIT i.Core 1.5 MIPI Evaluation is based on
> the 1.5 version of the i.Core MX6 cpu module. The 1.5 version
> differs from the original one for a few details, including the
> ethernet PHY interface clock provider.
> 
> With this commit, the ethernet interface works properly:
> SMSC LAN8710/LAN8720 2188000.ethernet-1:00: attached PHY driver
> 
> While before using the 1.5 version, ethernet failed to startup
> do to un-clocked PHY interface:
> fec 2188000.ethernet eth0: could not attach to PHY
> 
> Similar fix has merged for i.Core MX6Q but missed to update for DL.
> 
> Fixes: a8039f2dd089 ("ARM: dts: imx6dl: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit support")
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied all 3, thanks.
