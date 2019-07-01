Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE241B2EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 11:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfEMJeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 05:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfEMJeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:34:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7228620873;
        Mon, 13 May 2019 09:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557740050;
        bh=kJTLGUUtdThcUhGqBndSyEGiN9k9H6DnRb9QiPETZWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GwNFfqw1NmkcxhRYcbxK6UrvdzzxDjiUAS4pGKUkXGcx8VjZ0RutQs9UmyyQYVTqM
         n4bocsWjR5ORimAjtBMtYFeO3UgICVjTLJkEWJBvi9wStf6ANsGdDKFp37iPItP2J9
         tnSA4+sO0ey03uYNl8itjEpsZfNDYm3gmF+A8mWc=
Date:   Mon, 13 May 2019 11:34:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        viswanath.barenkala@gmail.com
Subject: Re: [PATCH] drivers: staging :rtl8723bs :os_dep Remove Unneeded
 variable ret
Message-ID: <20190513093408.GB21213@kroah.com>
References: <20190512113245.GA2221@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512113245.GA2221@hari-Inspiron-1545>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 05:02:45PM +0530, Hariprasad Kelam wrote:
> fix below issue reported by coccicheck
> 
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2685:5-8: Unneeded
> variable: "ret". Return "0" on line 3266
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

For your subject line, put the ' ' character after the ':' character
always please.

Please fix up and resend.

thanks,

greg k-h
