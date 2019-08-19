Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE8494CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 20:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfHSS1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 14:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbfHSS1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:27:31 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E14B22CF5;
        Mon, 19 Aug 2019 18:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566239249;
        bh=T6MbYST0Y+M3UBooFmVzIiLfpDqy4T6s/zqDGdFpXGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4iLOurdcx7gNRxvezPCn8jFlaNZg/a4tNzAUYh/EkweINiaQAot3V/puHFFG5veu
         Eb/ltmyrJm35BhR+xTTuZ04fiqwD4hKie7ZBE3X02oAQnfaSMcfILzn3JpGt1Kg4YX
         pewyCCuwIouHrwCI1g1Hb3GTfP1S96kpHXGY7Nrw=
Date:   Mon, 19 Aug 2019 20:27:26 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: mfd: Convert Allwinner GPADC bindings
 to a schema
Message-ID: <20190819182726.7se7vexlftybsqlz@flea>
References: <20190813124744.32614-1-mripard@kernel.org>
 <CAL_Jsq+QxsxxCsaJ8GjSQhKVHnas3WqjOPnv86=-fWs143CUQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cqozu4ph2avfiavn"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+QxsxxCsaJ8GjSQhKVHnas3WqjOPnv86=-fWs143CUQg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cqozu4ph2avfiavn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 13, 2019 at 03:28:01PM -0600, Rob Herring wrote:
> On Tue, Aug 13, 2019 at 6:47 AM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > From: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > The Allwinner SoCs have an embedded GPADC that is doing thermal reading as
> > well, supported in Linux, with a matching Device Tree binding.
> >
> > Now that we have the DT validation in place, let's convert the device tree
> > bindings for that controller over to a YAML schemas.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  .../iio/adc/allwinner,sun8i-a33-ths.yaml      | 43 +++++++++++
> >  .../bindings/mfd/allwinner,sun4i-a10-ts.yaml  | 76 +++++++++++++++++++
> >  .../devicetree/bindings/mfd/sun4i-gpadc.txt   | 59 --------------
> >  3 files changed, 119 insertions(+), 59 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun8i-a33-ths.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mfd/allwinner,sun4i-a10-ts.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--cqozu4ph2avfiavn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVrqDgAKCRDj7w1vZxhR
xe/QAQCdjHYyPT1sbZs3doytGQ893nBVcEEfzd/iGm9+jIBxGQD/QEk4vLmUXEEu
fopc6mLQNzKp3ZMuCE3WzEnc5wQU+Qc=
=yYiT
-----END PGP SIGNATURE-----

--cqozu4ph2avfiavn--
