Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D02390C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 16:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbfETOAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 10:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732237AbfETOAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:00:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C040216B7;
        Mon, 20 May 2019 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558360809;
        bh=5IGl3ff/KTy0/cSCKKtxQsTjoOV8H+46AHi9fqjVZQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1GO1Qh2jhvuZSCS+dotIzXSaH8ep0TbAPJGMMRR49LHCBE9aWbB6NOt8O27qCT02
         Iv5TeAza5KA00uTr67Cdb5YToINxc1Gh0il7Z1NyOOE8+UbCzwKJ3jXeku7ECCYF5K
         ccSVCSt/ERvsFYwhf2F4at+79a8Kmg+g3lOSiVaY=
Date:   Mon, 20 May 2019 16:00:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     stable@kernel.org, kernel list <linux-kernel@vger.kernel.org>,
        gustavo@embeddedor.com, davem@davemloft.net
Subject: Re: net: atm: Spectre v1 fix introduced bug in bcb964012d1b in
 -stable
Message-ID: <20190520140007.GA6397@kroah.com>
References: <20190520124014.GA5205@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520124014.GA5205@amd>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 02:40:14PM +0200, Pavel Machek wrote:
> 
> In lecd_attach, if arg is < 0, it was treated as 0. Spectre v1 fix
> changed that. Bug does not exist in mainline AFAICT.
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>
> # for 4.19.y
> 
> diff --git a/net/atm/lec.c b/net/atm/lec.c
> index ad4f829193f0..ed279cd912f4 100644
> --- a/net/atm/lec.c
> +++ b/net/atm/lec.c
> @@ -731,7 +731,7 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
>  		i = arg;
>  	if (arg >= MAX_LEC_ITF)
>  		return -EINVAL;
> -	i = array_index_nospec(arg, MAX_LEC_ITF);
> +	i = array_index_nospec(i, MAX_LEC_ITF);
>  	if (!dev_lec[i]) {
>  		int size;
>  

Why is this only for 4.19.y?  What is different in Linus's tree that
makes this not needed there?

thanks,

greg k-h
