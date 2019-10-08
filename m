Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E44CFA04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbfJHMiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 08:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730332AbfJHMiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:38:05 -0400
Received: from localhost (unknown [89.205.136.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBC79206B6;
        Tue,  8 Oct 2019 12:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570538284;
        bh=Z0BM+J1jAE5H0wQdt5a1vbyjRdwVrmzryIUyKBCtl3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMmYkIDQkXBAhT88J0DPoQhQa4/8/x1OJpjv/bSYL3sGwlo8OzAsWSGRts5rkxYH/
         JRm5cZPceseeNf7sgVx8jaBQCA47z9UOwFoKutVPZvJc67E/z9Jzn1fcggH3XR+tSi
         Mywm3N5DGPb+UWbdbivk2qoxN44CAZlSC8z7ejPQ=
Date:   Tue, 8 Oct 2019 14:38:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     hariprasad@osuosl.org, Kelam@osuosl.org, hariprasad.kelam@gmail.com
Cc:     devel@driverdev.osuosl.org,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        linux-kernel@vger.kernel.org,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: Re: [PATCH] rtl8723bs: core: Remove code valid only for 5GHZ
Message-ID: <20191008123801.GB2763989@kroah.com>
References: <1569765348-20417-1-git-send-email-hariprasad.kelam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569765348-20417-1-git-send-email-hariprasad.kelam@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 07:24:57PM +0530, hariprasad@osuosl.org wrote:
> From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> 
> As per TODO ,remove code valid only for 5 GHz(channel > 14).
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)

Your email client is really messed up and got the From: line wrong in
your tool.  Please fix up and resend.

thanks,

greg k-h
