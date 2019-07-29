Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663DE79385
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 21:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfG2TD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 15:03:28 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43391 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfG2TD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:03:28 -0400
Received: by mail-ua1-f68.google.com with SMTP id o2so24451371uae.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 12:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D5BZfiLWdNEXJw0en6RAexTCbHwoFM1z03FCr9B22Yw=;
        b=cfyuNe31BMojTnlCiziTtwc4t8kfjwoQwpdX6k5WXvogo/8a5+XKjc7dzga1WOEDQV
         d398h8jYwkNBfNNfPeRQD6zQQ66zwJEjvzfMkiBlm7DiAahD4sAUB1joRpVC/Fs++MvZ
         wpe5APBvNgpCxuMnsyq3YaTAUjkQOuhWdyUvSTrmRtJcqU2TzLIQe6fbgBLPCFRa4oHX
         W+Hy0b9vIyJugcveW1tZMAwwBroATGxODu9MnvlekPV13RdvLlSlr76u1P0CkRHpLZrU
         D87sBBL5Lopu3twj/Nyy+GC+1hRJOFrjRLdY63elhSJE2rYsyoUEtj7/+IuTlRs2LfHq
         QC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D5BZfiLWdNEXJw0en6RAexTCbHwoFM1z03FCr9B22Yw=;
        b=VNNhBL5HZ5gQSV7Emj7uxmXartB31S+mduSYKwB03jtTSI1PQrW310cyI+r+BSZS0G
         WIuqLNDZ7IIm2Og/vIYKQpgcmPrIc5FCNCzj0rcXl0dwF/vISdIdFFQzjkTAWc9jcX/L
         Njp4wmd7m2j15JTx11Hyd3Or89bNGNlrWB8CTXTDbJyBfrmNp7MhMBJQOfDrikfJFYDr
         dvNR8eCSwlJIDcJ5DeQUE5L8MpJLiH0MkuAj4zHhwV765CcsF3sAmT1VAbjQtMTwZjsB
         XoxOFKJ/GDcbn6e7VhNCelCrJ/mPbzF9caqS0YuWHIgWin+UQoRl9nQrlYzI3MpvF30f
         7z0g==
X-Gm-Message-State: APjAAAXhvjx3pTY5YVol41uwPKBvkx0c5442pTsKgfGAWNmhmKaCBjrL
        J2rWSdb4g5Hu2hEkk2zVcveO5w==
X-Google-Smtp-Source: APXvYqx5y6VZi44oyh6JdqE2GS3vOP3Og3GuGrrSJr+XWH30adcYL2ZdufCGTy3+afT7MiIaGw9YEA==
X-Received: by 2002:ab0:66d2:: with SMTP id d18mr33609311uaq.101.1564427007113;
        Mon, 29 Jul 2019 12:03:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 205sm24526279vkt.46.2019.07.29.12.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 12:03:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hsAve-0002go-1n; Mon, 29 Jul 2019 16:03:26 -0300
Date:   Mon, 29 Jul 2019 16:03:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rdma: siw: remove unused variable
Message-ID: <20190729190326.GG17990@ziepe.ca>
References: <20190726092540.22467-1-anders.roxell@linaro.org>
 <08d1942fa99465329348a1bbfd55823b590921c2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08d1942fa99465329348a1bbfd55823b590921c2.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 02:19:35PM -0400, Doug Ledford wrote:
> On Fri, 2019-07-26 at 11:25 +0200, Anders Roxell wrote:
> > The variable 'p' si no longer used and the compiler rightly complains
> > that it should be removed.
> > 
> > ../drivers/infiniband/sw/siw/siw_mem.c: In function ‘siw_free_plist’:
> > ../drivers/infiniband/sw/siw/siw_mem.c:66:16: warning: unused variable
> >  ‘p’ [-Wunused-variable]
> >   struct page **p = chunk->plist;
> >                 ^
> > 
> > Rework to remove unused variable.
> > 
> > Fixes: 8288d030447f ("mm/gup: add make_dirty arg to
> > put_user_pages_dirty_lock()")
> 
> This commit hash and the commit subject does not exist in Linus' tree as
> of today.  What tree is this being merged through, and is it slated to
> merge soon or is this a for-next item?

This is though -mm, maybe John knows what is what

Jason
