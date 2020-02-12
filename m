Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2296A15B259
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 21:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgBLU5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 15:57:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbgBLU5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:57:53 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9CB0206D7;
        Wed, 12 Feb 2020 20:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581541073;
        bh=NJ7aaNUqEPVaOqRQtSadrD1LNqyvV0+PjEpnK+RiSgA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Hqp5Rj2bgJBgetIw/kbLJbfXvOyWWl2e/oGyZ3PJ+jGXFV/E+OlJBmGeBNekMqrjZ
         8cSW3L38W8G2LjFdoc/PC/G6BKoQAos/BNZrGxS+N/hT9p00FDs9cnAnlIqg2CC1Hc
         bSh3I5xhy+HG5gJNZ4h2nVuIuJywyQwLWd98/Acg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200212094317.1150-1-geert+renesas@glider.be>
References: <20200212094317.1150-1-geert+renesas@glider.be>
Subject: Re: [PATCH] of: clk: Make of_clk_get_parent_{count,name}() parameter const
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 12 Feb 2020 12:57:52 -0800
Message-ID: <158154107225.184098.12794012881408506837@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 01:43:17)
> of_clk_get_parent_count() and of_clk_get_parent_name() never modify the
> device nodes passed, so they can be const.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Seems fine. I'll push it into clk-fixes in case that help fastrack any
patches for next release.
