Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61FA2B4BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 12:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfIQK2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 06:28:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41214 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfIQK2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:28:43 -0400
Received: from [5.158.153.52] (helo=linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1iAAit-0001sO-Mh; Tue, 17 Sep 2019 12:28:39 +0200
Date:   Tue, 17 Sep 2019 12:28:39 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     John Kacur <jkacur@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, sebastian@breakpoint.cc,
        tglx@linutronix.de, rostedt@goodmis.org
Subject: Re: [PATCH] rt-tests: backfire: Don't include asm/uaccess.h directly
Message-ID: <20190917102839.GC7439@linutronix.de>
References: <20190903191321.6762-1-sultan@kerneltoast.com>
 <alpine.LFD.2.21.1909162356500.10273@planxty>
 <20190917071546.GA27627@sultan-box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <20190917071546.GA27627@sultan-box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Sep 17, 2019 at 09:15:46AM +0200, Sultan Alsawaf wrote:
> On Mon, Sep 16, 2019 at 11:57:32PM +0200, John Kacur wrote:
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> > But please in the future
> > 1. Don't cc lkml on this
> > 2. Include the maintainers in your patch
>
> Hi,
>
> Thanks for the sign-off. I was following the instructions listed here:
> https://wiki.linuxfoundation.org/realtime/communication/send_rt_patches

I guess, that's for rt kernel patches.

>
> I couldn't find any documentation of how to send patches for
> rt-tests. Is there a different set of patch submission instructions on
> a wiki somewhere I missed?

For rt-tests see the top level MAINTAINERS file on how to send patches.

>
> Thanks,
> Sultan

Thanks,
Kurt

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl2AtVYACgkQeSpbgcuY
8KbjgRAAqIGAUDYtUX57F1jbDojgEUgq1z5DDSLezvupLgkRKia+vBqIzmjkKOYp
bPtsSwx/RfjF4XRhxZ/x9oD5Ven+Ph0zEhfpsZSGZ7W6+/tWTHqz6yBFzg5glOgr
xJRmAgPmeDmFGgaTCgLg0G5iEfBkYmHXVtN2h1ql36lvf1Ugk97jagUL0xKEo3CX
m5DawfgMFDhvw8jbI2qUmhzWsdkKlgVxn3CF+nlNfnefejOtpTWivLCXhPBLNToO
+PCej6YOx+8iLKWFfBQiA4/PYUPxefT+tjRnLgIFA3+HyM0ZFZuRReyOVYTSQE8a
eBRSyfsz3aC6Y1TmAxFQGM9D+Zn/7sfIdnxuRXGwPXdCQ/Rh8Y//iSY3Nz4RmD8t
UdICtELEket5bvzj7LerCjvqLjbFe0InWG7IjPXFYX6U1EfHhVOZU5C6zO3x9XrY
R2h1dhnmkjoKquiOUQ09uOVWIUxOEmq+rMLCH+GYFIBWLMby4idnpb7ajXOCOW/I
EIROSO+YN+GMWFX5XvDIJno0ppewWrtUuK+/gre1HZRBm7JcEGa85QMTvslhQw4E
14B2Co3eFb1hzrjSSBt4Iovcjz2fxTnAkRrKTPYmP8s+oy0L85dA7PhnDLnwy1wS
9PXfStGegz3NR14rOsT5KRt/5AXUz//tWm24Jj0UCm5izWfgDio=
=BQxl
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
