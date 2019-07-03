Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625D65E8A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 18:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfGCQUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 12:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfGCQUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:20:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8BEF21882;
        Wed,  3 Jul 2019 16:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562170841;
        bh=QZTPaJThXyCvilVBec9jdvthL4N/0KWr9NeInDRs86I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfpGpXQqZjJsZny78dtBwtSQTqC1dHZjhi8Hrif6Avo5MfSEozLRGTIE9B1x64R8i
         mew4YG2xBl8Wwk5N+AtUJuHbjQjlAlDWM1cldJIKfPMs2rg/bSKWtvfzs14BCplYCF
         /C18P3Lbt0894GMMkrWmnwOu66TSWAhruJauTaH0=
Date:   Wed, 3 Jul 2019 18:20:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        devel@driverdev.osuosl.org, huyue2@yulong.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3] staging: erofs: remove unsupported ->datamode
 check in fill_inline_data()
Message-ID: <20190703162038.GA31307@kroah.com>
References: <20190702025601.7976-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702025601.7976-1-zbestahu@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 10:56:01AM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Already check if ->datamode is supported in read_inode(), no need to check
> again in the next fill_inline_data() only called by fill_inode().
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> ---
> no change
> 
>  drivers/staging/erofs/inode.c | 2 --
>  1 file changed, 2 deletions(-)

This is already in my tree, right?

confused,

greg k-h
