Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35512131B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfECQAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 12:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfECQAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:00:37 -0400
Received: from localhost (unknown [104.132.0.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C7052075C;
        Fri,  3 May 2019 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556899236;
        bh=bxhQFwkgb1/uTuKhOvqyOxk9Lk21qkxoVsIO9wm62ck=;
        h=In-Reply-To:References:To:Cc:From:Subject:Date:From;
        b=yFM/I+fhaz7lElaS0OEcAC+wiUgGonipKNEnUXd4yrkSEaqXrPiupuYAVH4b64cCm
         RgTH++volK8HAZPU112kb+cNaVRWb7k2tFgdL+o5gXYJZbg6lVUW8juUaK6+DigEgh
         BC3mGnRa23ci6dfKCRgQp69kqR8R4ogVNbke/280=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM0PR04MB4211B63333AB7C50497AE17680350@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1556585557-28795-1-git-send-email-Anson.Huang@nxp.com> <155674445915.200842.2835083854881674143@swboyd.mtv.corp.google.com> <AM0PR04MB4211B63333AB7C50497AE17680350@AM0PR04MB4211.eurprd04.prod.outlook.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH V2] clk: imx: pllv4: add fractional-N pll support
Message-ID: <155689923561.200842.16988174858654134777@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 03 May 2019 09:00:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aisheng Dong (2019-05-02 19:38:34)
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > Sent: Thursday, May 2, 2019 5:01 AM
> >=20
> > The Content-transfer-encoding header is still base64. I guess it can't =
be fixed.
> >=20
>=20
> How can we know it's base64?
> As I saw from the 'Headers' in patchwork, it's:
> "Content-Type: text/plain; charset=3D"us-ascii"
> Content-Transfer-Encoding: 7bit"
> https://patchwork.kernel.org/patch/10922657/
>=20
> We'd like to fix it this.
>=20

Also, if you look at the one for linux-clk mailing list you'll see
base64 CTE: https://patchwork.kernel.org/patch/10921115/

