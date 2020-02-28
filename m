Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BADC173EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 18:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgB1R4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 12:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1R4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:56:14 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C40ED2469F;
        Fri, 28 Feb 2020 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582912574;
        bh=bKRk8j6zbi5giOIXy9zRlMJqv+wENeI9FF+psFDMeMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Binu4FcGs9Riko9csXM9x9D2NmqI+3pmCy4xJVSgWZgoPO3nUfwl/QTstNgOq6YnD
         H2DcbmB1N1cKKox7a8yKvBwyaa5rBuXz03AgfKNKgY0gw93eRxpqwy+a4KKcvoM0K5
         mQpj67XZ03bMgWzbtwEL/0enI5FHcqLGgcF36FuU=
Date:   Fri, 28 Feb 2020 09:56:11 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bitfield.h: add FIELD_MAX() and field_max()
Message-ID: <20200228095611.023085fd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200228165343.8272-1-elder@linaro.org>
References: <20200228165343.8272-1-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 10:53:43 -0600 Alex Elder wrote:
> Define FIELD_MAX(), which supplies the maximum value that can be
> represented by a field value.  Define field_max() as well, to go
> along with the lower-case forms of the field mask functions.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
> 
>  NOTE:	I'm not entirely sure who owns/maintains this file so
> 	I'm sending it to those who have committed things to it.
> 	I hope someone will just take it in after review; I use
> 	field_max() in some code I'm about to send out.

Could you give us an example use?

Is it that you find the current macros misnamed or there's something
you can't do? Or are you trying to set fields to max?
