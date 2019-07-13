Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D472667AB3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfGMOtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 10:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfGMOtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 10:49:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C2DA2083B;
        Sat, 13 Jul 2019 14:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563029362;
        bh=dCrj2GS0SLzN9WlYGL04tx3Iwc2UkR/AntdrCG5hqbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=08T5Hp48Aj2QWyucRtaOOTVrl2ssUZqHGGWVaXKHg09dSdIaaKi852ImtvhaaUpEW
         xoZrohZm98OhqRkYnRAX82TXs9UGWtezgN5tqtSfFFeL4U0svyPHnBwQvHwyF7Q8Z+
         DyeWCBqRJDbaJvutYX6U9Pv41eb7d23scSQqMOdk=
Date:   Sat, 13 Jul 2019 16:49:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmw_balloon: Remove Julien from the maintainers list
Message-ID: <20190713144920.GA7495@kroah.com>
References: <20190702100519.7464-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702100519.7464-1-namit@vmware.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 03:05:19AM -0700, Nadav Amit wrote:
> Julien will not be a maintainer anymore.
> 
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 01a52fc964da..f85874b1e653 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16886,7 +16886,6 @@ F:	drivers/vme/
>  F:	include/linux/vme*
>  
>  VMWARE BALLOON DRIVER
> -M:	Julien Freche <jfreche@vmware.com>

I need an ack/something from Julien please.

thanks,

greg k-h
