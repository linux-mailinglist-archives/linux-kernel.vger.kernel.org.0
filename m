Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8F1117B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 00:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLIXnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 18:43:08 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51307 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfLIXnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:43:07 -0500
X-Originating-IP: 195.39.63.77
Received: from localhost (unknown [195.39.63.77])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A3F3EE0003;
        Mon,  9 Dec 2019 23:43:04 +0000 (UTC)
Date:   Tue, 10 Dec 2019 00:43:02 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        nicolas.ferre@microchip.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, claudiu.beznea@microchip.com,
        Eugen.Hristev@microchip.com
Subject: Re: [PATCH v4 3/3] ARM: dts: at91: sama5d2: set the sdmmc gclk
 frequency
Message-ID: <20191209234302.GC1463890@piout.net>
References: <20191128074522.69706-1-ludovic.desroches@microchip.com>
 <20191128074522.69706-3-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128074522.69706-3-ludovic.desroches@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2019 08:45:22+0100, Ludovic Desroches wrote:
> Set the frequency of the generated clock used by sdmmc devices in order
> to not rely on the configuration done by previous components.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
> 
> Changes:
> - v4: none
> - v3: none
> - v2: none
> 
>  arch/arm/boot/dts/sama5d2.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
