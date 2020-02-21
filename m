Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F67A168A9B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 00:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgBUX5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 18:57:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgBUX5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:57:53 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B862068F;
        Fri, 21 Feb 2020 23:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582329472;
        bh=n0vjHVM2DuhbpPYoxUKATWLMuk00e4mnD7YQoWp4vUk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OIc0H/6FEBoyV45z3mlrdQOZGlTjYb5cKOX8tyqwAiMmkIlY4O9/GD+thIk3aXxsG
         jIjtFlVnom2DIHf7DacvmaOFcDdyLjsT6f8EY9Pmpo3a9lwbkeFP/VA7/hGESogbek
         ZcPYRqs8Jucy3hrPeOGTK7yh2xCobn+qyOSRBAc4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582266716-19821-1-git-send-email-Anson.Huang@nxp.com>
References: <1582266716-19821-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH] clk: imx: pll14xx: Return error if pll type is invalid
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, festevam@gmail.com,
        kernel@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, ping.bai@nxp.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, yuehaibing@huawei.com
Date:   Fri, 21 Feb 2020 15:57:51 -0800
Message-ID: <158232947182.258574.584668677246692139@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-02-20 22:31:56)
> When pll type is invalid, ONLY output error message is NOT enough,
> should return error immediately.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
