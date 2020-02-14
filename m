Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0468215D069
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 04:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgBNDY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 22:24:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgBNDY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:24:59 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF54A20661;
        Fri, 14 Feb 2020 03:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581650698;
        bh=C4d3u4P4SxRBpz+KVKAg2h2CnWcFdIXxufDHNWpDis8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3jMcbHLiUA5WebMf+c5VVI5tNEilMYBPycXZIU9ui8l6Y4hykT/4zbxRH55Z7mQa
         w0p2kPxFbyGoy/NxfFgI8HGSEhL0z9aB10vhPHVm0+odzb8fDPFTZsDRvdRD6/UWzI
         6NKPYJDJ2+Mn5tqOguSDK+no3ceAjApbspvk5pbY=
Date:   Fri, 14 Feb 2020 11:24:50 +0800
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
Subject: Re: [PATCH v3 05/12] ARM: dts: imx7d: cl-som-imx7: update pfuze3000
 max voltage
Message-ID: <20200214032449.GN22842@dragon>
References: <20200131083638.6118-1-git@andred.net>
 <20200131083638.6118-5-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200131083638.6118-5-git@andred.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:36:31AM +0000, Andr� Draszik wrote:
> The max voltage of SW1A is 3.3V on PF3000 as per
> http://cache.freescale.com/files/analog/doc/data_sheet/PF3000.pdf?fsrch=1&sr=1&pageNum=1
> 
> While at it, remove the unnecessary leading zero from
> the i2c address.
> 
> Signed-off-by: Andr� Draszik <git@andred.net>

Applied, thanks.
