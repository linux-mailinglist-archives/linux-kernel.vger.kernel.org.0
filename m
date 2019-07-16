Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1C6A24A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 08:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfGPGmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 02:42:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37691 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfGPGmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 02:42:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45nrRV1Ym4z9sDB;
        Tue, 16 Jul 2019 16:42:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563259334;
        bh=nKEQ7e6O/+0WA2v8gOVeMzIpIdbbdwt5phCY55pYV40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ikjoWOSWALlOGyQzQsVa2fZcmcQ5uHuNr8xcK/GhrVRC8P+JMHt3JKEQK5nd9uTkM
         fjpg3lZSIiRfxnC9dZHhEGqe3E09VlshM1Zrj4hEydnBVprfZDL9iohETUn740evDn
         wmX0uckmZl68cjtff9Yyq1VnHCzTpLVmXnGiTpkO0Difyjm7b7e+jXr5dFXaBjANqy
         a39CMUWlWAJleyjz/vbBMb4a+VyL3bIX4zrWn0lEwooDSNOoCykI1kiqgh3S5k5/lX
         Fq+Du1ckG8lzvPpvEKSHQmg6dtAPccv9yiYlgBa8rPMqn+JBzZ8huvSPW0QfTH4VtS
         DEKB9xvAWL/qg==
Date:   Tue, 16 Jul 2019 16:42:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kbuild tree
Message-ID: <20190716164213.2a4be42a@canb.auug.org.au>
In-Reply-To: <CAK7LNASwwOo13p+GgVZ7txiNH4fpb7himmsDHHoQnfnraPZxHw@mail.gmail.com>
References: <20190716143121.3027ef58@canb.auug.org.au>
        <CAK7LNASwwOo13p+GgVZ7txiNH4fpb7himmsDHHoQnfnraPZxHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iDoR2uuX4KeLgbWaBYs1DdL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iDoR2uuX4KeLgbWaBYs1DdL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Tue, 16 Jul 2019 13:59:51 +0900 Masahiro Yamada <yamada.masahiro@socione=
xt.com> wrote:
>
> For the build error, I will fix it as follows for tomorrow's linux-next:

Thanks for the quick response.

--=20
Cheers,
Stephen Rothwell

--Sig_/iDoR2uuX4KeLgbWaBYs1DdL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0tccUACgkQAVBC80lX
0GwBOQf/a85zHE2KpLllV6MYBhyOWH4NwV1ztDZKkUkiFoGsh9x8jERQ+5Ccj/Hc
mhLux10CMPExt07NgBlTKzDeFHtVeXYSb6HKo5v7f0zusbEPuXGUkGbnaN6rBNkS
/Ds0Hght8q+86SQtyEg1gBcZmUQ/G13wrTdmKUO3MBHrMzs0gt2nk5EcL4ihAVjI
DRIxlJSLwAKAEmnPPtOT7GltuI+nAVWJay3XF9YO3wUHIk3g875RrW1cTI1Opzf7
J1oyUJc70K1ghkJjZjUcRXypwn2CQ4zAEQcbTHXuZYl4KW4q+XR70HM/4AlRarIr
vjzWctTONz9T7+uHSDI3gpLSO+HDzw==
=DJrj
-----END PGP SIGNATURE-----

--Sig_/iDoR2uuX4KeLgbWaBYs1DdL--
