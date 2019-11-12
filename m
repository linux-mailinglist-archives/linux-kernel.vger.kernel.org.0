Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC85F9D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 23:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKLWqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 17:46:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbfKLWqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:46:47 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39F572084E;
        Tue, 12 Nov 2019 22:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573598807;
        bh=n2+P0RB97vUctcmCrSIYeykZT7to1k5WHK/8kT+mhZc=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=sZN8+Ym9wOg8pNvgoBPuTIhuBFjeav2JNG9mlOUcce7ahPlg6OYnPZs+lZPg/HoIF
         qVZecwsMnZomnMIICndZomznsGEz8v/bSWT7RiKNw6QGYJPMRvsY8beijj7a4Cw6qU
         q7tcNkqU51p8cvsVRlc+6sa6wOCv4Zp19hxBAYk0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573575426-31314-1-git-send-email-skomatineni@nvidia.com>
References: <1573575426-31314-1-git-send-email-skomatineni@nvidia.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        mturquette@baylibre.com, pgaikwad@nvidia.com,
        thierry.reding@gmail.com
Cc:     digetx@gmail.com, pdeschrijver@nvidia.com,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: tegra: clk-dfll: Fix to remove pm_runtime_irq_safe
User-Agent: alot/0.8.1
Date:   Tue, 12 Nov 2019 14:46:46 -0800
Message-Id: <20191112224647.39F572084E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sowjanya Komatineni (2019-11-12 08:17:05)
> This patch includes fix to remove pm_runtime_irq_safe which was added
> mistakenly during dfll suspend and resume implementation as a part of
> Tegra210 SC7 suspend and resume patch series.
>=20
> This patch removes pm_runtime_irq_safe and also has minor description
> update for argument of dfll_suspend in comments.
>=20
> Some of the patch series are applied so sending this fix as incremental
> fix to latest linux-next.

Please don't send cover letters for single patches. The value add is
minimal vs. just putting extra text next to the diffstat in the single
patch.

>=20
> Sowjanya Komatineni (1):
>   clk: tegra: clk-dfll: Fix to remove pm_runtime_irq_safe
>=20
>  drivers/clk/tegra/clk-dfll.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
