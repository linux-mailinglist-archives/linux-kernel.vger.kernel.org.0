Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E654B960B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 18:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405555AbfITQzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 12:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405360AbfITQzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:55:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC00C207FC;
        Fri, 20 Sep 2019 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568998524;
        bh=Bab7SDLgjUNFsw/GfqlNFONf2I9Lxrh9DUg39cNE7Hg=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=wFeBQOwWWr0Wic30e3/48RMpGfbohsWOdum7aaw4cEJjAt3r1vAVdSpydG5JKOG78
         /WBBfm0nVV5yc2Id3VdV36q89tGKozJUMtto+xGt078XAP58Nku/eRJRb9xEphtKbh
         8cp8xbrM2ce43QREPcf2OKyno/shbIO4MVImSiu0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM6PR0402MB39110BCD655C354F8A295621F5880@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1567776846-6373-1-git-send-email-Anson.Huang@nxp.com> <AM6PR0402MB39110BCD655C354F8A295621F5880@AM6PR0402MB3911.eurprd04.prod.outlook.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fancy Fang <chen.fang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH V2 1/2] clk: imx8mm: Move 1443X/1416X PLL clock structure to common place
User-Agent: alot/0.8.1
Date:   Fri, 20 Sep 2019 09:55:23 -0700
Message-Id: <20190920165524.CC00C207FC@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-09-19 18:27:39)
> Gentle ping...
>=20

Merge window is open. I expect Shawn to pick this up for v5.5 in a week
or two.

