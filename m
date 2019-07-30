Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B1A7AE37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 18:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfG3QnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 12:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfG3QnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:43:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988B320693;
        Tue, 30 Jul 2019 16:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564504987;
        bh=Bhgt8Kdpcka64EAoLz5x80I0JjzdBQzRn8FJLr0MPG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODMySGlBeblAC/zzdqMy/4bUZq7KbqAx+8YEvJadvyWGDlQUpK1s5vNsUPK0RHnu6
         /rahrjWk6TXDW5lyChNSyx/lbp6uVUVvEsuXph0L6yFsqQVX5lpeM7d3EV9KgRqdI8
         rzrmcpjwISfQIXqwXs+Z8uF6B3yn8+BS90v89xCE=
Date:   Tue, 30 Jul 2019 18:43:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     devel@driverdev.osuosl.org, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>, emamd001@umn.edu,
        Nishka Dasgupta <nishkadg.linux@gmail.com>, smccaman@umn.edu,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH v2] rtl8192_init_priv_variable: null check is missing for
 kzalloc
Message-ID: <20190730164304.GA10640@kroah.com>
References: <20190725124528.GA21757@kroah.com>
 <20190730143102.6662-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730143102.6662-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 09:30:58AM -0500, Navid Emamdoost wrote:
> Allocation for priv->pFirmware may fail, so a null check is necessary.
> priv->pFirmware is accessed later in rtl8192_adapter_start. I added the
>  check and made appropriate changes to propagate the errno to the caller.
> 
> Update: fixed style errors

The "changelog" goes below the --- line, as is described in the kernel
documentation.

Also, please look at other patches for this driver, use the same prefix
for the subject line as those did.

v3 please?

thanks,

greg k-h
