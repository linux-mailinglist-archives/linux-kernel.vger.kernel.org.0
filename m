Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 420265740E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 00:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfFZWDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 18:03:04 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56496 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZWDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:03:04 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hgG0K-0004LZ-Dc; Thu, 27 Jun 2019 00:03:00 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Pavel Machek <pavel@ucw.cz>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] Revert "ARM: dts: rockchip: set PWM delay backlight settings for Minnie"
Date:   Thu, 27 Jun 2019 00:02:59 +0200
Message-ID: <2109910.Z3vxzrnhVQ@phil>
In-Reply-To: <20190618184531.1137-1-mka@chromium.org>
References: <20190618184531.1137-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 18. Juni 2019, 20:45:31 CEST schrieb Matthias Kaehlcke:
> This reverts commit 288ceb85b505c19abe1895df068dda5ed20cf482.
> 
> The commit assumes that the minnie panel is a AUO B101EAN01.1 (LVDS
> interface), however it is a AUO B101EAN01.8 (eDP interface). The eDP
> panel doesn't need the 200 ms delay.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied for 5.3

Thanks
Heiko


