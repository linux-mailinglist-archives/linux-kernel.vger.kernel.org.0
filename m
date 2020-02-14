Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0322015F6BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 20:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387937AbgBNTYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 14:24:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43824 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729542AbgBNTYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:24:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so7713587qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ha43rM3KNl2ywTmmquarsRVleo66vDOJWPO8lRx+MyE=;
        b=aqGNfI4aJe6xDeKXsjDHuhKN9r+mjkz/Rst3N5oxOuWvENMfU9cGCfvUBhz8S+Kb8Z
         cHLKkkZ5Qh7lQo5mHL05Lh1s8w24MZx53if6/eOzvv9nVn493wbVZeebMd3KSvdOgagl
         2DBQgZjfupeuiQh4RqLF5ipSNH3I3cDNM8d+OvM9XIEnNIShIkQHrPLGTjQLyThumlJK
         CIf4biddyc8fOzHgf5d84F0YCqoX+1I3Zrmcq4ai/wc/qEnandR7j8j3eutDqZO0K1Hb
         KskAziz6xoiiJJwaym5T4gK5l4L4KwX2BalnxcEz/1hbQx6lApRZlGlumjDKwtgDJX8g
         19YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ha43rM3KNl2ywTmmquarsRVleo66vDOJWPO8lRx+MyE=;
        b=aKf3JSi18hkwTe6cDtJNKjJT+bVAGVQNjQ9OxJbs8926LydR2S+abEBzrKdgMGwJoD
         uAwmo7brn/tQnWZn3A5DFZmVApMfglDANFPXP0R/OcFIazka55wwYGvu5J5gNeHVHQOm
         MavTFP0VXrR6MBagflfOxONtBCKH8jrOdibEbXzWu/ZW+OYS+I/BJEsAcuUif/fKkHiO
         gK954pvzt0dt9MfsSWrYJzYEx/GCqZGgg73AHiJUb44dhh+LLJf1iK/9cDKc8yc46n0z
         qDYAGvMy6XNIaDRXvJStZ9Kk5HnZGlrug934BrYhYeqPx1Ri3qSfm4LKGXbm3EJeUpkG
         buJQ==
X-Gm-Message-State: APjAAAXXM1xI7JYs4HASEJJZA8QreKmyrCZcQC6kRA5dD4N1y+liCCvM
        SBw9m2Bzo5PcUON3DBLpHNmrog==
X-Google-Smtp-Source: APXvYqzIjwU2zk+OXOdGkNzQF9DtBBypx0WIlzO3OgwdyiDOqj+uG9Kxjxczfd0IY7E7oPNg/GMF5w==
X-Received: by 2002:ac8:4a16:: with SMTP id x22mr3825965qtq.339.1581708252247;
        Fri, 14 Feb 2020 11:24:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q6sm3726913qkm.46.2020.02.14.11.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 11:24:10 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2gZO-0000bY-GB; Fri, 14 Feb 2020 15:24:10 -0400
Date:   Fri, 14 Feb 2020 15:24:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alexander Lobakin <alobakin@dlink.ru>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma] IB/mlx5: Fix linkage failure on 32-bit arches
Message-ID: <20200214192410.GW31668@ziepe.ca>
References: <20200214191309.155654-1-alobakin@dlink.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214191309.155654-1-alobakin@dlink.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:13:09PM +0300, Alexander Lobakin wrote:
> Commit f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR
> capabilities") introduced a straight "/" division of the u64
> variable "bar_size", which emits an __udivdi3() libgcc call on
> 32-bit arches and certain GCC versions:
> 
> error: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined! [1]
> 
> Replace it with the corresponding div_u64() call.
> Compile-tested on ARCH=mips 32r2el_defconfig BOARDS=ocelot.
> 
> [1] https://lore.kernel.org/linux-mips/CAMuHMdXM9S1VkFMZ8eDAyZR6EE4WkJY215Lcn2qdOaPeadF+EQ@mail.gmail.com/
> 
> Fixes: f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR
> capabilities")
> Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Randy beat you too it..

https://lore.kernel.org/linux-rdma/20200206143201.GF25297@ziepe.ca/

But it seems patchwork missed this somehow.

Applied now at least

Jason
