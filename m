Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2AC783B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 05:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfG2Dod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 23:44:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42525 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfG2Dod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 23:44:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45xltQ6HTHz9s3l;
        Mon, 29 Jul 2019 13:44:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564371870;
        bh=VqiQsxljM9snosIqtgWs+IzjqnmPWOCfmBR89kfVYCI=;
        h=Date:From:To:Cc:Subject:From;
        b=skCkQM31QBJFQlnEkdUZUd+nCgx3pt6wOIYkIC63EHf6CXzzM6pzGxWo5DEV185qa
         pZiNmfQ41BGiM0vHLAS5gjKGjEnm9fRgUuXMbmeThJSFwYHYSnTVDW5mt7AaJv2Eak
         WeZq0icBdxLcq4dXKOjgPlYRl+jGad71BUMajiqh/D1oKa4VptS4jBOx1/h4mOUag0
         I9FcLqzaR/3LwEgOetKkKMS/XrW+PIwXNsqHrRVXnKJQG7/HKr0dQ8mQgz459COWwh
         7w3ZeJP3j0UBkjyZVVALHvwH8XWEV4HyTqbPJo/B4G7QwGjQEMwlOxrJF5WVzeLlSU
         dJ0YfriTk7ZlQ==
Date:   Mon, 29 Jul 2019 13:44:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190729134430.02562e2b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rkg0cQk+BhqukxUJWPrtaUW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rkg0cQk+BhqukxUJWPrtaUW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

lib/rbtree_test.c: In function 'check_augmented':
lib/rbtree_test.c:220:18: warning: unused variable 'rb' [-Wunused-variable]
  struct rb_node *rb;
                  ^~

Introduced by commit

  33a64f781816 ("augmented-rbtree-add-new-rb_declare_callbacks_max-macro-fi=
x-2")

--=20
Cheers,
Stephen Rothwell

--Sig_/rkg0cQk+BhqukxUJWPrtaUW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0+a54ACgkQAVBC80lX
0Gy8TQf+JNzzeBhuozbKnIye6vZZML6TxLU+JtKC/uMNTFp1ggCl8yks+gGnPWNL
ITjZHAJxgoC+HThLBaSjjEKw4P1zXcQomrerL+vYHxj4uF0DqLKIQKTyN8xuaW/N
6+EvGCVko0LBfz839qHj9jCYe+8zJT4gRd7ivfmaLHNUWLOEVU7qcx8V8fcjfuJE
zxqTIrZC5ZJj7Au2Hs6nvhIQlEs0tmVEv6qh4pgczICpnZyWBlOloYsbDNUFJbfS
jraj7gYNFbW6YrN3cvS5f0XicX0cHMHGbkiCCKhpyHVY4hfOBs1nfzvbLQWDXffr
FBF/2F/6r+OFPcdnxotNDWPbHhjgzA==
=F86y
-----END PGP SIGNATURE-----

--Sig_/rkg0cQk+BhqukxUJWPrtaUW--
