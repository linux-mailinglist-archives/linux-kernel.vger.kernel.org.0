Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D89F15AE10
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 18:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgBLRHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 12:07:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLRHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:07:03 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203A720658;
        Wed, 12 Feb 2020 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581527223;
        bh=Ez7EJchARKYuQb1vm/cb3M4I/6E7nH23RNuR2J5qXSg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=0fdPiTxFUXYvgLQL8UYo0Yp2lr8ZuJ3K8lvPoPfLS9FMXouTIqx5543yZ6pubMrXE
         fW2Ko2qXz/1/8Fw6eMiajFBeaamzEUJUqZ4XOGp7aZVq/0igAEZdalTn4ogCB4Q/MJ
         mMmY8y6RyhchM9jdAtHDu5p1IMNTOMjmyzDNvoEU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200212101140.23242-1-geert+renesas@glider.be>
References: <20200212101140.23242-1-geert+renesas@glider.be>
Subject: Re: [PATCH] h8300: Replace <linux/clk-provider.h> by <linux/of_clk.h>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     uclinux-h8-devel@lists.sourceforge.jp, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Date:   Wed, 12 Feb 2020 09:07:02 -0800
Message-ID: <158152722240.121156.15400505454189989547@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 02:11:40)
> The H8/300 platform code is not a clock provider, and just needs to call
> of_clk_init().
>=20
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
