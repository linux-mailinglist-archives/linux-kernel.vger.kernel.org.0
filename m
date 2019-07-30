Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41837A287
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 09:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfG3HtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 03:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbfG3HtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:49:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EABE206E0;
        Tue, 30 Jul 2019 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564472948;
        bh=p0ptAuSfNPLNxxRo3FL5oil0Da165+w0H6OX+7p20eI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkXNIUxOhXVNdls+aru0kxYawa45ajNFvYyxGMSMuObzWG6YjMepQTk4jWs+JE7BL
         cdyWZrtibVn9K6uzCYyCMBVAPy/fDgUQNMoLhtkGN/KPTw9N+be1Cm/JjXr1RTzKeG
         k0aGZ4pume7y1N0+g61kuTpM0WTukgwf2wpYo0QQ=
Date:   Tue, 30 Jul 2019 09:49:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: Remove function
 _rtw_regdomain_select
Message-ID: <20190730074905.GA25897@kroah.com>
References: <20190725173349.GA9894@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725173349.GA9894@hari-Inspiron-1545>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:03:49PM +0530, Hariprasad Kelam wrote:
> This function simply returns &rtw_regdom_rd . So replace this function
> with actual code
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/wifi_regd.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

You have sent 11 patches for this driver in the past few days, and I
have no idea what order to apply them in.

Please resend them all as a patch series, properly numbered so that I
have a chance to apply them in the correct order.

thanks,

greg k-h
