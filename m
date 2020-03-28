Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F011969F5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 00:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgC1XH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 19:07:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36778 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgC1XH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 19:07:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id g2so5072244plo.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 16:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Cjtq4j90KL6u7el5sikBZ4NRH3Gu9CsbJFnMcZ93/58=;
        b=WEcj+C2Rbw6f/llU0YfpA6O9Eili4XB7P77ZYMKWm/4O5FYn7bVR80/QOrukksrSnN
         TE1ISS6hJ6fAaE/f/JB+0aPZXnNxI8OZ6Ik+Uj2MMERZ1FNf9LyWIPqsKPjL/ycZr6/4
         u/1azjrdSa/LaLwHitS6vxWkoxW/vpgJkAJtV84j8TfoUzBnFuszcMw8ZRh3rd3NJWry
         9yzK+pm61zEMnkhNT902insrYymeVBARPK1Ud7cGCC2qu2tgGW9VAuOmlXKDdWK2ldJw
         g2EOdtfXwXDn7sa1c+FFnaReyUvB1DcelObekchvulSCjzZlWOK75yy6TZeCYrP0l239
         yJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Cjtq4j90KL6u7el5sikBZ4NRH3Gu9CsbJFnMcZ93/58=;
        b=bsWOeQ2FVFCBzQhrDTQ/8j79rS0d1FWQUpHDKsWPJaEcTcKZBw9McuG7ruNostaFJL
         4kuQHi16MjaxCnm44gxrKn+0IA3Vlqbj0bN2N/160dflNzjjMtLurvx59xF1UnrDRS35
         4P4XveHdyOWzEBXEqo87wyZgk9HjXzd5INuLJy9XGCHSBSwZAqAX6Rj0AflgKRH7JSAx
         AU7qWlYOn800W1M1EXzPMT3ZLmvICivweXYal+fukPP9iCXe9OP1Ob1aiVRcKNvbd69k
         T6Pi6XDVahuzUm68rAU/+tTEQ2LgDEY7L0VdEyWZ2rfpANHfCVIlN0sfPk97r4H8Tccx
         Te8Q==
X-Gm-Message-State: ANhLgQ2Sl2oCes1+T+BIIpDtsGCOvH+I6HKaGCySOTipYxJbAYEKmtND
        smD7S0mEWVoNQxBnEN8z2wekaQ==
X-Google-Smtp-Source: ADFU+vuO67OM/RJlBZgj2TYLGGKSVN48VEgEdelLbxP/i9CE9BdzbzePo8f0Ruev22XNDxWS+cGGhQ==
X-Received: by 2002:a17:90a:2226:: with SMTP id c35mr7577249pje.2.1585436877875;
        Sat, 28 Mar 2020 16:07:57 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 207sm5436236pgg.19.2020.03.28.16.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 16:07:57 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <04E7F659-18B0-4CD2-8DE9-F69310BC3B06@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2B7A53DC-1CFC-440F-9207-9F623ED30540";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Fix incorrect group count in ext4_fill_super error
 message
Date:   Sat, 28 Mar 2020 17:07:55 -0600
In-Reply-To: <8b957cd1513fcc4550fe675c10bcce2175c33a49.1585431964.git.josh@joshtriplett.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
To:     Josh Triplett <josh@joshtriplett.org>
References: <8b957cd1513fcc4550fe675c10bcce2175c33a49.1585431964.git.josh@joshtriplett.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_2B7A53DC-1CFC-440F-9207-9F623ED30540
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 28, 2020, at 3:54 PM, Josh Triplett <josh@joshtriplett.org> =
wrote:
>=20
> ext4_fill_super doublechecks the number of groups before mounting; if
> that check fails, the resulting error message prints the group count
> from the ext4_sb_info sbi, which hasn't been set yet. Print the =
freshly
> computed group count instead (which at that point has just been =
computed
> in "blocks_count").
>=20
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> Fixes: 4ec1102813798 ("ext4: Add sanity checks for the superblock =
before mounting the filesystem")

Modulo the compiler warning pointed out by kbuild test robot, I think =
the
patch is correct, but was definitely confusing to read within the shown
context, since "blocks_count" definitely doesn't seem to be "groups =
count"
(it *is* the "groups count", but is just used as a temporary variable).

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/super.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0c7c4adb664e..7f5f37653a03 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4288,7 +4288,7 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 	if (blocks_count > ((uint64_t)1<<32) - EXT4_DESC_PER_BLOCK(sb)) =
{
> 		ext4_msg(sb, KERN_WARNING, "groups count too large: %u "
> 		       "(block count %llu, first data block %u, "
> -		       "blocks per group %lu)", sbi->s_groups_count,
> +		       "blocks per group %lu)", blocks_count,
> 		       ext4_blocks_count(es),
> 		       le32_to_cpu(es->s_first_data_block),
> 		       EXT4_BLOCKS_PER_GROUP(sb));
> --
> 2.26.0


Cheers, Andreas






--Apple-Mail=_2B7A53DC-1CFC-440F-9207-9F623ED30540
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5/2MsACgkQcqXauRfM
H+AnOA//V5uFfStVfTWVl2zs4J2jWpYVCG9kzT4xGrYRLk2srDgIklQessjbYYfb
kXvYFep6nBH0IOc3Ry1goyuuU2HiuYNoQe/VC+Wk2azc1RrZ+1IeuZulWJxKgi5b
DAAt0OvlnBRm6DnWB8183pjfrJVoVk+hdH4E0woSVsWb7L0THgp4b20btwd5jDD5
o6a8pecxjuTzpyB3/eVB8LNu5Ja3TCXcaUpQrIFFnGWTRllj74AuglK9nASN62F/
3ZRPHIVG/QOp/uc5Gpr1IB8lSkzG8ehKMgvS7HUB+6zymhmfx2+I+yB1SeAHYVQu
sz4+9vZdpliyInpJDaZPPvOilY2c9zH5hK+LhXnENwbWQxRdxOPU3CjSumYO6spk
/hj/UMcMx1JSDeEKq5CYokPfnZh0B6Qn/WjOsJobID0kM3d2c/5UbiITe3rZ/DkR
bjSaVVlVQ5eZdT8NbOVJ/nmxlxhhHbOm3nA3sKIS47SBbKURseSKJI7LACYdJEN0
/7xVU31zAw857nxMqInE53ghCVFLs8eXL6hsMSc1i7XWN/3hIUcGiGUNffESs7Rm
OuzKT1n8tizaiUQxQNXeNU0bNyaF/TWdQSf9rnNJRou3OWjGEdHE59ObJF7cwRJa
xZe1o5WqvRvj7eYQdqxAWtnmWwcQ5wkZTkWRW3kcU8Rzfdli9Gs=
=p5gJ
-----END PGP SIGNATURE-----

--Apple-Mail=_2B7A53DC-1CFC-440F-9207-9F623ED30540--
