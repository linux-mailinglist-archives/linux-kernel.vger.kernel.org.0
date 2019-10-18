Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C16DCEE5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 21:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436517AbfJRTBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 15:01:44 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53184 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394242AbfJRTBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 15:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=d5loDZDyZ3FGWYtEc80UdkQmNImMULENPQ9QfLtUGRg=; b=rohR03I0mjEhdQm+mVizrZXUcT
        6W416mpGZ9nVFI3EDKraNP+jAOcICWeAI5pbK+etYJTrcnFKW/fPyymxFSQpqNUx/PP9F/fJwgEpq
        qf7k/dUQApFWZyGkRfmdPxwnnnLLCwQ1AqHNSziUwD88/9Ui8cSAJa3C+whKGOqPXsDY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iLXVH-0002mg-8F; Fri, 18 Oct 2019 21:01:35 +0200
Date:   Fri, 18 Oct 2019 21:01:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 6/6] ARM: orion: unify Makefile/Kconfig files
Message-ID: <20191018190135.GF24810@lunn.ch>
References: <20191018163047.1284736-1-arnd@arndb.de>
 <20191018163047.1284736-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018163047.1284736-6-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 06:29:19PM +0200, Arnd Bergmann wrote:
> +config MACH_TERASTATION_WXL
> +	bool "Buffalo WLX (Terastation Duo) NAS"
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  Buffalo WXL Nas.
> +
> +endif
> +
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig ARCH_ORION5X
> +	bool "Marvell Orion"
> +	depends on MMU && ARCH_MULTI_V5
> +	select CPU_FEROCEON
> +	select GENERIC_CLOCKEVENTS
> +	select FORCE_PCI
> +	select PHYLIB if NETDEVICES
> +	select PLAT_ORION_LEGACY
> +	help
> +	  Support for the following Marvell Orion 5x series SoCs:
> +	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
> +	  Orion-2 (5281), Orion-1-90 (6183).

Hi Arnd

I don't think this SPDX line should be in the middle of the file?

  Andrew
