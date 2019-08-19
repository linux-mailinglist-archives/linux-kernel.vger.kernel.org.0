Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533CE921D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 13:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfHSLG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 07:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfHSLG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:06:59 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 449C720844;
        Mon, 19 Aug 2019 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566212818;
        bh=FTtPghP4JhraCtk0Ky8Cw09VOBcrHb9sW6Gmu2Y9IbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kcw+WeObE43jKg5SXlqiybEn0zF6OT4mLmNoQJl6smmrg721oVFWfcWYAMMlKDUui
         H6tKRaaWRYSmIOxjPPTS5kQE0XJgqpr/iRMi7efCwK5TDqdy+ecK7/3qJA5U+t5nsq
         5avA7J9KEAcbb9vOoOeHuh85ZbfxvAuOv8pyL9fo=
Date:   Mon, 19 Aug 2019 13:06:46 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 02/21] ARM: dts: imx7-colibri: disable HS400
Message-ID: <20190819110645.GL5999@X250>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-3-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812142105.1995-3-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:21:17PM +0000, Philippe Schenker wrote:
> From: Stefan Agner <stefan.agner@toradex.com>
> 
> Force HS200 by masking bit 63 of the SDHCI capability register.
> The i.MX ESDHC driver uses SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400. With
> that the stack checks bit 63 to descide whether HS400 is available.
> Using sdhci-caps-mask allows to mask bit 63. The stack then selects
> HS200 as operating mode.
> 
> This prevents rare communication errors with minimal effect on
> performance:
> 	sdhci-esdhc-imx 30b60000.usdhc: warning! HS400 strobe DLL
> 		status REF not lock!
> 
> Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Applied, thanks.
