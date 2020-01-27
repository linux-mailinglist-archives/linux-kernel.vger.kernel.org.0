Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71BA714A2F4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 12:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgA0LXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 06:23:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:40956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgA0LXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:23:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AE5BBB119;
        Mon, 27 Jan 2020 11:06:54 +0000 (UTC)
Message-ID: <f66483db33f8c190030ba0b66e0d85e549691cf0.camel@suse.de>
Subject: Re: [PATCH 06/22] staging: vc04_services: get rid of
 vchiq_platform_use_suspend_timer()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Date:   Mon, 27 Jan 2020 12:06:53 +0100
In-Reply-To: <20200124144617.2213-7-nsaenzjulienne@suse.de>
References: <20200124144617.2213-1-nsaenzjulienne@suse.de>
         <20200124144617.2213-7-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jfVbXwfzGkRKU6Ms0WbO"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jfVbXwfzGkRKU6Ms0WbO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-01-24 at 15:46 +0100, Nicolas Saenz Julienne wrote:
> @@ -3059,7 +2986,6 @@ vchiq_check_service(struct vchiq_service *service)
>  			arm_state->videocore_use_count,
>  			suspend_state_names[arm_state->vc_suspend_state +
>  						VC_SUSPEND_NUM_OFFSET]);
> -		vchiq_dump_service_use_state(service->state);
>  	}
>  out:
>  	return ret;

As highlighted by the kbuild test robot, this shouldn't be removed. Sorry i=
t
slipped through the cracks. Happened because of it similarities with
vchiq_dump_platform_use_state(), which is being rightfully removed.

I'll give some time for further feedback, and send a v2.

Regards,
Nicolas


--=-jfVbXwfzGkRKU6Ms0WbO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4uxE0ACgkQlfZmHno8
x/7IcwgAlexqcFZf/vJCGPkHlxL6iHIKlCfhykAprlaYxplMz0io9YbfEMoxiaKj
tuttGtiS8cVZgpJpMQA76Rc0iz6m05eSOxnLnxj1s7l9NTFobSU9BA06HsA1Hgg6
h7GcQ/N71IY7vADTVX2zYWTt91KNKtBR5MBgJjudSe3E//DSHyC2SGOe3ZEWnjos
2JKz/rW9X8bqTiaxS7e6YBzgd5ZRuuHVFWQ0iujbo+ymCiItZ1XeI3CxfkpJIdjn
5y3vcKQkoMbWKaoKfQ9UlPdFHhacB28ukVCCcZPAQ3nCHCOYgteDrEtHmhu0Xive
zkSOKBZTUF2Ku9R9JWUmDa3lqph9vg==
=WPcc
-----END PGP SIGNATURE-----

--=-jfVbXwfzGkRKU6Ms0WbO--

