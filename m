Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53772E6D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 08:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbfJ1H5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 03:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733079AbfJ1H5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:57:03 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A96620650;
        Mon, 28 Oct 2019 07:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572249423;
        bh=7WSAwIvIMmCnPFbnYVFD8qYwityLxzs0vjC/ubdcMoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gx3AXM/ir5pciLBeAaR22OBYiMfLES8rhG0Iv3VHtB96zQoTXZS3w1aCpbsvSN8e5
         ky/KDRl2xKeD+GUeARJYhc5rbRRRlQqhTDfskXucyXRD/4nBjXhB1w1ETnyBRYz8XK
         w+YvPKXqQnWo2HIIsMdnRQ2zoAYX1HEbk5uxsoYc=
Date:   Mon, 28 Oct 2019 15:56:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rogerio Pimentel da Silva <rpimentel.silva@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq-evk: Add remote control
Message-ID: <20191028075638.GS16985@dragon>
References: <20191022192038.30094-1-rpimentel.silva@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022192038.30094-1-rpimentel.silva@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:20:34PM -0300, Rogerio Pimentel da Silva wrote:
> Add remote control to i.MX8M EVK device tree.
> 
> The rc protocol must be selected by writing to:
> /sys/devices/platform/ir-receiver/rc/rc0/protocols
> 
> On my tests, I used "nec" rc protocol:
> echo nec > protocols
> 
> Tested using evetest:
> evtest /dev/input/event0
> 
> Output log for each key pressed:
> Event: 
> time 1568122608.267845, -------------- SYN_REPORT ------------
> Event: 
> time 1568122610.503835, type 4 (EV_MSC), code 4 (MSC_SCAN), value 440
> 
> Signed-off-by: Rogerio Pimentel da Silva <rpimentel.silva@gmail.com>

Applied, thanks.
