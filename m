Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98CE521629
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 11:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfEQJWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 05:22:12 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60352 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfEQJWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:22:12 -0400
Received: from we0524.dip.tu-dresden.de ([141.76.178.12] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hRZ42-0001Ab-69; Fri, 17 May 2019 11:22:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add PCIe nodes on rk3399-rockpro64
Date:   Fri, 17 May 2019 11:22:05 +0200
Message-ID: <45858032.MVTSb7sYM0@phil>
In-Reply-To: <20190509170314.12806-1-katsuhiro@katsuster.net>
References: <20190509170314.12806-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 9. Mai 2019, 19:03:14 CEST schrieb Katsuhiro Suzuki:
> This patch adds PCIe, PCIe phy and pinctrl (for PERST#) nodes for
> RockPro64 board.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

applied for 5.3 after a bit of alphabetical sorting
- num-lanes above pinctrl properties
- pcie-perst above pcie-pwr-on pinctrl entry


Heiko


