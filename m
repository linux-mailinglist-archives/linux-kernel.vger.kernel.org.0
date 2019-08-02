Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF21A802D5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 00:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbfHBWfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 18:35:50 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36286 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbfHBWfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:35:50 -0400
Received: from p508fd160.dip0.t-ipconnect.de ([80.143.209.96] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1htg9I-0005Md-SO; Sat, 03 Aug 2019 00:35:45 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] ARM: dts: rockchip: Add pin names for rk3288-veyron fievel
Date:   Sat, 03 Aug 2019 00:35:42 +0200
Message-ID: <4665278.n1QAv4Vui5@phil>
In-Reply-To: <20190801220354.142933-1-mka@chromium.org>
References: <20190801220354.142933-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 2. August 2019, 00:03:54 CEST schrieb Matthias Kaehlcke:
> This is like commit 0ca87bd5baa6 ("ARM: dts: rockchip: Add pin names
> for rk3288-veyron-jerry") and other similar commits, but for the
> veyron fievel board (and tiger, which includes the fievel .dtsi).
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

applied for 5.4

Thanks
Heiko


