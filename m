Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7B512AF06
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Dec 2019 23:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfLZWB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 17:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfLZWB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:01:27 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0006B2080D;
        Thu, 26 Dec 2019 22:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577397687;
        bh=MBkkTBlGWw5olWrDSZWXdjwoo5PlsiIXyeF7PDw8KPI=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=1Hp7vDJ30HYk8fJopeTfrE6NEh+9TnNDKSOseE4yR4j4bDD35fVNRM7Y9EQoyRYdz
         uHd0JXRQlDZVbh9lNg2/5ZViVl9krzgmKwGfAEfJZRr962z9QKCeZZABMqElyvq5Pc
         i6f2oaToF5canUwKnCdrNhv12lTnPJpg1z9MlW1w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191225163429.29694-1-linux@roeck-us.net>
References: <20191225163429.29694-1-linux@roeck-us.net>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jerome Brunet <jbrunet@baylibre.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] clk: Don't try to enable critical clocks if prepare failed
User-Agent: alot/0.8.1
Date:   Thu, 26 Dec 2019 14:01:26 -0800
Message-Id: <20191226220127.0006B2080D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guenter Roeck (2019-12-25 08:34:29)
> The following traceback is seen if a critical clock fails to prepare.
>=20
> bcm2835-clk 3f101000.cprman: plld: couldn't lock PLL
> ------------[ cut here ]------------
> Enabling unprepared plld_per
> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:1014 clk_core_enable+0xcc/0x2=
c0
> ...
> Call trace:
>  clk_core_enable+0xcc/0x2c0
>  __clk_register+0x5c4/0x788
>  devm_clk_hw_register+0x4c/0xb0
>  bcm2835_register_pll_divider+0xc0/0x150
>  bcm2835_clk_probe+0x134/0x1e8
>  platform_drv_probe+0x50/0xa0
>  really_probe+0xd4/0x308
>  driver_probe_device+0x54/0xe8
>  device_driver_attach+0x6c/0x78
>  __driver_attach+0x54/0xd8
> ...
>=20
> Check return values from clk_core_prepare() and clk_core_enable() and
> bail out if any of those functions returns an error.
>=20
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Fixes: 99652a469df1 ("clk: migrate the count of orphaned clocks at init")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Applied to clk-fixes

