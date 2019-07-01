Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4C5508F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfFXKcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 06:32:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38684 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfFXKcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:32:32 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hfMGz-0003RQ-Nw; Mon, 24 Jun 2019 18:32:29 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hfMGw-0004ma-DC; Mon, 24 Jun 2019 18:32:26 +0800
Date:   Mon, 24 Jun 2019 18:32:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     syzbot <syzbot+f7baccc38dcc1e094e77@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: lib/mpi: Fix karactx leak in mpi_powm
Message-ID: <20190624103226.fbjvc6eumu325ifw@gondor.apana.org.au>
References: <000000000000617b4a058c0cbd60@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000617b4a058c0cbd60@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:27:08AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17a8bfeaa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce
> dashboard link: https://syzkaller.appspot.com/bug?extid=f7baccc38dcc1e094e77
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171aa7e6a00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153306cea00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f7baccc38dcc1e094e77@syzkaller.appspotmail.com

The only memory leak that I can find is on the out-of-memory error
path:

---8<---
Sometimes mpi_powm will leak karactx because a memory allocation
failure causes a bail-out that skips the freeing of karactx.  This
patch moves the freeing of karactx to the end of the function like
everything else so that it can't be skipped.

Reported-by: syzbot+f7baccc38dcc1e094e77@syzkaller.appspotmail.com
Fixes: cdec9cb5167a ("crypto: GnuPG based MPI lib - source files...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/lib/mpi/mpi-pow.c b/lib/mpi/mpi-pow.c
index 82b19e4f1189..2fd7a46d55ec 100644
--- a/lib/mpi/mpi-pow.c
+++ b/lib/mpi/mpi-pow.c
@@ -24,6 +24,7 @@
 int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 {
 	mpi_ptr_t mp_marker = NULL, bp_marker = NULL, ep_marker = NULL;
+	struct karatsuba_ctx karactx = {};
 	mpi_ptr_t xp_marker = NULL;
 	mpi_ptr_t tspace = NULL;
 	mpi_ptr_t rp, ep, mp, bp;
@@ -150,13 +151,11 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 		int c;
 		mpi_limb_t e;
 		mpi_limb_t carry_limb;
-		struct karatsuba_ctx karactx;
 
 		xp = xp_marker = mpi_alloc_limb_space(2 * (msize + 1));
 		if (!xp)
 			goto enomem;
 
-		memset(&karactx, 0, sizeof karactx);
 		negative_result = (ep[0] & 1) && base->sign;
 
 		i = esize - 1;
@@ -281,8 +280,6 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 		if (mod_shift_cnt)
 			mpihelp_rshift(rp, rp, rsize, mod_shift_cnt);
 		MPN_NORMALIZE(rp, rsize);
-
-		mpihelp_release_karatsuba_ctx(&karactx);
 	}
 
 	if (negative_result && rsize) {
@@ -299,6 +296,7 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 leave:
 	rc = 0;
 enomem:
+	mpihelp_release_karatsuba_ctx(&karactx);
 	if (assign_rp)
 		mpi_assign_limb_space(res, rp, size);
 	if (mp_marker)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
