Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D09130C5A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 04:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgAFDHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 22:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFDHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:07:05 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68E121582;
        Mon,  6 Jan 2020 03:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578280025;
        bh=ZlRvRlZSzyljxNPxVSZPQBWg+toDUmAzRRGF5W83VpM=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=CFyziydh0/bM1WTts1DaxVKN5pLgKG8nwPt2XsTULjYGRx0nr3Ec1ydvUc2lv3p5P
         m+FiiZVciTwKgpZ1cadTWuQSXSQhkIcQckaQwzhAxBPPVGvkvQcIcDD3vHGeVWH9cA
         hWvlcd9Rf0Pi+yAGPya/PBSrl8Jq7jkb7FcgN2JU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1575977088-16781-1-git-send-email-eugen.hristev@microchip.com>
References: <1575977088-16781-1-git-send-email-eugen.hristev@microchip.com>
Cc:     Nicolas.Ferre@microchip.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eugen.Hristev@microchip.com
To:     Eugen.Hristev@microchip.com, alexandre.belloni@bootlin.com,
        mturquette@baylibre.com
Subject: Re: [PATCH] clk: at91: sam9x60: fix programmable clock prescaler
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 19:07:04 -0800
Message-Id: <20200106030704.D68E121582@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eugen.Hristev@microchip.com (2019-12-10 03:25:19)
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> The prescaler works as parent rate divided by (PRES + 1) (is_pres_direct =
=3D=3D 1)
> It does not work in the way of parent rate shifted to the right by (PRES =
+ 1),
> which means division by 2^(PRES + 1) (is_pres_direct =3D=3D 0)
> Thus is_pres_direct must be enabled for this SoC, to make the right compu=
tation.
> This field was added in
> commit 45b06682113b ("clk: at91: fix programmable clock for sama5d2")
> SAM9X60 has the same field as SAMA5D2 in the PCK
>=20
> Fixes: 01e2113de9a5 ("clk: at91: add sam9x60 pmc driver")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---

Applied to clk-next

