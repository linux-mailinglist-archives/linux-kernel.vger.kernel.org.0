Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F061BEB262
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 15:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfJaOXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 10:23:11 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38254 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfJaOXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:23:11 -0400
Received: from dhcp-64-28.ens-lyon.fr ([140.77.64.28] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iQBLt-0005nA-Pi; Thu, 31 Oct 2019 15:23:05 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add vcc_sys enable pin on rk3399-roc-pc
Date:   Thu, 31 Oct 2019 15:23:04 +0100
Message-ID: <6903568.7J3coomyo0@phil>
In-Reply-To: <c72db0ad-c261-af4f-efe6-22bbcf4a0b7b@fivetechno.de>
References: <c72db0ad-c261-af4f-efe6-22bbcf4a0b7b@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 31. Oktober 2019, 09:51:56 CET schrieb Markus Reichl:
> rk3399-roc-pc has vcc_sys 5V supply for USB and other peripherals.
> Add the GPIO pin to enable the regulator.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>

applied for 5.5


