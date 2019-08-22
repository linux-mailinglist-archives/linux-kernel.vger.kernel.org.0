Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E27D9A02A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 21:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388670AbfHVTi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 15:38:58 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39068 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfHVTi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:38:58 -0400
Received: from wsip-184-188-36-2.sd.sd.cox.net ([184.188.36.2] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1i0sv7-0001tv-QT; Thu, 22 Aug 2019 21:38:54 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] arm64: dts: rockchip: add rk3328 VPU node
Date:   Thu, 22 Aug 2019 21:38:09 +0200
Message-ID: <13275867.8yMunGSYaK@phil>
In-Reply-To: <HE1PR06MB4011C8496657B2C267A66327ACAA0@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <HE1PR06MB4011C8496657B2C267A66327ACAA0@HE1PR06MB4011.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 21. August 2019, 19:54:38 CEST schrieb Jonas Karlman:
> This patch add a VPU device node for rk3328.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

applied for 5.4

I'm still not sure where your original patch went though. I can see it
in patchwork but somehow not in my inbox ... in any case, thanks for
resending.


Thanks
Heiko


