Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD78F18F309
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 11:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgCWKmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 06:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbgCWKmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:42:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 484212070A;
        Mon, 23 Mar 2020 10:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584960122;
        bh=Ccwab3iVrVXsTGRGRaE2cs1o1ArfyD+mxp9Qsa+VY0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrE/xAyjC7/YaiPjSDVJvmYE7KIRe6Hip0vPP7giCVScHHcINd/3e41LurE0vIqbk
         yGFfF5Q4/FC22DbxfDJN0zl9hMxcSIiVm9GZBhbpSU82uK/LpjvRvSQL7977vhUsud
         NeYZZt4jqxdpLSgipeVdyqe3jGFie7ksqHCs1kmk=
Date:   Mon, 23 Mar 2020 11:42:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Use DIV_ROUND_UP macro instead of
 specific code
Message-ID: <20200323104200.GA501377@kroah.com>
References: <20200322112342.9040-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322112342.9040-1-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 12:23:42PM +0100, Oscar Carter wrote:
> Use DIV_ROUND_UP macro instead of specific code with the same purpose.
> Also, remove the unused variables.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/staging/vt6656/baseband.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)

Please rebase this against my staging-next branch of my staging.git tree
and resend it as it does not apply to it at the moment at all.

thanks,

greg k-h
