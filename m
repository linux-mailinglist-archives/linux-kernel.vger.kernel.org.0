Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C34CA12FD5A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 21:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgACUBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 15:01:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33691 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgACUBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 15:01:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so26839226qkc.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A56UC0w5GLRc6XImLwZB7Svehfi5E2iCOac3oz+4egQ=;
        b=eBdvlKXe8GaxBJQX/G4csG9ZdMY/64O11qqgYWNPuXh3wqho3raAuCgAh9kCCpq2g0
         7j1XotvkfcxEohD0N3dqehlZ7GBmRa5J2WHyXuQPLd/7qbTYFOfRh49L55jzFOZwQAZy
         u62PGHppFudekxHvPtLgod9F8bBDIdEYROW8v2Fz+m+L+1apm8mxHTFAtMNAlC0vviGq
         7KFS3sLs4L4ecxsPnRWuSDXoKxWMrG+7KtPj/KTeZAfhuuFGPrvRSx+6Ni0Ysyu2AlEL
         BxkTHeozSqVxc0BcN3QhTWWpX/t7SbKWWemF7EHdAXhLokexWY55HBeytvQPG3oTwOp5
         xlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A56UC0w5GLRc6XImLwZB7Svehfi5E2iCOac3oz+4egQ=;
        b=f+qk45XVuqfk36ILM+jK0Bueeb3ucTBWqKo03YzAkIZl7fa4G3dmmLuAyyjMCWacgh
         MIsVN9Pqlm1GtRqKSSMN9o++HBgZtoNKrhdj7+ueWm4HOdhdWI6B0HXabw4iKT2aUQvX
         FMT6kPacmaTy8qwUFC+VmYjXmEZtAxJQYm7V+ed0rnq0tdB6nmB0XFsN8M7ZrvW5pZJ9
         qZ/eptLEKrDnCPa2uwqkdzrbWG1HFQukG+R4WqpZA16OWVQUvmzDJZrDn/CzBy3lLK7G
         GCtQ+/d22VygEkyhKiMm6LUaIizPt5Ivl/RTI9p/YC5pSkEHuECCBG8Lud9zQO3b+jT3
         siyg==
X-Gm-Message-State: APjAAAXxUJbvxiIhyb/s/gA8WIaJRE3M5S8nQs9D4bE6lebBry0OS602
        hveAsRK3wn4Bwtan0x95O1YiLw==
X-Google-Smtp-Source: APXvYqypm/JpMqcucNPfB12FjbVXHsbFsRwkB1xsS4u8ZlUIlgCQmEPJNMow8LKqUpKg1OdwMcnMmg==
X-Received: by 2002:a37:6545:: with SMTP id z66mr75273804qkb.367.1578081666057;
        Fri, 03 Jan 2020 12:01:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p19sm19280745qte.81.2020.01.03.12.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 12:01:05 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inT85-0000kn-4l; Fri, 03 Jan 2020 16:01:05 -0400
Date:   Fri, 3 Jan 2020 16:01:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Prabhath Sajeepa <psajeepa@purestorage.com>
Cc:     leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, roland@purestorage.com
Subject: Re: [PATCH] IB/mlx5: Fix outstanding_pi index for GSI qps
Message-ID: <20200103200105.GA2761@ziepe.ca>
References: <1576195889-23527-1-git-send-email-psajeepa@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576195889-23527-1-git-send-email-psajeepa@purestorage.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 05:11:29PM -0700, Prabhath Sajeepa wrote:
> b0ffeb537f3a changed the way how outstanding WRs are tracked for GSI QP. But the
> fix did not cover the case when a call to ib_post_send fails and index
> to track outstanding WRs need to be updated correctly.
> 
> Fixes: b0ffeb537f3a ('IB/mlx5: Fix iteration overrun in GSI qps ')
> Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
> Acked-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/gsi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next with an updated commit message.

Thanks,
Jason
