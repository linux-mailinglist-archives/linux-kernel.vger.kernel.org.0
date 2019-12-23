Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 545E412912E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 04:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLWDm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 22:42:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfLWDmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 22:42:25 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73AAB206D3;
        Mon, 23 Dec 2019 03:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577072545;
        bh=Yg46ioICEVBd7BbNN2hthjUc0yGGjXqqdVRsXmzNJWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rcR4qRpPGXuaIIYO69wJZy4i5iKVOYQdaeOBFfrbilMyUH+50UsDwLRfSOmj41g0j
         C8Ux0UFqjivYQeY6yIw5knLssGpJ2DeM6J183rZBthoebU5589sTCDpgVTAaP45Rpr
         HHdpz7O2MQVcOstliUkJ+NVdhpqJJl2NEp2jNg5M=
Date:   Mon, 23 Dec 2019 11:42:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mm: Add missing mux options for UART1
 and UART2 signals
Message-ID: <20191223034201.GH11523@dragon>
References: <20191210141516.6983-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210141516.6983-1-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 02:15:17PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> According to the reference manual and the "Pins Tool" from NXP, the
> signals for UART1 and UART2 can be muxed to the SAI2 and SAI3 pads
> respectively. Let's add the missing options.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied, thanks.
