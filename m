Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39BE2A9E24
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 11:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbfIEJUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 05:20:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732407AbfIEJUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:20:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6C28300BEAD;
        Thu,  5 Sep 2019 09:20:41 +0000 (UTC)
Received: from localhost (ovpn-117-222.ams2.redhat.com [10.36.117.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3589119C6A;
        Thu,  5 Sep 2019 09:20:41 +0000 (UTC)
Date:   Thu, 5 Sep 2019 10:20:39 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be
 decoded
Message-ID: <20190905092039.GG32415@stefanha-x1.localdomain>
References: <20190904180736.29009-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline
In-Reply-To: <20190904180736.29009-1-xypron.glpk@gmx.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 05 Sep 2019 09:20:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2019 at 08:07:36PM +0200, Heinrich Schuchardt wrote:
> If an application tries to access memory that is not mapped, an error
> ENOSYS, "load/store instruction decoding not implemented" may occur.
> QEMU will hang with a register dump.
>=20
> Instead create a data abort that can be handled gracefully by the
> application running in the virtual environment.
>=20
> Now the virtual machine can react to the event in the most appropriate
> way - by recovering, by writing an informative log, or by rebooting.
>=20
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  virt/kvm/arm/mmio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/virt/kvm/arm/mmio.c b/virt/kvm/arm/mmio.c
> index a8a6a0c883f1..0cbed7d6a0f4 100644
> --- a/virt/kvm/arm/mmio.c
> +++ b/virt/kvm/arm/mmio.c
> @@ -161,8 +161,8 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_ru=
n *run,
>  		if (ret)
>  			return ret;
>  	} else {
> -		kvm_err("load/store instruction decoding not implemented\n");
> -		return -ENOSYS;
> +		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
> +		return 1;

I see this more as a temporary debugging hack than something to merge.

It sounds like in your case the guest environment provided good
debugging information and you preferred it over debugging this from the
host side.  That's fine, but allowing the guest to continue running in
the general case makes it much harder to track down the root cause of a
problem because many guest CPU instructions may be executed after the
original problem occurs.  Other guest software may fail silently in
weird ways.  IMO it's best to fail early.

Stefan

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1w02cACgkQnKSrs4Gr
c8iE9ggAkVjIf2fI/kBs4N9RcmSgCefJV12cMWzxOU0i+Z3Z6eMCCf3aDRvN5Znu
AO5aNxnimfSJ/yP1Zp1qZjeSdPpsMs5ox3CXdHmNOAEtzTb5tC4NeSvVeP1MaCi8
LzpKOB7uZpZVulFwf9vuWcMww/LBIP0AwJSQ9MWUJncQ3UMZd3vNXXfD8QlnECVd
alfe2r6hsp3ijEdkLLx92pNOl3/sgeFiK7WRQ07hrQHh2jJ9h2kZslsEZHeEsaj5
CLuPe76KL4o25UFhS17Cg3hTsROX2BBgYub5uY+K02b54bVY2X3ypNE80H91ip+k
VKuTCZk89Bpnyb3Shu6NIhJskSO1PA==
=tj/0
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
