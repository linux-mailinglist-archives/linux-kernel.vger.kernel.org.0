Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F224E37C44
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 20:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfFFS3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 14:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730630AbfFFS3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:29:41 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0D8C20872;
        Thu,  6 Jun 2019 18:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559845781;
        bh=OoC4nuWJqWE5iN/x6Gw9nBBptIg/ze0etoB1mALTSr8=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=P94sqtESM6b3xMQNPs2CjFLVowQJbk6VUGVSpv8guH7GwtldZ6lxKUVT+sP2mIDVj
         iwvC1wIFrZn6j796btdt+p6I/JHv9PyFivw6RXrRx8dq91v3LSpB9w5J/Sc8Xsn0QG
         lWrA74hFBsg/O/8mabbl8C3pIsOAZlwnyBQNQmmE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
References: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RESEND v2 00/18] clk: imx: Switch the imx6 and imx7 to clk_hw based API
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 11:29:40 -0700
Message-Id: <20190606182940.F0D8C20872@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-05-29 05:26:38)
> Resend for the following:
>=20
> https://lkml.org/lkml/2019/5/2/170

What's left after this series to convert over to clk_hw based APIs? I'm
happy to see this merge as long as we eventually delete the clk based
versions of the code in the imx driver so that we can complete the task.

I took a look over everything and nothing stuck out, so:

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

for the series.

