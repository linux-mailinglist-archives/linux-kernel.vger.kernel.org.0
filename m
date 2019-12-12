Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D811CB96
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 11:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfLLK6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 05:58:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:34100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728924AbfLLK56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:57:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6CFDAAEC1;
        Thu, 12 Dec 2019 10:57:56 +0000 (UTC)
Message-ID: <9f0d4eb964f3f18ff18c0c2697ff1a681639ce58.camel@suse.de>
Subject: Re: [PATCH for-5.6 4/4] staging: bcm2835-audio: Drop superfluous
 ioctl PCM ops
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Date:   Thu, 12 Dec 2019 11:57:55 +0100
In-Reply-To: <20191210141356.18074-5-tiwai@suse.de>
References: <20191210141356.18074-1-tiwai@suse.de>
         <20191210141356.18074-5-tiwai@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-g0TJqR5cdhbPOzOoFy6+"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g0TJqR5cdhbPOzOoFy6+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-12-10 at 15:13 +0100, Takashi Iwai wrote:
> PCM core deals the empty ioctl field now as default.
> Let's kill the redundant lines.
>=20
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!


--=-g0TJqR5cdhbPOzOoFy6+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3yHTMACgkQlfZmHno8
x/4wugf+NmAk0UkDbFiLmoISfbHMhP+QF9xsW4TglreylmVopMkzBgb7rGFwpf+c
lYB4ggdHpr4CfCZlYS4C5eKUa6KxCs4cqhQgkJqWkMrSQ3xNWzyrblVr7uA+yz17
3HtdAB6wE83Hh7zrJgvcQPASSXlziK2JryotwDHjpqGixTRAYmAIueTMIiP8j/+Y
SWzx6QZY4CduTjIYjDgOIE+12GB2w4NJ/n4UCJ0nBXF4jth6FE6VbqPqQ2zylgYJ
W/XW/w3yJ1ebgDRmriOGNS2vBG/L8ASuiI4RnnXWa1jLMd75IPnGBAgvIOCRnkQk
NKRgdGsILjMZhoEISnha3z3jvYUmTQ==
=IRls
-----END PGP SIGNATURE-----

--=-g0TJqR5cdhbPOzOoFy6+--

