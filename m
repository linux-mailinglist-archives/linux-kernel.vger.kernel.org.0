Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA59910ED85
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 17:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfLBQwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 11:52:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbfLBQwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:52:35 -0500
Received: from localhost (unknown [84.241.196.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D49942070B;
        Mon,  2 Dec 2019 16:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575305554;
        bh=xJBJvSL3GUEfnOnsDo3rzGZ6aEPZyboM5lRyhSJW4Eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a1FnBeHviNvR/pCrAAXdaUNMILZKPdQpMdlBjbr66FQ5jEKQDot4LeBle1LwAPHOD
         Ti3c+TqzrAj0xa1R6aFlNiPW4wMoD872WIqdF2nvHKGWQF9KQcQJjA2dZXvLCd8+99
         AoIPJW9IgaIKbld8iy8k2BzFKFBhsNQwQksee+Ow=
Date:   Mon, 2 Dec 2019 17:52:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devel@driverdev.osuosl.org, Julia Lawall <julia.lawall@lip6.fr>,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [PATCH] staging/octeon: Mark Ethernet driver as BROKEN
Message-ID: <20191202165231.GA728202@kroah.com>
References: <20191202141836.9363-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202141836.9363-1-linux@roeck-us.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 06:18:36AM -0800, Guenter Roeck wrote:
> The code doesn't compile due to incompatible pointer errors such as
> 
> drivers/staging/octeon/ethernet-tx.c:649:50: error:
> 	passing argument 1 of 'cvmx_wqe_get_grp' from incompatible pointer type
> 
> This is due to mixing, for example, cvmx_wqe_t with 'struct cvmx_wqe'.
> 
> Unfortunately, one can not just revert the primary offending commit, as doing so
> results in secondary errors. This is made worse by the fact that the "removed"
> typedefs still exist and are used widely outside the staging directory,
> making the entire set of "remove typedef" changes pointless and wrong.

Ugh, sorry about that.

> Reflect reality and mark the driver as BROKEN.

Should I just delete this thing?  No one seems to be using it and there
is no move to get it out of staging at all.

Will anyone actually miss it?  It can always come back of someone
does...

thanks,

greg k-h
