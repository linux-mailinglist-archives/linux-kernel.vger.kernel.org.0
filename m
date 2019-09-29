Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36656C193D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 21:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfI2T6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 15:58:44 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45446 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfI2T6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 15:58:43 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iEfL3-0001Hr-2j; Sun, 29 Sep 2019 21:58:37 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Hugh Cole-Baker <sigmaris@gmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix Rockpro64 RK808 interrupt line
Date:   Sun, 29 Sep 2019 21:58:36 +0200
Message-ID: <2631784.KOmX0qhJ1H@phil>
In-Reply-To: <20190921131457.36258-1-sigmaris@gmail.com>
References: <20190921131457.36258-1-sigmaris@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 21. September 2019, 15:14:57 CEST schrieb Hugh Cole-Baker:
> Fix the pinctrl and interrupt specifier for RK808 to use GPIO3_B2. On the
> Rockpro64 schematic [1] page 16, it shows GPIO3_B2 used for the interrupt
> line PMIC_INT_L from the RK808, and there's a note which translates as:
> "PMU termination GPIO1_C5 changed to this".
> 
> Tested by setting an RTC wakealarm and checking /proc/interrupts counters.
> Without this patch, neither the rockchip_gpio_irq counter for the RK808,
> nor the RTC alarm counter increment when the alarm time is reached.
> With this patch, both interrupt counters increment by 1 as expected.
> 
> [1] http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
> 
> Fixes: e4f3fb4 ("arm64: dts: rockchip: add initial dts support for Rockpro64")
> Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>

applied as fix for 5.4

Thanks
Heiko


