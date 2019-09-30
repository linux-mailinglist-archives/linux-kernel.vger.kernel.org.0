Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B740C1D38
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 10:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfI3Ida (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 04:33:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfI3Ida (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uNz1pYDflKfewyxuMkqkNfMrUP0dG6fDyG6MbB0Wf3k=; b=T2uBEnaZhPeL9m1jaPMfR3xmM
        85aA9cZHSh8ENnsCjnhdOPM36HMtWiLObPqCFdg1G8acyTtZXKgHWN87niFEHdlpakR0/8rnluYd3
        HjxVSxKr20xrhRPHQYLD4Cvzpjrr0Fp15vkUlDRREtsHKV4eBCjJLziHWSiAX+vdj2spZiSJJIIU1
        fje18BshsMCnJ/TmCAHsayTVngMtfbm+RNRgnu1KL7Ui0/TeTo3CeYrS575n7YkHeDCJFWn+wIPQv
        AIBOj6aoWF8vhHQyfvWlOdmca+lrinlD0ALtO65vSP5rnNPUTL+gRwI8PXMr81+JWCOt61prwjK6/
        UoHYV56rQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEr7U-0006fC-OS; Mon, 30 Sep 2019 08:33:24 +0000
Date:   Mon, 30 Sep 2019 01:33:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] blk-mq: reuse code in blk_mq_check_inflight*()
Message-ID: <20190930083324.GA24152@infradead.org>
References: <11ebb046bf422facf6e438672799306b80038173.1569830385.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11ebb046bf422facf6e438672799306b80038173.1569830385.git.asml.silence@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 11:27:32AM +0300, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> 1. Reuse the same walker callback for both blk_mq_in_flight() and
> blk_mq_in_flight_rw().
> 
> 2. Store inflight counters immediately in struct mq_inflight.
> It's type-safer and removes extra indirection.

You really want to split this into two patches.  Part 2 looks very
sensible to me, but I don't really see how 1 is qn equivalent
transformation right now.  Splitting it out and writing a non-trivial
changelog might help understanding it if you think it really is
equivalent as-is.
