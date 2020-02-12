Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86BEB15B38D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 23:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgBLWYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 17:24:36 -0500
Received: from gloria.sntech.de ([185.11.138.130]:39170 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbgBLWYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:24:35 -0500
Received: from p508fd8fe.dip0.t-ipconnect.de ([80.143.216.254] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j20Qj-0001sJ-So; Wed, 12 Feb 2020 23:24:25 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alexis Ballier <aballier@gentoo.org>
Cc:     devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rk3399-orangepi: Add ethernet phy.
Date:   Wed, 12 Feb 2020 23:24:25 +0100
Message-ID: <4035287.ZI63WRSm04@phil>
In-Reply-To: <20200206151025.3813-1-aballier@gentoo.org>
References: <20200206151025.3813-1-aballier@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 6. Februar 2020, 16:10:24 CET schrieb Alexis Ballier:
> Enables INTB.
> The wiring is the same as the nanopi4, so this is heavily based on:
> - [1a4e6203f0c] arm64: dts: rockchip: Add nanopi4 ethernet phy
> - [bc43cee88aa] arm64: dts: rockchip: Update nanopi4 phy reset properties
> by Robin Murphy.
> 
> Signed-off-by: Alexis Ballier <aballier@gentoo.org>
> Cc: devicetree@vger.kernel.org
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

applied both for 5.7

Thanks
Heiko


