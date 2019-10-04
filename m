Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D871BCC3DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbfJDUEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 16:04:15 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37430 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730989AbfJDUEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:04:15 -0400
Received: from 94.112.246.102.static.b2b.upcbusiness.cz ([94.112.246.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iGToC-0006Up-Gs; Fri, 04 Oct 2019 22:04:12 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Soeren Moch <smoch@web.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: fix RockPro64 vdd-log regulator settings
Date:   Fri, 04 Oct 2019 22:04:11 +0200
Message-ID: <3200327.mLoWUYiBOS@phil>
In-Reply-To: <20191003215036.15023-1-smoch@web.de>
References: <20191003215036.15023-1-smoch@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 3. Oktober 2019, 23:50:34 CEST schrieb Soeren Moch:
> The RockPro64 schematic [1] page 18 states a min voltage of 0.8V and a
> max voltage of 1.4V for the VDD_LOG pwm regulator. However, there is an
> additional note that the pwm parameter needs to be modified.
> From the schematics a voltage range of 0.8V to 1.7V can be calculated.
> Additional voltage measurements on the board show that this fix indeed
> leads to the correct voltage, while without this fix the voltage was set
> too high.
> 
> [1] http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
> 
> Fixes: e4f3fb490967 ("arm64: dts: rockchip: add initial dts support for Rockpro64")
> Signed-off-by: Soeren Moch <smoch@web.de>

applied as fix  for 5.4

Thanks for going that extra mile with all the calculations and measurements
Heiko


