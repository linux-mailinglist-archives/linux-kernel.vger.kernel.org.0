Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF31876CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 01:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbgCQA00 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Mar 2020 20:26:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51470 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733009AbgCQA00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:26:26 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jE03p-0004NN-Kj; Tue, 17 Mar 2020 01:26:21 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: use DMA channels for UARTs for RK3288
Date:   Tue, 17 Mar 2020 01:26:21 +0100
Message-ID: <2031112.Bdp2p14rd6@phil>
In-Reply-To: <20200315095115.10106-1-katsuhiro@katsuster.net>
References: <20200315095115.10106-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 15. März 2020, 10:51:15 CET schrieb Katsuhiro Suzuki:
> This patch enables to use DMAC for all UARTs that are connected to
> dmac_peri core for Rochchip RK3288.
> 
> Only uart2 is connected different DMAC (dmac_bus_s) so keep current
> settings on this patch.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

applied for 5.7

Thanks
Heiko


