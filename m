Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1835E7819B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 22:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfG1U4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 16:56:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60710 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfG1U4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 16:56:01 -0400
Received: from ip4d16169c.dynamic.kabel-deutschland.de ([77.22.22.156] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hrqCz-0007WZ-0i; Sun, 28 Jul 2019 22:55:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: Add missing unit address to memory node on rk3288-veyron
Date:   Sun, 28 Jul 2019 22:55:56 +0200
Message-ID: <8373672.S8ITYX37Bm@phil>
In-Reply-To: <CAJKOXPcHB9969bqw+aqRh1HYHKDazhhpKy_+uKKcA=5Gkg6+EA@mail.gmail.com>
References: <20190727142736.23188-1-krzk@kernel.org> <86910491.m50tbimVMv@phil> <CAJKOXPcHB9969bqw+aqRh1HYHKDazhhpKy_+uKKcA=5Gkg6+EA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 28. Juli 2019, 13:38:43 CEST schrieb Krzysztof Kozlowski:
> On Sat, 27 Jul 2019 at 17:33, Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > Hi Krzysztof,
> >
> > Am Samstag, 27. Juli 2019, 16:27:36 CEST schrieb Krzysztof Kozlowski:
> > > Fix DTC warning:
> > >
> > >     arch/arm/boot/dts/rk3288-veyron.dtsi:21.9-24.4:
> > >     Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
> >
> > please see the comment directly above the memory node on why that needs
> > to stay that way. So no, we'll keep the veyron memory node as is.
> 
> Damn it, I missed it.

no worries :-)


