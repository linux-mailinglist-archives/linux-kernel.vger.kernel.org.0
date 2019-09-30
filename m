Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C64C1D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfI3Ifw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 04:35:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfI3Ifw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=14OWwE+N+A7N6F/kJQk3CvLLeNGvUNaZndJRB3KCdv0=; b=WQQS8HQ895Dl7xDouJGMixNDm
        +smiP7sIMvuJW28QnxtjBxKa0xNxBenC7acnl6ik0WlwW8Bi9dZmuUs8jSTot1467Tmh1agUiDXHG
        zp6ToG6ySa/DQkqmcnzLZp+Q58apoqFNP5A19jMvcTUoDEarbeA4yVGTUUtsCwQ7XwdrnCP+Jc7AV
        ayzsbaAG7dwcMTOwzqaRr1I7bOym2tQXaMMC0DTnzfFOogOQhtmlY4P+vUreaCO/kwWoo3kCBCmaR
        hCbIK9/cLO4cG03Mdrs6uNfs925Qi+t9p9awY8st6AtQLAmlZj9wsbOJuRhj1fZ/mNqH92vE7kz0j
        1g/RC4gZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEr9r-000817-OL; Mon, 30 Sep 2019 08:35:51 +0000
Date:   Mon, 30 Sep 2019 01:35:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] blk-mq: Inline status checkers
Message-ID: <20190930083551.GB24152@infradead.org>
References: <1cd320dad54bd78cb6721f7fe8dd2e197b9fbfa2.1569830796.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd320dad54bd78cb6721f7fe8dd2e197b9fbfa2.1569830796.git.asml.silence@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 11:25:49AM +0300, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> blk_mq_request_completed() and blk_mq_request_started() are
> short, inline it.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  block/blk-mq.c         | 12 ------------
>  block/blk-mq.h         |  9 ---------
>  include/linux/blk-mq.h | 20 ++++++++++++++++++--
>  3 files changed, 18 insertions(+), 23 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 279b138a9e50..d97181d9a3ec 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -647,18 +647,6 @@ bool blk_mq_complete_request(struct request *rq)
>  }
>  EXPORT_SYMBOL(blk_mq_complete_request);
>  
> -int blk_mq_request_started(struct request *rq)
> -{
> -	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
> -}
> -EXPORT_SYMBOL_GPL(blk_mq_request_started);
> -
> -int blk_mq_request_completed(struct request *rq)
> -{
> -	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
> -}
> -EXPORT_SYMBOL_GPL(blk_mq_request_completed);

How about just killing these helpers instead?
