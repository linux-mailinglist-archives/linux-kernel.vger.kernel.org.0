Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9FD196B2E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 06:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgC2EgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 00:36:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46482 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgC2EgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 00:36:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id q3so6788724pff.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 21:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=U9U2s/ApQcac72IZ2HP3U3DWZF0cUtSUpml9NrT28Rg=;
        b=T49Vzzh/S2jqo7XZviOM2ccpsSvguSNtHSjIWDxHkZrD6CVPSD5jy1vA3wtV+i56L7
         E3sx9ELfiL4CGDeAUic8zRNl1jGR4fddICpeo4Vdpm/kIItpQKnhDxmdqCY8Ei585yzQ
         XGSJj/ZIdh11ch4vgavTdIFvz0eYjuwoEWTCSxH7XTDS7Dw9TtxPJLQPKfThnCQ01hSS
         gQUEFagF+Y6lMpBlyu/8KsD89d+p0CpluuXEFVho5gjmKlSnsizEHOuzJB+GmbFHTkW9
         9j5lTprB1m1xKU9eassRaK62zijXWz7XAHS5WfaL5bwhHkB/7D4KMdttVO8hm3raexHC
         dpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=U9U2s/ApQcac72IZ2HP3U3DWZF0cUtSUpml9NrT28Rg=;
        b=RnWA9iXGNYYRJWCEFR1TLI+62qk7s44zlb71niHF+aXN2Xq8FRtoiVLYFVWJB5za64
         SXrAe1Dyltu0mOau08+De7Oy1u1fvQ3J+MeEQnRIYRGJ4cOVoYIYodhRU27En8TYumM2
         MPon8uWI84CEKR/+n1yxujYm2/5fwdnWtDwizXML3jM/YxzBeDlG+X13lsyqRdv8W2bl
         QN2fg6ROjqtldx/gColwlOPkuoda2WGwmbElr8PzQfOAqfkM5iYY38Qini+QCNlNVaOT
         Zssl4EKMYjE++Z2J7mClMG5urdPYz8Xk08R1xzNivO00IIBsq0+64U/XMYsf5YoLSgbx
         Z4Uw==
X-Gm-Message-State: ANhLgQ2NYcldCHxYBcyApEEGikTAF4qmfL5jfpS9Gv+3smYSgfTNN20u
        7qBBDV9FN1CGoFsXdjl7Rbx4fd7+6pk=
X-Google-Smtp-Source: ADFU+vtFlv/qPdgEAduYYcaPuIFmdVZwhyM6DH0zrwKA7vQfGCEsZzgiY01ELUAfkdBRT3ARSPpJPA==
X-Received: by 2002:aa7:95a8:: with SMTP id a8mr7047662pfk.61.1585456569031;
        Sat, 28 Mar 2020 21:36:09 -0700 (PDT)
Received: from [192.168.10.175] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id w29sm2890953pge.25.2020.03.28.21.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 21:36:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] ext4: Fix incorrect group count in ext4_fill_super error message
Date:   Sat, 28 Mar 2020 22:36:07 -0600
Message-Id: <471D6886-24DF-4AC2-A5F2-DBE7C2B97AE8@dilger.ca>
References: <20200329024709.GK53396@mit.edu>
Cc:     Josh Triplett <josh@joshtriplett.org>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>
In-Reply-To: <20200329024709.GK53396@mit.edu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You missed the v2 patch, which was better IMHO.=20

Cheers, Andreas

> On Mar 28, 2020, at 20:47, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
> =EF=BB=BFOn Sat, Mar 28, 2020 at 02:54:01PM -0700, Josh Triplett wrote:
>> ext4_fill_super doublechecks the number of groups before mounting; if
>> that check fails, the resulting error message prints the group count
>> from the ext4_sb_info sbi, which hasn't been set yet. Print the freshly
>> computed group count instead (which at that point has just been computed
>> in "blocks_count").
>>=20
>> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
>> Fixes: 4ec1102813798 ("ext4: Add sanity checks for the superblock before m=
ounting the filesystem")
>=20
> Applied, with a fix to the format string:
>=20
>> fs/ext4/super.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 0c7c4adb664e..7f5f37653a03 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -4288,7 +4288,7 @@ static int ext4_fill_super(struct super_block *sb, v=
oid *data, int silent)
>>    if (blocks_count > ((uint64_t)1<<32) - EXT4_DESC_PER_BLOCK(sb)) {
>>        ext4_msg(sb, KERN_WARNING, "groups count too large: %u "
>=20
> s/%u/%llu/
>=20
>>               "(block count %llu, first data block %u, "
>> -               "blocks per group %lu)", sbi->s_groups_count,
>> +               "blocks per group %lu)", blocks_count,
>>               ext4_blocks_count(es),
>>               le32_to_cpu(es->s_first_data_block),
>>               EXT4_BLOCKS_PER_GROUP(sb));
>> --=20
>> 2.26.0
>=20
>                        - Ted
