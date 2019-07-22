Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5A970B74
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfGVVc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732693AbfGVVcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:32:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2528D2199C;
        Mon, 22 Jul 2019 21:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563831144;
        bh=bBcpDluCbko3kbonCQyyd4XLiCbRTErroncqjc0RAUQ=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=ZWr7A9BGdLikxgiaduH9zgrugNGlAia1wPV/G2f8iMfjEBr0dwDW0Pb1MPSd7oaMe
         lX7smMgbijMIg5+epywvSGNFF4gzzkgI4v9pP/U+UJvPO8kWkDdPiRnoRDodobQwa+
         BiREPrRaUN6ohN/iBfQZwICQwAJ6lKowpv56ghJI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190701114651.16872-1-s.nawrocki@samsung.com>
References: <CGME20190701114709eucas1p135d990205d5df237abd550d89e3de02b@eucas1p1.samsung.com> <20190701114651.16872-1-s.nawrocki@samsung.com>
Subject: Re: [PATCH] clk: Add missing documentation of devm_clk_bulk_get_optional() argument
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        mturquette@baylibre.com
Cc:     linux@armlinux.org.uk, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:32:23 -0700
Message-Id: <20190722213224.2528D2199C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sylwester Nawrocki (2019-07-01 04:46:51)
> Fix an incomplete devm_clk_bulk_get_optional() function documentation
> by adding description of the num_clks argument as in other *clk_bulk*
> functions.
>=20
> Fixes: 9bd5ef0bd874 ("clk: Add devm_clk_bulk_get_optional() function")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---

Applied to clk-fixes

