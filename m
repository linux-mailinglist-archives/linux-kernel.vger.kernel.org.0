Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A4C12B0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 03:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfL0C6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 21:58:06 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51286 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfL0C6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 21:58:06 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ikfow-0002uK-HV; Fri, 27 Dec 2019 10:57:46 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ikfor-0003Np-HV; Fri, 27 Dec 2019 10:57:41 +0800
Date:   Fri, 27 Dec 2019 10:57:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     atul.gupta@chelsio.com, davem@davemloft.net, tglx@linutronix.de,
        allison@lohutok.net, arjun@chelsio.com,
        kstewart@linuxfoundation.org, edumazet@google.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: chelsio: chtls: fix possible
 sleep-in-atomic-context bugs in abort_syn_rcv()
Message-ID: <20191227025741.lg3iudfo2lktrqvj@gondor.apana.org.au>
References: <20191218033422.18672-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218033422.18672-1-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:34:22AM +0800, Jia-Ju Bai wrote:
> The driver may sleep while holding a spinlock.
> The function call path (from bottom to top) in Linux 4.19 is:
> 
> drivers/crypto/chelsio/chtls/chtls_cm.c, 1806: 
> 	alloc_skb(GFP_KERNEL) in send_abort_rpl
> drivers/crypto/chelsio/chtls/chtls_cm.c, 1925: 
> 	send_abort_rpl in abort_syn_rcv
> drivers/crypto/chelsio/chtls/chtls_cm.c, 1920: 
> 	spin_lock in abort_syn_rcv
> 
> drivers/crypto/chelsio/chtls/chtls_cm.c, 1787: 
> 	alloc_skb(GFP_KERNEL) in send_defer_abort_rpl
> drivers/crypto/chelsio/chtls/chtls_cm.c, 1811: 
> 	send_defer_abort_rpl in send_abort_rpl
> drivers/crypto/chelsio/chtls/chtls_cm.c, 1925: 
>     send_abort_rpl in abort_syn_rcv
> drivers/crypto/chelsio/chtls/chtls_cm.c, 1920: 
>     spin_lock in abort_syn_rcv
> 
> alloc_skb(GFP_KERNEL) can sleep at runtime.
> 
> To fix these possible bugs, GFP_KERNEL is replaced with GFP_ATOMIC.
> Besides, in send_defer_abort_rpl(), error handling code is added to 
> handle the failure of alloc_skb().
> 
> These bugs are found by a static analysis tool STCheck written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/crypto/chelsio/chtls/chtls_cm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/chelsio/chtls/chtls_cm.c b/drivers/crypto/chelsio/chtls/chtls_cm.c
> index aca75237bbcf..e6e4c3ddc368 100644
> --- a/drivers/crypto/chelsio/chtls/chtls_cm.c
> +++ b/drivers/crypto/chelsio/chtls/chtls_cm.c
> @@ -1805,8 +1805,11 @@ static void send_defer_abort_rpl(struct chtls_dev *cdev, struct sk_buff *skb)
>  	struct cpl_abort_req_rss *req = cplhdr(skb);
>  	struct sk_buff *reply_skb;
>  
> -	reply_skb = alloc_skb(sizeof(struct cpl_abort_rpl),
> -			      GFP_KERNEL | __GFP_NOFAIL);
> +	reply_skb = alloc_skb(sizeof(struct cpl_abort_rpl), GFP_ATOMIC);
> +	if (!reply_skb) {
> +		kfree_skb(skb);
> +		return;
> +	}

This code now makes no sense because it's just trying the same
kmalloc twice.  Perhaps it really needs to be deferred as its
name suggests?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
