Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3583C39740
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 23:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfFGVEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 17:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbfFGVD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:03:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F21222146E;
        Fri,  7 Jun 2019 21:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559941439;
        bh=RG+KkS0nch2rasB5kTgN4eEZwssboDr7ajTm4kXqNfc=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=XtvMgKzHad6s4+dpds3CDUimrn5le5Jn3GWOunnmUlIfRdmi5Ktp4KJf95nyvrXm7
         OmfReND0PfcRmADv1FvQ3FV3YHyOWlkRc4QrB8geOw486p/VcFVimr9VVEEEXzIhoL
         /CTh/+0mwWp0oUuaAXAwCbDp/6qmSNhNVOd57upc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190502212502.24330-5-paul@crapouillou.net>
References: <20190502212502.24330-1-paul@crapouillou.net> <20190502212502.24330-5-paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 5/5] clk: ingenic/jz4725b: Fix "pll half" divider not read/written properly
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
User-Agent: alot/0.8.1
Date:   Fri, 07 Jun 2019 14:03:58 -0700
Message-Id: <20190607210358.F21222146E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-05-02 14:25:02)
> The code was setting the bit 21 of the CPCCR register to use a divider
> of 2 for the "pll half" clock, and clearing the bit to use a divider
> of 1.
>=20
> This is the opposite of how this register field works: a cleared bit
> means that the /2 divider is used, and a set bit means that the divider
> is 1.
>=20
> Restore the correct behaviour using the newly introduced .div_table
> field.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next

