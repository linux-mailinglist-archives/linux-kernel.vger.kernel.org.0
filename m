Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0761101F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 10:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfKSJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 04:10:36 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54756 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfKSJKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:10:36 -0500
Received: from wf0530.dip.tu-dresden.de ([141.76.182.18] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iWzWo-0004F2-4O; Tue, 19 Nov 2019 10:10:30 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        'Ulf Hansson' <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: Use correct pin for lcd-reset pinctrl on rk3399-roc-pc
Date:   Tue, 19 Nov 2019 10:10:29 +0100
Message-ID: <3364813.APbW32NlgJ@phil>
In-Reply-To: <cd5fd3a8-b0eb-9dc1-c473-9355762cdaa5@fivetechno.de>
References: <25466090-3b24-2695-10fb-88c59be3f149@fivetechno.de> <1918981.kTmXGv9Lqf@phil> <cd5fd3a8-b0eb-9dc1-c473-9355762cdaa5@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 18. November 2019, 12:23:18 CET schrieb Markus Reichl:
> Fix typo according to schematics.
> The original pin is needed to enable vcc3v0_sd in second patch of this series.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>

applied (yesterday evening already)

Thanks
Heiko


