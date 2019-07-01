Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC8E573FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 00:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfFZWAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 18:00:01 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56434 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZWAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:00:01 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hgFxO-0004KW-UC; Wed, 26 Jun 2019 23:59:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-rockchip@lists.infradead.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: Configure BT_DEV_WAKE in on rk3288-veyron
Date:   Wed, 26 Jun 2019 23:59:58 +0200
Message-ID: <1962605.yMxvVRIssp@phil>
In-Reply-To: <20190619183425.149470-1-dianders@chromium.org>
References: <20190619183425.149470-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 19. Juni 2019, 20:34:25 CEST schrieb Douglas Anderson:
> This is the other half of the hacky solution from commit f497ab6b4bb8
> ("ARM: dts: rockchip: Configure BT_HOST_WAKE as wake-up signal on
> veyron").  Specifically the LPM driver that the Broadcom Bluetooth
> expects to have (but is missing in mainline) has two halves of the
> equation: BT_HOST_WAKE and BT_DEV_WAKE.  The BT_HOST_WAKE (which was
> handled in the previous commit) is the one that lets the Bluetooth
> wake the system up.  The BT_DEV_WAKE (this patch) tells the Bluetooth
> that it's OK to go into a low power mode.  That means we were burning
> a bit of extra power in S3 without this patch.  Measurements are a bit
> noisy, but it appears to be a few mA worth of difference.
> 
> NOTE: Though these pins don't do much on systems with Marvell
> Bluetooth, downstream kernels set it on all veyron boards so we'll do
> the same.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.3

Thanks
Heiko


