Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C266AE836
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 12:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393833AbfIJKdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 06:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfIJKdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:33:06 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4E1B20872;
        Tue, 10 Sep 2019 10:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568111585;
        bh=LJtBmi1tzU6euOWenIIUw2u/xvJ895RqpElZGcqoEFA=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=OAZJ7pZnOmv9TWBnrIlLZYkgxdz9nE3yZkkswcGMUvEz1dDtQQtUpjisOcxQVWi8m
         pSr+mBZWVY9wjfPqJncBp2lPnBzesriGkO0xQ7zUSzOnyAUjNCPwVhecpHQPreRFHS
         JoMAZd14rknZjzD54lrSggDKmIYLet8VngkurqyI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190811210043.20122-2-digetx@gmail.com>
References: <20190811210043.20122-1-digetx@gmail.com> <20190811210043.20122-2-digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v10 01/15] clk: tegra20/30: Add custom EMC clock implementation
User-Agent: alot/0.8.1
Date:   Tue, 10 Sep 2019 03:33:04 -0700
Message-Id: <20190910103305.B4E1B20872@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-08-11 14:00:29)
> A proper External Memory Controller clock rounding and parent selection
> functionality is required by the EMC drivers, it is not available using
> the generic clock implementation because only the Memory Controller driver
> is aware of what clock rates are actually available for a particular
> device. EMC drivers will have to register a Tegra-specific CLK-API
> callback which will perform rounding of a requested rate. EMC clock users
> won't be able to request EMC clock by getting -EPROBE_DEFER until EMC
> driver is probed and the callback is set up.
>=20
> The functionality is somewhat similar to the clk-emc.c which serves
> Tegra124+ SoCs. The later HW generations support more parent clock sources
> and the HW configuration / integration with the EMC drivers differs a tad
> from the older gens, hence it's not really worth to try to squash
> everything into a single source file.
>=20
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

