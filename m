Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B21AB4E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 11:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392926AbfIFJcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 05:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392912AbfIFJcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:32:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F04832081B;
        Fri,  6 Sep 2019 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567762374;
        bh=cPDqk6aXgLbE+FjZ+dLvMyI1fQjEIqWJyXy+GFf60BE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9p1q33DSeih0KQVKngEMuv4yWhp9cEYmvpkGXiwIyuCY/fTxSayvES0HnzP+/Xkz
         ACedDjqe59IqJcEfcQA/LpTQtx1fRdX7rDFFGWDs36lF/Fje5OPkvoHJdg5ZO5wPBq
         WmK7M5ooWAeATfBOv2PByyhNRJZf2M4DgtLJnaL4=
Date:   Fri, 6 Sep 2019 11:32:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dvhart@infradead.org, andy@infradead.org, hpa@zytor.com,
        allison@lohutok.net, armijn@tjaldur.nl, kjlu@umn.edu,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: move kmalloc() NULL check routine
Message-ID: <20190906093252.GB16843@kroah.com>
References: <20190905232951.GA28779@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905232951.GA28779@LGEARND20B15>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 08:29:51AM +0900, Austin Kim wrote:
> The result of kmalloc should have been checked ahead of below statement:
> 	pqp = (struct bau_pq_entry *)vp;
> 
> Move BUG_ON(!vp) before above statement.
> 
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  arch/x86/platform/uv/tlb_uv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
> index 20c389a..5f0a96bf 100644
> --- a/arch/x86/platform/uv/tlb_uv.c
> +++ b/arch/x86/platform/uv/tlb_uv.c
> @@ -1804,9 +1804,9 @@ static void pq_init(int node, int pnode)
>  
>  	plsize = (DEST_Q_SIZE + 1) * sizeof(struct bau_pq_entry);
>  	vp = kmalloc_node(plsize, GFP_KERNEL, node);
> -	pqp = (struct bau_pq_entry *)vp;
> -	BUG_ON(!pqp);
> +	BUG_ON(!vp);

Ick!  Don't crash the whole machine if you are out of memory, that's a
totally lazy and broken driver.  Fix this up properly please.

But the original code is just fine (from a this is doing what I want it
to do point of view), I don't see the need to change anything here, you
did not modify any logic at all.

thanks,

greg k-h
