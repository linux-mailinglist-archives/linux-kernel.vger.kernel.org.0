Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E658ABE92
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 19:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406050AbfIFRUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 13:20:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbfIFRUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:20:45 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B99FB20838;
        Fri,  6 Sep 2019 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567790444;
        bh=MqN/EtBkVnxG8eZiColGzmDCTwXUPyPh5+LpIVe0YG4=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=CYozECqVpRrFJH2xvk6dZ4mN6OY4KecJUOzK1vGdSGMnbIKxRA8qh/Kc+LdHjTEx5
         PUZXjE89eK7y1b+ifK4UXKqZC6DrG2/yezn1PYX7R3f5S+sw3IiAvYj3lL3oy5GVCa
         FqYmivqaXH8/EfZQDELvYwg6vU0Xnas34hkqips0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1566936978-28519-1-git-send-email-peng.fan@nxp.com>
References: <1566936978-28519-1-git-send-email-peng.fan@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] clk: imx: lpcg: write twice when writing lpcg regs
User-Agent: alot/0.8.1
Date:   Fri, 06 Sep 2019 10:20:43 -0700
Message-Id: <20190906172044.B99FB20838@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (2019-08-27 01:17:50)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> There is hardware issue that:
> The output clock the LPCG cell will not turn back on as expected,
> even though a read of the IPG registers in the LPCG indicates that
> the clock should be enabled.
>=20
> The software workaround is to write twice to enable the LPCG clock
> output.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Does this need a Fixes tag?

