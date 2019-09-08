Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E107ACECD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfIHNFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 09:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfIHNFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:05:42 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7829218AC;
        Sun,  8 Sep 2019 13:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947942;
        bh=BpW4G5OlFYRFsnxzK33LDdwhTu34uQdmEC2uXFJp6yM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2b8pD7oAMf/WbISUFj4dZEZY7/kzIq8ILCK6Xa7aUj20hiIn9J+jvAB+hBe+Ztmpp
         145C/IiE4qk3vVQuCEwDjpgbHYmgDrsHz4rodwYUG6YlSo0L17VoZYVtLqrYQqHcef
         3/WClAIQyJmuWh9q0f9nsx9pWI1sOyD2jOJg51xk=
Date:   Sun, 8 Sep 2019 14:05:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     hariprasad@osuosl.org, Kelam@osuosl.org, hariprasad.kelam@gmail.com
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: make use of kmemdup
Message-ID: <20190908130540.GA9394@kroah.com>
References: <1567934921-6475-1-git-send-email-hariprasad.kelam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567934921-6475-1-git-send-email-hariprasad.kelam@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 02:58:41PM +0530, hariprasad@osuosl.org wrote:
> From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> 
> fix below issue reported by coccicheck
> drivers/staging//exfat/exfat_super.c:2709:26-33: WARNING opportunity for
> kmemdup
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/exfat/exfat_super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

This doesn't apply to my tree at all, what did you make it against?

thanks,

greg k-h
