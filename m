Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12AB815B727
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 03:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgBMCa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 21:30:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:32818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbgBMCa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 21:30:59 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18AF220724;
        Thu, 13 Feb 2020 02:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581561058;
        bh=QoxejkUX9cQpbXXJUB/sdxVS47Tv5T5Z/rZUhXSmJy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2aVKd3PGsMLbe0eIphnWxs0c0iK+tGFcAabqqygjIKnrjAhQE6QT9xv7X+4zdV9W
         bn9CpPUaGMbf6tJIkBmrV51vNeBb2UamoZcx4qutZZn7JrPAYdiyRMCv9t/lmKkzSz
         2CYvoHfFbKlYnfsPk1w2fjHdezgtoilpjfYUiVxk=
Date:   Thu, 13 Feb 2020 10:30:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Mihaela Martinas <Mihaela.Martinas@freescale.com>,
        Dan Nica <dan.nica@nxp.com>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: freescale: s32v234: use generic name bus
Message-ID: <20200213023051.GJ11096@dragon>
References: <1579156408-23739-1-git-send-email-peng.fan@nxp.com>
 <1579156408-23739-3-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579156408-23739-3-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 06:38:03AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per devicetree specification, generic names are recommended
> to be used, such as bus.
> 
> AIPS is a AHB - IP bridge bus, so we could use bus as node name.
> 
> Script:
> sed -i "s/\<aips@/bus@/" arch/arm64/boot/dts/freescale/*.dtsi
> sed -i "s/\<aips-bus@/bus@/" arch/arm64/boot/freescale/*.dtsi
> 
> Cc: Phu Luu An <phu.luuan@nxp.com>
> Cc: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Cc: Mihaela Martinas <Mihaela.Martinas@freescale.com>
> Cc: Dan Nica <dan.nica@nxp.com>
> Cc: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
