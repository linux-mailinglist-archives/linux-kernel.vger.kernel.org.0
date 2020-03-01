Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE36174A7F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 01:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgCAAiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 19:38:02 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55802 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgCAAiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 19:38:02 -0500
Received: from p508fcd9d.dip0.t-ipconnect.de ([80.143.205.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j8CcI-00050E-Gp; Sun, 01 Mar 2020 01:37:58 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 1/3] ARM: dts: rockchip: Fix vcc10_lcd name and voltage for rk3288-vyasa
Date:   Sun, 01 Mar 2020 01:37:57 +0100
Message-ID: <3357418.yJKWReClb3@phil>
In-Reply-To: <20200123134641.30720-1-jagan@amarulasolutions.com>
References: <20200123134641.30720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 23. Januar 2020, 14:46:39 CET schrieb Jagan Teki:
> According to hardware schematics of Vyasa RK3288 the
> actual name used for vcc10_lcd is vdd10_lcd.
> 
> regulator suspend voltage can rail upto 1.0V not 1.8V.
> 
> Fix the name and suspend voltage for vcc10_lcd regulator.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

applied all 3 for 5.7
[added a missing blank after the regulator in patch3]

Thanks
Heiko


