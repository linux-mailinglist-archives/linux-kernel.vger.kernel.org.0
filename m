Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED4D6E3B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440087AbfJXSjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 14:39:24 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:53596 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2437068AbfJXSjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:39:23 -0400
Received: from mr2.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OIdMkE006203
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 14:39:22 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OIdH9d027299
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 14:39:22 -0400
Received: by mail-qk1-f199.google.com with SMTP id c13so10939850qko.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=FwSLNB4gLqTCUzGzpu5ntWSTbDDl547fVQ4GSLs4ks8=;
        b=ft0MrPRm7DJ0+Ts0FED24QOMF8ZdJTGKx9a8ylq/VMy+QX5ID/dzsqAaknhAo2uWRn
         M1h/qBSOM2M88bNS08U5bEw5q8/GnAxPQRqtNdGhfIWa+VCurInR6O62dbqb7CJeEy6O
         emrRFQ8C+OwENJSGbhiCCMa7bhhYyvsxItseAwJluO5NCLmivJbZoBYcGEg6/f2tXMBt
         PKDjFp1lRjg3P/BvlHT6QEl29h4fJijSbP+IOG9SdiFA0eK4QWkB/vSZmswQ0HlTntBT
         f80YCFkDSi8v0gBSvQEvNZM3GvNGK9PN3KapQwDOgzDSZhZpOa1QwVK67ETFw1LZjoBS
         tb6w==
X-Gm-Message-State: APjAAAWxkkY9Du3/1V5tlWxQfXxd5sFYk7395VXWsOL6qCxLsd8GpQ7T
        ZhQljlAlhVDDQWuRQQ1iQVsQneOovc72dM639unv1bcC7NnCBanYJtLecpzFG4xDkDOtbrrRbDh
        8fHPbZvvNrV89RU7rqQUeQdtnhDffj6Cllmo=
X-Received: by 2002:a0c:d4ba:: with SMTP id u55mr16209189qvh.40.1571942356776;
        Thu, 24 Oct 2019 11:39:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyXDYkTW4zAzjxM5nh076WARz6SYTqVuTNsGoolXc3NM51DWiHwaLHa8oSr9nSyJwxvndpB2g==
X-Received: by 2002:a0c:d4ba:: with SMTP id u55mr16209157qvh.40.1571942356375;
        Thu, 24 Oct 2019 11:39:16 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x26sm13565645qto.21.2019.10.24.11.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 11:39:14 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] staging: exfat: Clean up return codes - FFS_FULL
In-Reply-To: <20191024175904.GJ2963@bombadil.infradead.org>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu> <20191024155327.1095907-2-Valdis.Kletnieks@vt.edu>
 <20191024175904.GJ2963@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1571942353_59326P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 14:39:13 -0400
Message-ID: <1151252.1571942353@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1571942353_59326P
Content-Type: text/plain; charset=us-ascii

On Thu, 24 Oct 2019 10:59:04 -0700, Matthew Wilcox said:
> Wouldn't it be better to do this as:

> Patch 1: Change all these defines to -Exxx and remove the stupid errno-changing
> blocks like this:

Well, except for the fact that the one for FFS_MEDIAERR required splitting the
uses into -ENODEV, -EIO, and -ENOENT.

Also, "and remover the stupid blocks" would be a second change, and I *thought*
the rule was "one thing, one patch".

> That way nobody actually needs to review patches 2-n; all of the changes
> are done in patch 1.

Reviewing a patch where you know that exactly one thing is supposed to happen
means scrolling through 14 occurrences of the pattern

 	if (num_alloced == 0)
-		ret = FFS_FULL;
+		ret = -ENOSPC;

goes *really* fast, and those comprise most of the bulk of the patchset.

And as I already mentioned, the "stupid looking blocks" will be removed in
a future patch.

--==_Exmh_1571942353_59326P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXbHv0AdmEQWDXROgAQJ3yhAAtPnqjyl/CmQXoECKh6OtFS+Frw5/Z/Ot
/uz5YmEsw+WOOflm68fgDRmCOb1YPExXZs9nf5vTrG5EhykkSnI0pewk+6ab5luY
Icrn0rhpdka013hfEGlzAyrYv2xorZbhX8u5pvtaFlTC+WJg6du8hiCdzts7RwFJ
jZ5q/pZmjEXlfXK49VAzIgXNeIc7JpFPiWT3gE6HnUqkDK/x/0qIeI+SnJ2cqOql
t1ASkFLjad5yvbmThpQFilhOKuRtS7TL+uIL7xhNsaqh8v5gMvrxSU27CfDj1HPG
cPbgpPgfzp6cGUSMIXFa7OkDAY+vf+1LCV1ohjJhzRoPpM8s1gyj2pJz3NF84MYp
pLc5+IZrYlCddeDnLknFyhtx4NRa+tmMrrjYae7b46al4tApHN/BOkawrsGAFSgw
nsL2g3KbYhdej467kznJcdXB0iU4tQDzc8+q3Hnl9l1DnwTosnxkDJknRZIcHApd
0+LOvvI8fMZYAKMNSUcFOo/rLgyixvtTf5CxUxHWpEIlDGT3WHQoCdFnS5yfBwaO
iYlTysIci+Axye2QsthLuy6LunI6tASyjYGsq3TXnJrDM2c/f59gSWXx7AQtera9
4XpiLeADB66KeiR87teZWBWDh+8j8i0Lq6oSJykj2GAWhk/j23V7gGYDrZfOKgUf
UrkbxjOmVUo=
=1sgu
-----END PGP SIGNATURE-----

--==_Exmh_1571942353_59326P--
