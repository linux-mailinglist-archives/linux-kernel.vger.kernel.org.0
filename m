Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E95125A76
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 06:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLSFOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 00:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfLSFOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 00:14:39 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2B842146E;
        Thu, 19 Dec 2019 05:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576732478;
        bh=zutbo+tkyWAeoZo0maixsENGTToLoAmt9MwqGd10Gvk=;
        h=In-Reply-To:References:Cc:Subject:From:To:Date:From;
        b=SvdIWTueB22fAa/EqIDmetplXA/yHVHTxROAlv9nALYp6XEVxf+PZ13hSd6ZP7zUq
         aTg2Gj1IuqzblN2opxfhhQGK69ycvcncMQcLaTtpyasdIk7oDDXmNz1FnV+R7GK84H
         +SADY9DR+IEd06Bjcm6lnOiXp6BUonTRz8RoxwAc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191218190454.420358-3-lkundrak@v3.sk>
References: <20191218190454.420358-1-lkundrak@v3.sk> <20191218190454.420358-3-lkundrak@v3.sk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 2/2] clk: mmp2: Fix the order of timer mux parents
From:   Stephen Boyd <sboyd@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>
User-Agent: alot/0.8.1
Date:   Wed, 18 Dec 2019 21:14:37 -0800
Message-Id: <20191219051438.C2B842146E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-12-18 11:04:54)
> Determined empirically, no documentation is available.
>=20
> The OLPC XO-1.75 laptop used parent 1, that one being VCTCXO/4 (65MHz), b=
ut
> thought it's a VCTCXO/2 (130MHz). The mmp2 timer driver, not knowing
> what is going on, ended up just dividing the rate as of
> commit f36797ee4380 ("ARM: mmp/mmp2: dt: enable the clock")'
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Any Fixes: tag?

Acked-by: Stephen Boyd <sboyd@kernel.org>

