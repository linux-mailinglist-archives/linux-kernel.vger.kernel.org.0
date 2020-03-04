Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72FEA179690
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 18:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgCDRT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 12:19:28 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34686 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgCDRT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:19:27 -0500
Received: by mail-qk1-f194.google.com with SMTP id f3so2392028qkh.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DivPesDQYVQHTV465p4P0jQ8dQ9FG60oILnE+jt1qOw=;
        b=Nxyt+C4ZL86JMPS0DuKKqaDCTtTy7A3i98Rdr3OVV5HOejk3wIdYffNI+7YXWNfAMx
         Us4G4n7Vb02iyzJ/p91JqvoZ/6hJkCdjoyKGe+beg3rAOX4QObGAMEYbqCZWEiRqpyZA
         LOWzqF6bND0THW9eMHm8J+13RA7r2Oarj+d0njqXxFUL6pM1yRH8IUiNMA6eINBN3ZDP
         6CYwHpxyQhxu8m+YuMf0dsJdZcbR+vEDwzvYPzlm1eoUHlpqjkIxacTIT/4goIsw0MG2
         uFoQYyAcKWM2uson9sc3Fz2XwChPQeSVOODVzFFnE10/5KghZMAgxXu3uMWnXHFGgx0k
         0Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DivPesDQYVQHTV465p4P0jQ8dQ9FG60oILnE+jt1qOw=;
        b=kvptNM0feagZe0o3Ic+lGs+gJ8gOCEV9kgz5PMcYri5tYnpArALLL0LbiDt+7DTSIY
         IcdM/lpexOhLFn3/991fao/rM6pHzaG4+6CFgHEjEMuc+IMnz4vNCxq47Yz+iM7/J/RE
         Hr0YNyccNMgfbNB7ElBT5yndmaNIGmAKGaz8xkuTv8xoiM6f4YT8yNI/uWBPzZ7ZSmH0
         dxD3Yny3uVoCA4AiGeF6OWvkLyfYdZpml7sk5+4Kui5GRS7UtPwRzebDxFoKOnC70b00
         sRAYH33Jhfz0odcF0B1h/QTCvSLWubYyoJiVCGaSLqDSayxufcoy/5YGSvGq25qgQZCL
         SfQQ==
X-Gm-Message-State: ANhLgQ24LKJ7UG1JVVNvg4n6/hiCDC1U/jJwQPv+eq3iSYbRaslKkWBL
        Yf4acaU/1FBKG92TkHOiB/e+GA==
X-Google-Smtp-Source: ADFU+vshwpDrER12aKgSnlgVlWHCHkYggG6y3qQO/cIkCAfMESDgmV6ycDm3qKlZY7Ahix9fNSdJ4w==
X-Received: by 2002:a37:a6d4:: with SMTP id p203mr3996211qke.350.1583342366640;
        Wed, 04 Mar 2020 09:19:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u9sm5721516qku.124.2020.03.04.09.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 09:19:26 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9Xg5-0001xi-Mt; Wed, 04 Mar 2020 13:19:25 -0400
Date:   Wed, 4 Mar 2020 13:19:25 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alexander Lobakin <alobakin@dlink.ru>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma] IB/mlx5: Optimize u64 division on 32-bit arches
Message-ID: <20200304171925.GA7515@ziepe.ca>
References: <20200217073629.8051-1-alobakin@dlink.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217073629.8051-1-alobakin@dlink.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:36:29AM +0300, Alexander Lobakin wrote:
> Commit f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR
> capabilities") introduced a straight "/" division of the u64
> variable "bar_size".
> This was fixed with commit 685eff513183 ("IB/mlx5: Use div64_u64
> for num_var_hw_entries calculation"). However, div64_u64() is
> redundant here as mlx5_var_table::stride_size is of type u32.
> Make the actual code way more optimized on 32-bit kernels using
> div_u64() and fix 80 chars break-through by the way.
> 
> Fixes: 685eff513183 ("IB/mlx5: Use div64_u64 for num_var_hw_entries
> calculation")
> Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
