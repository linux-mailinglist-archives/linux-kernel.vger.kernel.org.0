Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44DD8130C57
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 04:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgAFDGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 22:06:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFDGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:06:45 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF7B21582;
        Mon,  6 Jan 2020 03:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578280004;
        bh=oLScgpu+4KS4XjSuuMv26uOjGwXkmB6mp+/tig1AXW0=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=W0SS4OK/NWzVBFm6NK8kATUULYrycGMSAx1Yxo1sQFE+js+sBnhk+BKoZhQ3zwv0O
         suQRgaS74zZzSJkbb3DG1nJmxoObWZ+YFwH17Kn8h1kIARJv61WcxigcivurUFv0wg
         uAOGojB6rzHMf0BtQfKCJCns6Ei6gM1b/cZUKoD8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573478913-19737-1-git-send-email-eugen.hristev@microchip.com>
References: <1573478913-19737-1-git-send-email-eugen.hristev@microchip.com>
Cc:     Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        Eugen.Hristev@microchip.com
To:     Eugen.Hristev@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH] clk: at91: sam9x60-pll: adapt PMC_PLL_ACR default value
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 19:06:43 -0800
Message-Id: <20200106030644.ABF7B21582@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eugen.Hristev@microchip.com (2019-11-11 05:28:57)
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> Product datasheet recommends different values for UPLL and PLLA analog co=
ntrol
> register.
> Adapt accordingly.
>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---

Applied to clk-next

