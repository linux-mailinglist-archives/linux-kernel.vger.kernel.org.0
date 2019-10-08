Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7E8CF69A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 11:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfJHJ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 05:57:35 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46001 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbfJHJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:57:35 -0400
X-Originating-IP: 2.139.156.91
Received: from localhost (91.red-2-139-156.staticip.rima-tde.net [2.139.156.91])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B0FC8E0005;
        Tue,  8 Oct 2019 09:57:29 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] ARM: dts: SDRAM and L2 cache EDAC for Armada SoCs
In-Reply-To: <20190926232820.27676-1-chris.packham@alliedtelesis.co.nz>
References: <20190926232820.27676-1-chris.packham@alliedtelesis.co.nz>
Date:   Tue, 08 Oct 2019 11:57:27 +0200
Message-ID: <87ftk3tv94.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

> This series was waiting for the armada_xp edac driver to be accepted.
> Now that it has the relevant nodes can be added to the Armada SoCs. So
> that boards can use the EDAC driver if they have the hardware support.
>
> The db-xc3-24g4xg.dts board doesn't have an ECC chip for it's DDR but it
> can use the L2 cache parity and ecc support.
>
> Chris Packham (3):
>   ARM: dts: armada-xp: enable L2 cache parity and ecc on db-xc3-24g4xg
>   ARM: dts: mvebu: add sdram controller node to Armada-38x
>   ARM: dts: armada-xp: add label to sdram-controller node

Series applied on mvebu/dt

Thanks,

Gregory


>
>  arch/arm/boot/dts/armada-38x.dtsi             | 5 +++++
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi     | 2 +-
>  arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 5 +++++
>  arch/arm/boot/dts/armada-xp.dtsi              | 2 +-
>  4 files changed, 12 insertions(+), 2 deletions(-)
>
> -- 
> 2.23.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
