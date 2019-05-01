Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB3010E53
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 23:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfEAVBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 17:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfEAVBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:01:00 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 094E22075E;
        Wed,  1 May 2019 21:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556744460;
        bh=RNfxhTIjmff0paVh7E25ufbTsE9xtP3fIa1eYFm/084=;
        h=In-Reply-To:References:To:Cc:From:Subject:Date:From;
        b=IbF1Cx5Sgla9OzDphVepmru3gr3lihFyNA7Ktxt/wAwj70/vPxCydDr43ABcgLTIE
         C/WulMaNZ+OymYH6AkVZdNkaNdsG3k77QxjCpgpXjl9ONBhYKznyKS+8+0Be1rLTfP
         K255BKxkq4mqk/ACNZaqJJM6Ux6Qo62e6VX/FKJo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1556585557-28795-1-git-send-email-Anson.Huang@nxp.com>
References: <1556585557-28795-1-git-send-email-Anson.Huang@nxp.com>
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
Subject: Re: [PATCH V2] clk: imx: pllv4: add fractional-N pll support
Message-ID: <155674445915.200842.2835083854881674143@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 01 May 2019 14:00:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Content-transfer-encoding header is still base64. I guess it can't
be fixed.

Quoting Anson Huang (2019-04-29 17:57:22)
> The pllv4 supports fractional-N function, the formula is:
>=20
> PLL output freq =3D input * (mult + num/denom),
>=20
> This patch adds fractional-N function support, including
> clock round rate, calculate rate and set rate, with this
> patch, the clock rate of APLL in clock tree is more accurate
> than before:
>=20
