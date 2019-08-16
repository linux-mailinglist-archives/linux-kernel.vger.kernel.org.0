Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E67901D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 14:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfHPMmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 08:42:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60334 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfHPMmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:42:20 -0400
Received: from [88.128.80.55] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hybYc-0000bE-J7; Fri, 16 Aug 2019 14:42:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Andy Yan <andyshrk@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add dts for Leez RK3399 P710 SBC
Date:   Fri, 16 Aug 2019 14:42:01 +0200
Message-ID: <2387554.nTnFO2ePRC@phil>
In-Reply-To: <20190805124037.10597-1-andyshrk@gmail.com>
References: <20190805124037.10597-1-andyshrk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 5. August 2019, 14:40:37 CEST schrieb Andy Yan:
> P710 is a RK3399 based SBC, designed by Leez [0].
> 
> Specification
> - Rockchip RK3399
> - 4/2GB LPDDR4
> - TF sd scard slot
> - eMMC
> - M.2 B-Key for 4G LTE
> - AP6256 for WiFi + BT
> - Gigabit ethernet
> - HDMI out
> - 40 pin header
> - USB 2.0 x 2
> - USB 3.0 x 1
> - USB 3.0 Type-C x 1
> - TYPE-C Power supply
> 
> [0]https://leez.lenovo.com
> 
> Signed-off-by: Andy Yan <andyshrk@gmail.com>

applied for 5.4 - I did correct the alphabetical sorting a tiny bit though.

Thanks
Heiko


