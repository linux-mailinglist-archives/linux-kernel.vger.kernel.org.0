Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706399056E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 18:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfHPQIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 12:08:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33322 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbfHPQIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:08:18 -0400
Received: from [88.128.80.55] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hyels-0001Qb-P9; Fri, 16 Aug 2019 18:08:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: add device tree for Mecer Xtreme Mini S6
Date:   Fri, 16 Aug 2019 18:07:45 +0200
Message-ID: <1853641.gZJFEyITmz@phil>
In-Reply-To: <20190811230015.28349-1-justin.swartz@risingedge.co.za>
References: <20190811230015.28349-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 12. August 2019, 01:00:13 CEST schrieb Justin Swartz:
> The Mecer Xtreme Mini S6 features a Rockchip RK3229 SoC,
> 1GB DDR3 RAM, 8GB eMMC, MicroSD port, 10/100Mbps Ethernet,
> Realtek 8723BS WLAN module, 2 x USB 2.0 ports, HDMI output,
> and S/PDIF output.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

applied for 5.4

Thanks
Heiko


