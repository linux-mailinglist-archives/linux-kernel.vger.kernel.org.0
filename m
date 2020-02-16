Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 238EF1606EB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 23:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgBPWdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 17:33:53 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:57009 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgBPWdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 17:33:53 -0500
Received: from neuling.org (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id 48LMNG3cXPz9sPk;
        Mon, 17 Feb 2020 09:33:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
        s=201811; t=1581892431;
        bh=IzVd3zz9l6kPQTSe8Nj+Ga0PypI0I2VtiI7TPnVOQrY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=izLMkKNKro+4UaU4NyZyvFFwQxyAvV8WHby0/+sU16FohAkhCP8xpodCbETwQD4H+
         Kbf5T+Sltm6K5SG7jU03OfXdEcvMoYnWbqk3qQtKTMEaEIjqlOvu/z7+ULva/ILRm0
         A2nOGCJidPEC6Unmb1ho0W5lQMI5ZScWTAC4Ce/8n4M2gMdGfbvJuGK6WNknf1hkXg
         IcjRwX4qaH/u0dwUeDgY6sn+ejB/zd+Xce1n7lp4BnpsCaanSUe02Ewd/v2RTSnFIM
         VMSPrl7+RcB5nGZadKVKhkY9QebfoBRaxC0ynLtIjfyn1SKKbsfkcj8eo9AdIdNQAT
         nd1nCAkuHeJQA==
Received: by neuling.org (Postfix, from userid 1000)
        id F1D392C01ED; Mon, 17 Feb 2020 09:33:49 +1100 (AEDT)
Message-ID: <f61f9a59ddb0f103cd62792e13afde4ca8afa7bb.camel@neuling.org>
Subject: Re: [PATCH 1/1] powerpc/cputable: Remove unnecessary copy of
 cpu_spec->oprofile_type
From:   Michael Neuling <mikey@neuling.org>
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, desnesn@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Feb 2020 09:33:49 +1100
In-Reply-To: <20200215053637.280880-1-leonardo@linux.ibm.com>
References: <20200215053637.280880-1-leonardo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-15 at 02:36 -0300, Leonardo Bras wrote:
> Before checking for cpu_type =3D=3D NULL, this same copy happens, so doin=
g
> it here will just write the same value to the t->oprofile_type
> again.
>=20
> Remove the repeated copy, as it is unnecessary.
>=20
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>

LGTM

Reviewed-by: Michael Neuling <mikey@neuling.org>

> ---
>  arch/powerpc/kernel/cputable.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputabl=
e.c
> index e745abc5457a..5a87ec96582f 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -2197,7 +2197,6 @@ static struct cpu_spec * __init setup_cpu_spec(unsi=
gned
> long offset,
>  		 */
>  		if (old.oprofile_cpu_type !=3D NULL) {
>  			t->oprofile_cpu_type =3D old.oprofile_cpu_type;
> -			t->oprofile_type =3D old.oprofile_type;
>  		}
>  	}
> =20

