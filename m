Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4797147435
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 23:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgAWW7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 17:59:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbgAWW7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:59:06 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF26322522;
        Thu, 23 Jan 2020 22:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579820345;
        bh=2Zezl1LGfgQM4NxOR/cg+DnBZ7P8wOVJXTA1zOGyLNM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=k9v1dJ/mHYBr4Yx69rbcudReeoRPngGNDHU4uWb8uNegwXXh0tV885FCLJoySkqTC
         mJ5SlVRIcNFST4swnU/ez+WtLgA9L1/Puu8DnhBKaq4NyqsYHFDg8+Myzd/Azn8GWM
         QFOxxnqYHgg2OfxifDwOVIR0Y7FVXhhdx8xrLW3Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1575527759-26452-7-git-send-email-rajan.vaja@xilinx.com>
References: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com> <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com> <1575527759-26452-7-git-send-email-rajan.vaja@xilinx.com>
Subject: Re: [PATCH v3 6/6] clk: zynqmp: Add support for clock with CLK_DIVIDER_POWER_OF_TWO flag
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>
To:     Rajan Vaja <rajan.vaja@xilinx.com>, gustavo@embeddedor.com,
        jolly.shah@xilinx.com, m.tretter@pengutronix.de,
        mark.rutland@arm.com, mdf@kernel.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, nava.manne@xilinx.com, robh+dt@kernel.org,
        tejas.patel@xilinx.com
User-Agent: alot/0.8.1
Date:   Thu, 23 Jan 2020 14:59:05 -0800
Message-Id: <20200123225905.BF26322522@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2019-12-04 22:35:59)
> From: Tejas Patel <tejas.patel@xilinx.com>
>=20
> Existing clock divider functions is not checking for
> base of divider. So, if any clock divider is power of 2
> then clock rate calculation will be wrong.
>=20
> Add support to calculate divider value for the clocks
> with CLK_DIVIDER_POWER_OF_TWO flag.
>=20
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---

Applied to clk-next

