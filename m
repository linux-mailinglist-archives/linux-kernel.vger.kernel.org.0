Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D761EA97D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 04:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfJaDRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 23:17:10 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:34672 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726465AbfJaDRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 23:17:09 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9V3H7vc010072
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 23:17:07 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9V3H2nh008616
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 23:17:07 -0400
Received: by mail-qt1-f199.google.com with SMTP id v23so4748230qth.20
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 20:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=UjwFl/5kyrrhReHkQKPm1SCGM6jwLyZlLmQqSsl7mww=;
        b=Ur5VnuaQ+Gz6FC61c9ZGzlNBHNsgq6IoCWPXWYAVGFjxKnD93iRgs4iP4vZCT/8wVS
         Y/UqZ/1NIrz3LL+CUrIZszPNeTfN8EywYF7RXLF+WjrBBZVb59SzAiT6+PNFPwkI2rst
         l997tJm9SoPy5p6Z6XJcviHkPl4qiZF7dMpJICzpZW/RxKjMKUAf+eej8l3mMsYbznHe
         rHMhtRRkw+DoKRvBx7e35OFply3ePEqHkskRgAhA34CIPg4N5kd4qqJJgIoiN4KtDW0o
         /qhFyfDAl1uR8C+inkEoapiJ1skQ7g5NfY1aTEpb56H/t+Dp8gFrq4nzJUUenhWVfNFV
         Eq6g==
X-Gm-Message-State: APjAAAU0cq00FbZc2qtupB7SheQKDrI/Hfutj8QmY367Fmx5BWAohznr
        rbyAySJzQtPYi5jiIaWyGkROB91iWrpByeFypCEk8g+vhyybn1KRkJtPBh3dmZWxhER3aTFTYwD
        jb66o1w9P3cMrVZwSh2AFdcanBgyC/zfVfYc=
X-Received: by 2002:a37:bf02:: with SMTP id p2mr3402559qkf.42.1572491822463;
        Wed, 30 Oct 2019 20:17:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBRYNvJgULHc6/HirPX/JJlwuT5MkpOcps7z7Wgn9SXa/v+KbkipNm/PXten1R1WQp8wUltQ==
X-Received: by 2002:a37:bf02:: with SMTP id p2mr3402548qkf.42.1572491822161;
        Wed, 30 Oct 2019 20:17:02 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id t132sm1220848qke.51.2019.10.30.20.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 20:17:00 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-xfs@vger.kernel.org,
        Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] errno.h: Provide EFSCORRUPTED for everybody
In-Reply-To: <20191031030449.GV15222@magnolia>
References: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
 <20191031030449.GV15222@magnolia>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1572491818_4623P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Oct 2019 23:16:59 -0400
Message-ID: <120748.1572491819@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1572491818_4623P
Content-Type: text/plain; charset=us-ascii

On Wed, 30 Oct 2019 20:04:49 -0700, "Darrick J. Wong" said:

> I would add (d) can we do the same to EFSBADCRC, seeing as f2fs,
> ext4, xfs, and jbd2 all define it the same way?

If this one flies, that's a good candidate for a second patch....

--==_Exmh_1572491818_4623P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXbpSKgdmEQWDXROgAQJYmA/+PTG0+FXdOKpnGaoDDFNKM1tIitWpnoi9
02VrxRtAXg+D3lFix+ADGPwdAI9qKi2oMzxnOdTY81JCchjmp2rN4y1iABx5+Vy1
8eS3gGF2xihheSUp/wLsq4tQx7mY4DkcWIRsuRSmj3PPEZotxvNMkLFox/+xHCSk
RXdXLU/kO9LZjdFdlxQ26/X9pwhTn6USWRD73f5lVzQ49IChhB+Ww3UJj2RUm4vK
hkzocyTyA+tGSKEqh3b508buuxiUjWjYFFr8KWUzkd5Of/zgoddbTGXG117ILwDO
V+kQgt2ZAIESvyDXpBDnkPDclJPgv9aQgkAKdSb94BoMqiry75amO2JuxCNaZcnr
usLK+H7vWv++FXsA7BPhPAM0xuQRBbWA0sByEcKuHZEP5Z3LKjzIG8UqcbzJsRh4
ZbmqnW34sqYegs16RUj6Uv3CpRQmNwgit0m4lovTVfHTv+5ZK65e2O615RJajHpE
KKmSLCZCbLPN9TSAGm+p3m0aIoDH4+b5rp6KQDjfXJR3I8o0um8cLA6ejWmzhdVc
NMJSDVYw/px/5FU35XocFQERd9DCHYmTtNg2PhPffAKY2Og0YTzyxqxu2aT1ao5S
xLKZ1MHhLpDGdYhkJDvDHZPypg5kjtJN47yNF7naKgY7Xnt9i4s++1xoSSUVsj1a
8rFfLA7uEbY=
=RvfI
-----END PGP SIGNATURE-----

--==_Exmh_1572491818_4623P--
