Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE6B5B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 08:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfIRGH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 02:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfIRGH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:07:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80D9620856;
        Wed, 18 Sep 2019 06:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568786847;
        bh=E+ag569ps4IxsaujNVfAcc3vW6cQZB2utRWUInlFvl0=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=B/mfeL7Z3g0BD3P7reEQqj6Te/mnLzFSu0Pvz0fE/6GvzjN86KfgOUgtZ1xPr3E5+
         SWNCvzUhHFK0swvgEV7ixEftNkjdzASun579pVK6WcSSJbgZWR0a9l4qyHWSDIib6g
         /osvjDj0ZT6mNesNNpUZlMDoQ8tfSOY/MYNCa84E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1568043491-20680-3-git-send-email-peng.fan@nxp.com>
References: <1568043491-20680-1-git-send-email-peng.fan@nxp.com> <1568043491-20680-3-git-send-email-peng.fan@nxp.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH V3 2/4] clk: imx: clk-pll14xx: unbypass PLL by default
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 23:07:26 -0700
Message-Id: <20190918060727.80D9620856@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (2019-09-08 20:39:39)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> When registering the PLL, unbypass the PLL.
> The PLL has two bypass control bit, BYPASS and EXT_BYPASS.
> we will expose EXT_BYPASS to clk driver for mux usage, and keep
> BYPASS inside pll14xx usage. The PLL has a restriction that
> when M/P change, need to RESET/BYPASS pll to avoid glitch, so
> we could not expose BYPASS.
>=20
> To make it easy for clk driver usage, unbypass PLL which does
> not hurt current function.
>=20
> Fixes: 8646d4dcc7fb ("clk: imx: Add PLLs driver for imx8mm soc")
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Applied to clk-next

