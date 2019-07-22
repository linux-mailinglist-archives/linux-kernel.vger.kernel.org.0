Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0650570C25
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfGVVy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfGVVy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:54:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3366F21951;
        Mon, 22 Jul 2019 21:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563832495;
        bh=Ztnpccpzf1qnXy+e4Vmgo8C1N3x+AaZr9jxD3C6+Jm8=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=VVHI1s3rhspV7YM7nVPrNU34R6zCrRk0pjg/8oCkrTvuPJmtR3jVrpZInnmqAS/nt
         48HCnh/qQQ/4jLgvZNw4wkGA6P3je0ybeG6UfbBy+W8QgFoxz+HDVIRPoHG4J4ax7r
         MhQ4TW0ZypqDXjhqzZwVpejCrIundT3GtZF/JUGk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190718053616.27042-1-zhang.lyra@gmail.com>
References: <20190718053616.27042-1-zhang.lyra@gmail.com>
Subject: Re: [PATCH] clk: sprd: Select REGMAP_MMIO to avoid compile errors
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:54:54 -0700
Message-Id: <20190722215455.3366F21951@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2019-07-17 22:36:16)
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>=20
> Make REGMAP_MMIO selected to avoid undefined reference to regmap symbols.
>=20
> Fixes: d41f59fd92f2 ("clk: sprd: Add common infrastructure")
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---

Applied to clk-fixes

