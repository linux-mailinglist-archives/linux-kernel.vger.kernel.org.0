Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCAFFFFC84
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 01:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfKRAm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 19:42:58 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40042 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfKRAm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 19:42:58 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iWV7z-0003d9-Ve; Mon, 18 Nov 2019 01:42:52 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add regulators for pcie on rk3399-rock960
Date:   Mon, 18 Nov 2019 01:42:50 +0100
Message-ID: <2743598.oTfX2hMREy@phil>
In-Reply-To: <20191117140728.917-1-linux.amoon@gmail.com>
References: <20191117140728.917-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 17. November 2019, 15:07:28 CET schrieb Anand Moon:
> As per Rock960 schematics add 0V9 and 1V8 voltage supplies to the
> RK3399 PCIe block.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

applied, after fixing the property/node ordering.
I try to keep things mostly alphabetically :-)

Heiko


