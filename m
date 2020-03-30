Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 099BB19799A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgC3Kqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 06:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbgC3Kqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:46:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0CFB205ED;
        Mon, 30 Mar 2020 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585565207;
        bh=hOAh2tFSSErO/EeUBVipX4uy4+g3G7RwJI25iUpOFEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EySwtxaHh28Y725V5BdjzisZtuEEjSaqP6YfW1H/ku4GrDRucRUk69azDS9YN1VB2
         /nKtkytYjlk+N9v5c87rB7dzsItY4LAyXhc4pbny8RjTrXxvF4Vs2CK258MAONAasE
         dI8SyamiKnTo4utYvuN0YKgC9G5d/x8ywXUK8gdw=
Date:   Mon, 30 Mar 2020 12:46:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Payal Kshirsagar <payalskshirsagar1234@gmail.com>
Cc:     akpm@linux-foundation.org, dave@stgolabs.net,
        viro@zeniv.linux.org.uk, elfring@users.sourceforge.net,
        manfred@colorfullife.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] ipc: mqueue.c: avoid NULL comparison
Message-ID: <20200330104643.GA739661@kroah.com>
References: <20200330103826.6531-1-payalskshirsagar1234@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330103826.6531-1-payalskshirsagar1234@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 04:08:26PM +0530, Payal Kshirsagar wrote:
> Change suggested by coccinelle.
> Avoid NULL comparison, compare using boolean negation.
> 
> Signed-off-by: Payal Kshirsagar <payalskshirsagar1234@gmail.com>
> ---
>  ipc/mqueue.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I can not take any outreachy patches made outside of drivers/staging,
sorry.

So consider this, and your other patch, dropped, sorry.

greg k-h
