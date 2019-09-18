Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14678B5BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 08:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfIRGHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 02:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbfIRGHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:07:35 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B90EA20856;
        Wed, 18 Sep 2019 06:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568786854;
        bh=Ts05YE0IjGolvN6Z7Hv/3J3qFt2qBGevkokf4x6n7e0=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=VdmBBFmXgopq7WcGmLHBMOdq5W0g7H88njURoDcrLWaKfJehCItaEm+WjAX/cGPj0
         aHSQG2CE+Csjnw3ZTuB0GlFyoXYDY42es+HDJhbIQ7LvhScgwRUvAMXNf/UCej6nTF
         ImrBB8oBgAcQcaYSzx7PFhDUTBYCi+PaevSVcNc8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1568043491-20680-5-git-send-email-peng.fan@nxp.com>
References: <1568043491-20680-1-git-send-email-peng.fan@nxp.com> <1568043491-20680-5-git-send-email-peng.fan@nxp.com>
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
Subject: Re: [PATCH V3 4/4] clk: imx: imx8mn: fix pll mux bit
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 23:07:33 -0700
Message-Id: <20190918060734.B90EA20856@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (2019-09-08 20:39:50)
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
> Suggested-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Applied to clk-next

