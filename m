Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C722161E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 01:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgBRAkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 19:40:24 -0500
Received: from ozlabs.org ([203.11.71.1]:50255 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgBRAkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 19:40:23 -0500
Received: from neuling.org (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id 48M27j6S7gz9sRG;
        Tue, 18 Feb 2020 11:40:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
        s=201811; t=1581986421;
        bh=a0CFJXOA/uHY0JLhnZ7YRoOw1DBU5yBkXfyphVoZqaw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=riURPvaOIY/l3TBvQIHGCqvUskxenUh/6gsfrm9JOnY0Wn5ee7mhK17nN5HqmLI3w
         FRgy96RTFxnr43ast5mbiADEaCxKowK+zpBH9cSck1QMhYmmpTR/jc+JlY6BQX3Nbg
         zo4yGVR79WhyRkWzRMIioZnl2lE0xzD0FXrF5vX1CJnmRPZKNg0uExWgllZRo+Gt2N
         x05gFp1mZpvDlNuqZtgsDNbx1OYxjv0kkj2Js0qU3qU6lxoeYdZXWT2sduaoruRwtD
         SIFEERFL+Kd/cu4zfd5Uz1rUqGFMWDaxUcTZETl8yw/HGXs+eenjd3c7GcDyEtVE48
         SDLKlx6eVJMUA==
Received: by neuling.org (Postfix, from userid 1000)
        id D6F952C01C8; Tue, 18 Feb 2020 11:40:16 +1100 (AEDT)
Message-ID: <99897b3e22a9131c22c0d9c36bee3d55bff3336b.camel@neuling.org>
Subject: Re: [PATCH] powerpc/chrp: Fix enter_rtas() with CONFIG_VMAP_STACK
From:   Michael Neuling <mikey@neuling.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 11:40:16 +1100
In-Reply-To: <40126489-adf8-1b65-8974-25bca584bc9b@c-s.fr>
References: <159ecb0ab021c07fd2f383d4a083a43d16d67b92.1581669187.git.christophe.leroy@c-s.fr>
         <04cdd26307a1eaebeacc039b207db92e0b6820bb.camel@neuling.org>
         <40126489-adf8-1b65-8974-25bca584bc9b@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-17 at 07:40 +0100, Christophe Leroy wrote:
>=20
> Le 16/02/2020 =C3=A0 23:40, Michael Neuling a =C3=A9crit :
> > On Fri, 2020-02-14 at 08:33 +0000, Christophe Leroy wrote:
> > > With CONFIG_VMAP_STACK, data MMU has to be enabled
> > > to read data on the stack.
> >=20
> > Can you describe what goes wrong without this? Some oops message? rtas =
blows
> > up?
> > Get corrupt data?
>=20
> Larry reported a machine check. Or in fact, he reported a Oops in=20
> kprobe_handler(), that Oops being a bug in kprobe_handle() triggered by=
=20
> this machine check.
>=20
> By converting a VM address to a phys-like address as if is was linear=20
> mem, you get in the dark. Either there is some physical memory at that=
=20
> address and you corrupt it. Or there is none and you get a machine check.

Excellent. Please put that in the commit message.

> > Also can you say what you're actually doing (ie turning on MSR[DR])
>=20
> Euh ... I'm saying that data MMU has to be enabled, so I'm enabling it.

Yeah, it's a minor point.

> >=20
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > ---
> > >   arch/powerpc/kernel/entry_32.S | 9 +++++++--
> > >   1 file changed, 7 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/powerpc/kernel/entry_32.S
> > > b/arch/powerpc/kernel/entry_32.S
> > > index 0713daa651d9..bc056d906b51 100644
> > > --- a/arch/powerpc/kernel/entry_32.S
> > > +++ b/arch/powerpc/kernel/entry_32.S
> > > @@ -1354,12 +1354,17 @@ _GLOBAL(enter_rtas)
> > >   	mtspr	SPRN_SRR0,r8
> > >   	mtspr	SPRN_SRR1,r9
> > >   	RFI
> > > -1:	tophys(r9,r1)
> > > +1:	tophys_novmstack r9, r1
> > > +#ifdef CONFIG_VMAP_STACKisntruction
> > > +	li	r0, MSR_KERNEL & ~MSR_IR	/* can take DTLB miss */
> >=20
> > You're potentially turning on more than MSR DR here. This should be cle=
ar in
> > the
> > commit message.
>=20
> Am I ?
>=20
> At the time of the RFI just above, SRR1 contains the value of r9 which=
=20
> has been set 2 lines before to MSR_KERNEL & ~(MSR_IR|MSR_DR).
>=20
> What should be clear in the commit message ?

You're right. I was just looking at the patch and not the code. It's cleare=
r in
the code.

Mikey

>=20
> > > +	mtmsr	r0
> > > +	isync
> > > +#endif
> > >   	lwz	r8,INT_FRAME_SIZE+4(r9)	/* get return address */
> > >   	lwz	r9,8(r9)	/* original msr value */
> > >   	addi	r1,r1,INT_FRAME_SIZE
> > >   	li	r0,0
> > > -	tophys(r7, r2)
> > > +	tophys_novmstack r7, r2
> > >   	stw	r0, THREAD + RTAS_SP(r7)
> > >   	mtspr	SPRN_SRR0,r8
> > >   	mtspr	SPRN_SRR1,r9
>=20
> Christophe
>=20

