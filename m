Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87384135000
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 00:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgAHXaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 18:30:12 -0500
Received: from gloria.sntech.de ([185.11.138.130]:50348 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgAHXaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 18:30:11 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ipKm5-0003V5-Tq; Thu, 09 Jan 2020 00:30:05 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] arm64: dts: rockchip: Enable mp8859 regulator on rk3399-roc-pc
Date:   Thu, 09 Jan 2020 00:30:05 +0100
Message-ID: <2818372.Uxc4pq5UrR@phil>
In-Reply-To: <20200106211633.2882-6-m.reichl@fivetechno.de>
References: <20200106211633.2882-1-m.reichl@fivetechno.de> <20200106211633.2882-6-m.reichl@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 6. Januar 2020, 22:16:28 CET schrieb Markus Reichl:
> The rk3399-roc-pc uses a MP8859 DC/DC converter for 12V supply.
> This supplies 5V only in default state after booting.
> Now we can control the output voltage via I2C interface.
> Add a node for the driver to reach 12V.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>

applied for 5.6 now that the driver-side got merged

Thanks
Heiko


