Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5FF15AE12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 18:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgBLRHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 12:07:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLRHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:07:20 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE3DC20658;
        Wed, 12 Feb 2020 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581527239;
        bh=uNETKxC2wT/oP0ZdfyY7zoUJYRdQbUKhDpqdddWFZ20=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=P9ZKkGzDLMoI6EMnF5gLBgQ6K1JK0yO1Lhrd5iAC+Qf5OtQVpyT7B+pj/72Q5ECxH
         hDCqcgU4mJzOyoD+Olvwpo7/YdQJ1j8C/GKdqRs/q32V+cA/qjvSvspISPK+j9a5um
         km2MGSG8WXnGTeMBBUA+Z072kPAi2MZkJ7fsIKMo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200212101229.6165-1-geert+renesas@glider.be>
References: <20200212101229.6165-1-geert+renesas@glider.be>
Subject: Re: [PATCH] microblaze: Replace <linux/clk-provider.h> by <linux/of_clk.h>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michal Simek <monstr@monstr.eu>
Date:   Wed, 12 Feb 2020 09:07:19 -0800
Message-ID: <158152723907.121156.8657099328886693095@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 02:12:29)
> The MicroBlaze platform code is not a clock provider, and just needs to
> call of_clk_init().
>=20
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
