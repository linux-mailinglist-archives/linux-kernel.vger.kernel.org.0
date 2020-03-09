Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E07617DCF5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 11:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCIKJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 06:09:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52425 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIKJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:09:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id p9so9123928wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 03:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=jhiA0jU3jkwooH/Ee+/2xG0gT1FLQp035uDQRSw0hic=;
        b=B6l0/V37hlODu+FdI/EgswQJHx32Nt1csCDzDvcKqEbwXAvRRF207+O2wyshNeRM48
         AZWLRBsAP1e/p254AVaihm5foJfGLR2lY2qtsG9DWQlYC2j86n2Ame2p/34W8fjOLdnM
         zGjSbXemyF4WcJ12jzJ7v5dkT37qC0HWVJA0Y2RjN35Hy/Lr2uXh1bClaahPkO1k299n
         cGU+ZqpmuyT/FlJVqK0xLbJP6sDGwtMHgVmFdYQittyq//sskg50vn3jIskfxrLT62A0
         Xaw4Kjz7BF5EqKMNWAEo5WFVHESv1SlyguFKAjvDfdbsOw0M8YU44n0ApB9o5C6VIbLg
         wM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=jhiA0jU3jkwooH/Ee+/2xG0gT1FLQp035uDQRSw0hic=;
        b=WBjJrKiAPd4jj7RALwlNHBnXrfPuzBrNIF3IjWsKZ18lSymMMBnL3uKAuMbTUtdbO4
         JqVGqamcp6MZCyide0XgWHwqVTn2DPQMVGjuLTpqE9achDKzeTvbj9QeIboHIcHz8L61
         zQgmTLEuErXcagRtqGeSpSDkITCsPNS59F6Qgl9PchG6M1tuLjHun3/pzVQbm+6V9tk4
         mrV0kDnF4vDts2HcuXYTA4q6aXBSpR2aP3sh4z4xggO2UYXF8f+eQzzZLJkDSHjlhWnv
         WZFOJDasxttExXhMdNyVOOCEgwpoo0y64kulhiGLY72Krjc8/oeDt67gQMcoPZYiefsX
         TUGA==
X-Gm-Message-State: ANhLgQ3XXqO3vcxUxKfp29XsFhbAdrom+3fnOCt/0bYOOuAmeUsnzXJc
        jAAuZqfAY+C9MutPr1e6qupF03EgEaiI7Q==
X-Google-Smtp-Source: ADFU+vusb9h9FP9GhIt6ARpS8VcmTseFWwN3ZI3B+KGPbWWNAlJGv/e96HBUX6TeWbuzwWMXnkhhUA==
X-Received: by 2002:a05:600c:d4:: with SMTP id u20mr10746682wmm.169.1583748563278;
        Mon, 09 Mar 2020 03:09:23 -0700 (PDT)
Received: from [173.194.76.109] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id n11sm27363301wrw.11.2020.03.09.03.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 03:09:22 -0700 (PDT)
Subject: Re: [PATCH] microblaze: Stop printing the virtual memory layout
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
References: <202003021038.8F0369D907@keescook>
 <20200305150503.833172-1-nivedita@alum.mit.edu>
From:   Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <2a382a84-a158-e25f-c840-f64808654fcf@monstr.eu>
Date:   Mon, 9 Mar 2020 11:09:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305150503.833172-1-nivedita@alum.mit.edu>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LMlICqJZtglJAKOLiCil9JHcBCiYoPyBw"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LMlICqJZtglJAKOLiCil9JHcBCiYoPyBw
Content-Type: multipart/mixed; boundary="Bv63CJYIydNpaVy4JuKEiH36gxOGZOvmn";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Arvind Sankar <nivedita@alum.mit.edu>, Kees Cook <keescook@chromium.org>
Cc: "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
 kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Message-ID: <2a382a84-a158-e25f-c840-f64808654fcf@monstr.eu>
Subject: Re: [PATCH] microblaze: Stop printing the virtual memory layout
References: <202003021038.8F0369D907@keescook>
 <20200305150503.833172-1-nivedita@alum.mit.edu>
In-Reply-To: <20200305150503.833172-1-nivedita@alum.mit.edu>

--Bv63CJYIydNpaVy4JuKEiH36gxOGZOvmn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05. 03. 20 16:05, Arvind Sankar wrote:
> For security, don't display the kernel's virtual memory layout.
>=20
> Kees Cook points out:
> "These have been entirely removed on other architectures, so let's
> just do the same for ia32 and remove it unconditionally."
>=20
> 071929dbdd86 ("arm64: Stop printing the virtual memory layout")
> 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout=
")
> 31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
> fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
> adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_re=
served_area()")
>=20
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/microblaze/mm/init.c | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> index 1056f1674065..8323651bf7ec 100644
> --- a/arch/microblaze/mm/init.c
> +++ b/arch/microblaze/mm/init.c
> @@ -201,18 +201,6 @@ void __init mem_init(void)
>  #endif
> =20
>  	mem_init_print_info(NULL);
> -#ifdef CONFIG_MMU
> -	pr_info("Kernel virtual memory layout:\n");
> -	pr_info("  * 0x%08lx..0x%08lx  : fixmap\n", FIXADDR_START, FIXADDR_TO=
P);
> -#ifdef CONFIG_HIGHMEM
> -	pr_info("  * 0x%08lx..0x%08lx  : highmem PTEs\n",
> -		PKMAP_BASE, PKMAP_ADDR(LAST_PKMAP));
> -#endif /* CONFIG_HIGHMEM */
> -	pr_info("  * 0x%08lx..0x%08lx  : early ioremap\n",
> -		ioremap_bot, ioremap_base);
> -	pr_info("  * 0x%08lx..0x%08lx  : vmalloc & ioremap\n",
> -		(unsigned long)VMALLOC_START, VMALLOC_END);
> -#endif
>  	mem_init_done =3D 1;
>  }
> =20
>=20

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--Bv63CJYIydNpaVy4JuKEiH36gxOGZOvmn--

--LMlICqJZtglJAKOLiCil9JHcBCiYoPyBw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXmYVyQAKCRDKSWXLKUoM
IciuAJ4hUJY9rq6DDTTRiJZfb2yWl6rregCfSkutEhxvq9GlCqWIXqVj3dbM0kc=
=/fQ9
-----END PGP SIGNATURE-----

--LMlICqJZtglJAKOLiCil9JHcBCiYoPyBw--
