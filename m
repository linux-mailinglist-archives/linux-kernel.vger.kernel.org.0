Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 014A018DC59
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 01:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgCUAGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 20:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbgCUAGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:06:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CFA020777;
        Sat, 21 Mar 2020 00:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584749168;
        bh=aqc1nwxD2JVKkvrOl3kWSCll9YVmqSIDMks9uATyyG8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ClC5dOV8QR9KK+Zq8oUQh5C/7iRhf3yloDptsKdGBEQcWDFezB3p2RzDsnmdslXkR
         SuD884ExJU2+R1qXwTIrZV0BmIblCO3FXG2zMi/CJosLX106gYIzZXRXethR6rQif+
         WY6vfmoTq5jRudWWCCyDMc+VzE26TLfsidQWTlZ0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200227053529.16479-3-vigneshr@ti.com>
References: <20200227053529.16479-1-vigneshr@ti.com> <20200227053529.16479-3-vigneshr@ti.com>
Subject: Re: [PATCH v4 2/2] clk: keystone: Add new driver to handle syscon based clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Date:   Fri, 20 Mar 2020 17:06:07 -0700
Message-ID: <158474916743.125146.2512565488728319970@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vignesh Raghavendra (2020-02-26 21:35:29)
> On TI's AM654/J721e SoCs, certain clocks can be gatemld/ungated by settin=
g a
> single bit in SoC's System Control Module registers. Sometime more than
> one clock control can be in the same register.
> Add a driver to support such clocks using syscon framework.
> Driver currently supports controlling EHRPWM's TimeBase clock(TBCLK) for
> AM654 SoC.
>=20
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---

Applied to clk-next
