Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C215B12E469
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 10:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgABJ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 04:29:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgABJ3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:29:02 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F43C20866;
        Thu,  2 Jan 2020 09:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577957341;
        bh=pRLLWLshpdZaj7aSje6TIFcK62XHUMhFH6uF34UjPWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qioH68TnAGoz6R8XezA9BL4hVOWCriMkL0fN0Za0boFI4yM/swDLfcwRPWMzCKTuf
         HKyYkBgMbDNYXcGEt9krDRjxThh6owzoXQTFPIqw6l9EWGkVB88gT9Iq8HryEjmuSf
         4p9Sg6GPF0yHKPT05z79Rtav8FmyWoZYSwJwxCqo=
Date:   Thu, 2 Jan 2020 10:28:58 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/3] A64/H3/H6 R_CCU clock fixes
Message-ID: <20200102092858.6n5uqymglia4t7lk@gilmour.lan>
References: <20191229025922.46899-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gk2aam5hdxft2et4"
Content-Disposition: inline
In-Reply-To: <20191229025922.46899-1-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gk2aam5hdxft2et4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 28, 2019 at 08:59:19PM -0600, Samuel Holland wrote:
> Hi all,
>
> I was examining the H6 BSP clock driver[1] for guidance when porting an
> AR100 firmware[2] to the H6 SoC. I found some inconsistencies between
> that code and the sunxi-ng driver.
>
> I don't have a good way to verify the first patch. Someone with an
> oscilloscope could set the divider and check the I2C/RSB frequency.
>
> Patch 2 should have no functional change.
>
> Patch 3 was verified by benchmarking. Details are in the commit message.

Applied all three, thanks
Maxime

--gk2aam5hdxft2et4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg232gAKCRDj7w1vZxhR
xR/OAP9JY57TmyxiCqTZ5rQ+jSsbbgBIlK0MUpFXFJ60USVATgD+LwMfTzcDLCvz
GjShAjhcGPUCGqkJC8XOg5DyklsoFAo=
=gy/O
-----END PGP SIGNATURE-----

--gk2aam5hdxft2et4--
