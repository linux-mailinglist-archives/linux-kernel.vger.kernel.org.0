Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E2B4160
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 21:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390939AbfIPTws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 15:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390853AbfIPTwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:52:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAE5C206C2;
        Mon, 16 Sep 2019 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568663566;
        bh=oG3pL7+t1Jea28STZBtRBVheLtg6niY1SV6fDuBZuz8=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=Xv+JIS9Wk+jVAZqrZRTOB3ygYCGJhi3jfZFrTpFEL4lXgR0Mdry7mNB/B8UUTp05+
         gBkKFE5Ev6DWeSbSWst0+4DFf0Tq2PJ1ZaEFO4yWhd6P1FQfSLcs6eQqs40Z0IPl64
         ruHiEjmPvAmSjD6fXGA9qHu9Inuof6n5hH5DFrlc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1568183622-7858-1-git-send-email-eugen.hristev@microchip.com>
References: <1568183622-7858-1-git-send-email-eugen.hristev@microchip.com>
Cc:     Nicolas.Ferre@microchip.com, Eugen.Hristev@microchip.com
To:     Eugen.Hristev@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: at91: allow 24 Mhz clock as input for PLL
User-Agent: alot/0.8.1
Date:   Mon, 16 Sep 2019 12:52:45 -0700
Message-Id: <20190916195246.CAE5C206C2@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eugen.Hristev@microchip.com (2019-09-10 23:39:20)
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> The PLL input range needs to be able to allow 24 Mhz crystal as input
> Update the range accordingly in plla characteristics struct
>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---

Is there a Fixes: tag for this? Seems like it was always wrong?

