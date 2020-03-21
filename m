Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFCD518DD2F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 02:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgCUBYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 21:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUBYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:24:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 615C820732;
        Sat, 21 Mar 2020 01:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584753883;
        bh=a7oq14gh90f9G9cupQDvc9EWm1m9yJ4iZFLErXizOcA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TGEI4V2Sr9IwJ2vBZpVZGIAwljW2QxC17vCA1WzaVme3mY5AjgPfyfixpvTQgspyz
         omNWEhBVFBT8YfXNrFYmYw5dg8JcsPjOXCDyoOJWEa4mvy8dpxHs3kTTWYfruumyqT
         J7JYlBIh/rvdFNpNScrVbkMGiM0orrW9U07q7WGI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309194254.29009-5-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk> <20200309194254.29009-5-lkundrak@v3.sk>
Subject: Re: [PATCH v2 04/17] clk: mmp2: Add support for PLL clock sources
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Fri, 20 Mar 2020 18:24:42 -0700
Message-ID: <158475388263.125146.11372517982520346232@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-03-09 12:42:41)
> The clk-of-mmp2 driver pretends that the clock outputs from the PLLs are
> constant, but in fact they are configurable.
>=20
> Add logic for obtaining the actual clock rates on MMP2 as well as MMP3.
> There is no documentation for either SoC, but the "systemsetting" drivers
> from Marvell GPL code dump provide some clue as far as MPMU registers on
> MMP2 [1] and MMP3 [2] go.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp3-d=
ell-ariel.git/tree/drivers/char/mmp2_systemsetting.c
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp3-d=
ell-ariel.git/tree/drivers/char/mmp3_systemsetting.c
>=20
> A separate commit will adjust the clk-of-mmp2 driver.
>=20
> Tested on a MMP3-based Dell Wyse 3020 as well as MMP2-based OLPC
> XO-1.75 laptop.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-next
