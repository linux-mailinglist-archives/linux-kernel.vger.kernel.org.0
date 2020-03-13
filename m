Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD24718504C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 21:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCMU3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 16:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgCMU27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:28:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D01DF20751;
        Fri, 13 Mar 2020 20:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584131338;
        bh=ewU3LIoKJn4Z7Q9nQiPnlGO0QOpvzahcRhd6C5AzF6Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=u195MHvV74rlYOaXnwZfY3UnBWbwaTuKjKQfyT6BYzkX5iwxKhwroTo/TMOW1QOHk
         PTSY9ihggk0jpmnmV+9py+EdRf1K+WVefjTjh/cJMY941awMd1ppCms4mimg2chS8R
         a8PuvXkVdb4TCRK2khd/2I1IkAfi8yo9+3Z/WVQU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1584115819-17778-1-git-send-email-abel.vesa@nxp.com>
References: <1584115819-17778-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH] clk: imx: clk-gate2: Pass the device to the register function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Fri, 13 Mar 2020 13:28:58 -0700
Message-ID: <158413133801.164562.8872574647056817277@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2020-03-13 09:10:19)
> The device needs to be passed on to the clk_hw_register.
>=20
> Fixes: 1f9aec9662566189 ("clk: imx: clk-gate2: Switch to clk_hw based API=
")
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
