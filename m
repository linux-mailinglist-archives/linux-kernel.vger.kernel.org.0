Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4811DC4A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 03:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfLMCyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 21:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbfLMCyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 21:54:36 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F2092073D;
        Fri, 13 Dec 2019 02:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576205675;
        bh=YT/KrD9drCHzLQDLApnDQvgJZf+lw9T1tg7LKWdDM3o=;
        h=In-Reply-To:References:Subject:To:From:Cc:Date:From;
        b=wkds8U+kIoe9X5Ddcs6WPLIemyEHzHszzlZazYRFJfH53LIXrFStXArA/bF2uGVGP
         w3TaFhXyF0me4QoAXI05m/PxmFmbDrIUu6vYpaLycLNF3niGHtaUpT35BH+Z/RhCzu
         hjVVxVEUoD0y0+FMo1/GtqL5DzyN6XU+7dFyyETQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191203080805.104628-1-jbrunet@baylibre.com>
References: <20191203080805.104628-1-jbrunet@baylibre.com>
Subject: Re: [PATCH v2] clk: walk orphan list on clock provider registration
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>
User-Agent: alot/0.8.1
Date:   Thu, 12 Dec 2019 18:54:34 -0800
Message-Id: <20191213025435.7F2092073D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-12-03 00:08:05)
> So far, we walked the orphan list every time a new clock was registered
> in CCF. This was fine since the clocks were only referenced by name.
>=20
> Now that the clock can be referenced through DT, it is not enough:
> * Controller A register first a reference clocks from controller B
>   through DT.
> * Controller B register all its clocks then register the provider.
>=20
> Each time controller B registers a new clock, the orphan list is walked
> but it can't match since the provider is registered yet. When the
> provider is finally registered, the orphan list is not walked unless
> another clock is registered afterward.
>=20
> This can lead to situation where some clocks remain orphaned even if
> the parent is available.
>=20
> Walking the orphan list on provider registration solves the problem.
>=20
> Reported-by: Jian Hu <jian.hu@amlogic.com>
> Fixes: fc0c209c147f ("clk: Allow parents to be specified without string n=
ames")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-fixes

