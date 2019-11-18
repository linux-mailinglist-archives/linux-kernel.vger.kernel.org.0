Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B880FFC89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 01:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfKRAqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 19:46:50 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40098 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfKRAqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 19:46:50 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iWVBd-0003e6-2B; Mon, 18 Nov 2019 01:46:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Akash Gajjar <akash@openedev.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        matwey.kornilov@gmail.com
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enable PCIe for Radxa Rock Pi 4 board
Date:   Mon, 18 Nov 2019 01:46:36 +0100
Message-ID: <1784520.t1z2W423De@phil>
In-Reply-To: <20191117101545.6406-1-matwey@sai.msu.ru>
References: <20191117101545.6406-1-matwey@sai.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matwey,

Am Sonntag, 17. November 2019, 11:15:37 CET schrieb Matwey V. Kornilov:
> Radxa Rock Pi 4 is equipped with M.2 PCIe slot,
> so enable PCIe for the board.
> 
> The changes has been tested with Intel SSD 660p series device.
> 
>     01:00.0 Class 0108: Device 8086:f1a8 (rev 03)
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>

applied the patch, but you could do a follow-up that mimics
https://lore.kernel.org/linux-arm-kernel/20191117140728.917-1-linux.amoon@gmail.com/

aka find out from the schematics where the 0.9 and 1.8 supplies come from.

Thanks
Heiko


