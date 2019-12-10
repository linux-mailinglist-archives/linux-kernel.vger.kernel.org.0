Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9E1185A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 11:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfLJK6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 05:58:24 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:39669 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJK6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:58:24 -0500
Received: from localhost (136.112.broadband15.iol.cz [90.182.112.136])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 583F310000D;
        Tue, 10 Dec 2019 10:58:22 +0000 (UTC)
Date:   Tue, 10 Dec 2019 11:58:19 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: at91: sama5d27_som1_ek: add the
 microchip,sdcal-inverted on sdmmc0
Message-ID: <20191210105819.GG1463890@piout.net>
References: <20191205113604.9000-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205113604.9000-1-nicolas.ferre@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2019 12:36:04+0100, Nicolas Ferre wrote:
> Specify the SoC SDCAL pin connection that is used in the
> sama5d27c 128MiB SiP on the SAMA5D27 SOM1.
> This will put in place a software workaround that would reduce power
> consumption on all boards using this SoM, including the SAMA5D27 SOM1 EK.
> 
> Uses property introduced in 5cd41fe89704 ("dt-bindings: sdhci-of-at91:
> add the microchip,sdcal-inverted property")
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d27_som1.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
