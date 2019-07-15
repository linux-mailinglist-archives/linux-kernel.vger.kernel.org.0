Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA4569A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbfGOSLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 14:11:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46314 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731762AbfGOSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:11:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id r4so12320256qkm.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jYZYKAc4cXMboCx/2peydkmI+hhxw+p2e+4iD/ro77c=;
        b=F8NFVhckIungTHtsKgQe+pQO0Vu3TG5O8v6TLBNPm2LSKZVomFfdlxVi7302e4YzWW
         p58VTnJFCE8qGTKD3U8G7uCwOHI/Cxu5QVw7JcIdWxqaS2lghAGxWj+cyE/9bRSrslPz
         gx/AtOPYgKNwcI3Ulq+Lt+0aFfLUFkSsDEB84Z6K4jpzQUzrDhcCukP32APpDsViackC
         kx9MLL4M4RQc0UTIdaNXbUhPPNnMyrfbIn67E6H1JfKoXHPgxBoa0KbqYeKk4R1ZbMcc
         EtGJVaRDM3sFfgNn1rAhpe3vriDI8ut4GguGgAk4s0ycWhZY4kbSwnHRXAyx1xamMsVm
         whog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jYZYKAc4cXMboCx/2peydkmI+hhxw+p2e+4iD/ro77c=;
        b=larXsCK7HZwAlvMq8KRw/YQATtBVv9XbGq+N7zZ22Oiq7Mg/DMONdF3qOP1+wUCuD7
         BDNlxGKH7gL8Cc5O+Ydv2MGopzAs048maiMVUr0yj7U4w/w/PIKy4JKDE7GlA2L1wpnM
         YXD1T/aN8Trl1JWA9AqlX0zNgoigtg8UKSKr9Z3HUvAmbZOwlRSm4GN8F80yrMVTs1Zs
         SzzFr6IIrp1iWnD2VJjFz93JrTJ+aStUHo4cGFju12ArcBYKz0hkb03J71Sa63pBeB06
         fSXiku6uADHfy6yKjJcYBfQ8nIIaB/rGo0L72ch1TEujZSrreTrglwMq+UNWBcNdoCkK
         XUMg==
X-Gm-Message-State: APjAAAVA+GEsq7TLGOWSUZZoI+meJv0+JhLWnbZ98Ysd5bGhgXTiUS+c
        k5ZcWJE3GVpA3tdImQVDhM9f4hHIaRJ0aw==
X-Google-Smtp-Source: APXvYqype9M44/+Osix16H39k34Y9HMTaUWvg9TbauPunTaltUu36Qa/d/0sfE+znqX75JjKsBNP8g==
X-Received: by 2002:ae9:e10e:: with SMTP id g14mr17227313qkm.486.1563214264805;
        Mon, 15 Jul 2019 11:11:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 39sm8940896qts.41.2019.07.15.11.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jul 2019 11:11:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hn5RH-000248-T6; Mon, 15 Jul 2019 15:11:03 -0300
Date:   Mon, 15 Jul 2019 15:11:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/24] rdma/cxgb3: Remove call to memset after
 dma_alloc_coherent
Message-ID: <20190715181103.GD4970@ziepe.ca>
References: <20190715031746.6514-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715031746.6514-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 11:17:46AM +0800, Fuqian Huang wrote:
> In commit 518a2f1925c3
> ("dma-mapping: zero memory returned from dma_alloc_*"),
> dma_alloc_coherent has already zeroed the memory.
> So memset is not needed.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v3:
>   - Use actual commit rather than the merge commit in the commit message
> 
>  drivers/infiniband/hw/cxgb3/cxio_hal.c | 3 ---
>  1 file changed, 3 deletions(-)

Why are you resending this? I already applied the v2 version for
RDMA's tree.

Jason
