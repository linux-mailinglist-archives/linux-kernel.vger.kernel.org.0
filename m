Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 418EA15B393
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 23:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgBLWZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 17:25:03 -0500
Received: from gloria.sntech.de ([185.11.138.130]:39208 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgBLWZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:25:02 -0500
Received: from p508fd8fe.dip0.t-ipconnect.de ([80.143.216.254] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j20RG-0001sh-MZ; Wed, 12 Feb 2020 23:24:58 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        dafna.hirschfeld@collabora.com,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rk3399: Remove extcon unit address and extcon-cells from Gru
Date:   Wed, 12 Feb 2020 23:24:58 +0100
Message-ID: <3531662.p2XxmjTmOT@phil>
In-Reply-To: <20200207141324.3188898-1-enric.balletbo@collabora.com>
References: <20200207141324.3188898-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 7. Februar 2020, 15:13:24 CET schrieb Enric Balletbo i Serra:
> The cros-ec-extcon has no reg property so remove the unit address from
> the DT node to make DT compiler happy.
> 
> While here, remove the inexistent extcon-cells property from the extcon
> nodes.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied for 5.7

Thanks
Heiko


