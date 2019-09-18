Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931C7B5B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 08:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfIRGHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 02:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfIRGHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:07:31 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A60220856;
        Wed, 18 Sep 2019 06:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568786851;
        bh=jNhbz67CJr/g2fdjXe+N+K8ckAY7k1eWl83twN0NrXA=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=i2K8gJQM0HbM2ZNZSIwPgK+a8ru9cYl2eYOub+t5Aa/Mll4ya7fal7MFOxBo3K1dg
         pdLVcFKnMNOcHv4rPXBY4N8/rM/YuFsCVOZ0vr/m37Lcis9s47eUYJ2fcQdBGS0Hl5
         qXtjMqa4X5+nBV7I8vdwJIESc5HPNhuRphWFOQIc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1568043491-20680-4-git-send-email-peng.fan@nxp.com>
References: <1568043491-20680-1-git-send-email-peng.fan@nxp.com> <1568043491-20680-4-git-send-email-peng.fan@nxp.com>
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
Subject: Re: [PATCH V3 3/4] clk: imx: imx8mm: fix pll mux bit
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 23:07:30 -0700
Message-Id: <20190918060731.1A60220856@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (2019-09-08 20:39:44)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> pll BYPASS bit should be kept inside pll driver for glitchless freq
> setting following spec. If exposing the bit, that means pll driver and
> clk driver has two paths to touch this bit, which is wrong.
>=20
> So use EXT_BYPASS bit here.
>=20
> And drop uneeded set parent, because EXT_BYPASS default is 0.
>=20
> Fixes: ba5625c3e272 ("clk: imx: Add clock driver support for imx8mm")
> Suggested-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Applied to clk-next

