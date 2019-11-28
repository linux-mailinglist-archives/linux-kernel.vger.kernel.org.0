Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF8DE10CE0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 18:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfK1Ror (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 12:44:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfK1Ror (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 12:44:47 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6821821781;
        Thu, 28 Nov 2019 17:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574963086;
        bh=cz99d7VnCSzayawBtX02NKhGh1MPuM8LousFrM8rWO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nur2kTuKF2C7fIttF4ho3dt9RM0yi9+NaXYXKdNq7XxeF2pbzA2KdoYM6VqgMX7mH
         tKEA7a6rMKCShzTVzzjd9b1tQXIl5+CJbrs/UNj1kV2YFed32ieOG73RxUBY1QvHFZ
         w/1FEW/Tl02O/oZmD0PQVbPPUzG2pubZ97z+02bU=
Date:   Thu, 28 Nov 2019 18:44:44 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Yunhao Tian <18373444@buaa.edu.cn>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: v3s: Fix incorrect number of hw_clks.
Message-ID: <20191128174444.ypkqrbsge7g3t6mg@gilmour.lan>
References: <20191125125833.8023-1-18373444@buaa.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2vgvz5ipypry7sum"
Content-Disposition: inline
In-Reply-To: <20191125125833.8023-1-18373444@buaa.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2vgvz5ipypry7sum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 25, 2019 at 08:58:32PM +0800, Yunhao Tian wrote:
> The hws field of sun8i_v3s_hw_clks has only 74
> members. However, the number specified by CLK_NUMBER
> is 77 (= CLK_I2S0 + 1). This leads to runtime segmentation
> fault that is not always reproducible.
>
> This patch fixes the problem by specifying correct clock number.
>
> Signed-off-by: Yunhao Tian <18373444@buaa.edu.cn>

Queued as a fix, thanks!
Maxime
>

--2vgvz5ipypry7sum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXeAHjAAKCRDj7w1vZxhR
xZ9EAQD4x+F88mtI2oJSbsrjcUafFH0q/ESBzvhi8Ii8aB8kXgD9FkwUCrG7y4di
Qe+I/O7uhmYsoZBb8fRi+ku/eDY9ywE=
=FAhq
-----END PGP SIGNATURE-----

--2vgvz5ipypry7sum--
