Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD261B207
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 10:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfEMIoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 04:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfEMIoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:44:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20DD62084A;
        Mon, 13 May 2019 08:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557737041;
        bh=ugMALw/O3cXPViqg+8RfbM4wNDJ1LAMUNwNjIhWmq3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeReko0CXz8ySA+Ei2LgTAdAe8Wk/ng0mpVKNPA+6RSldcAGioXQhSeUFhBWJmADV
         orKwl8F7ZL+OLqBZ6MLq7jOisf1eAXWm2uk/jZSejuh1FZFqYLTZV6wnGlGC7595+N
         uVdEz78Hn6PTL2wN73zBvo7PeT1mOYiZdWB9AZ+Q=
Date:   Mon, 13 May 2019 10:43:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Colin Ian King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        viswanath.barenkala@gmail.com
Subject: Re: [PATCH] staging: rtl8723bs: core fix warning  Comparison to bool
Message-ID: <20190513084358.GB17959@kroah.com>
References: <20190512122449.GA28268@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512122449.GA28268@hari-Inspiron-1545>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 05:54:49PM +0530, Hariprasad Kelam wrote:
> fix below issue reported by coccicheck
> 
> drivers/staging/rtl8723bs/core/rtw_mlme.c:1675:6-10: WARNING: Comparison
> to bool
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You sent 3 patches that do different things, yet have the same subject
line :(

Please fix up and send as a numbered patch series, or better yet, fix
the same thing in the whole file all at ince.

thanks,

greg k-h
