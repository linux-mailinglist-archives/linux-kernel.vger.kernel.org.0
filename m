Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEFB9113E73
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 10:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfLEJop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 04:44:45 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:36583 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbfLEJom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:44:42 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-1-1480-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5919DC0006;
        Thu,  5 Dec 2019 09:44:40 +0000 (UTC)
Date:   Thu, 5 Dec 2019 10:44:37 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen.Hristev@microchip.com
Cc:     Ludovic.Desroches@microchip.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: at91: sama5d27_som1_ek: add i2c filters
 properties
Message-ID: <20191205094437.GS909634@piout.net>
References: <1575531818-21332-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575531818-21332-1-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2019 07:43:59+0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Add properties for i2c filters for i2c0 and i2c1 on sama5d27_som1_ek.
> Noise is affecting communication on i2c for example when connecting i2c
> camera sensors.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> 
> Changes in v2:
> - properties were at the wrong node for i2c0, need to be at the i2c node
> not the parent flexcom
> 
>  arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
