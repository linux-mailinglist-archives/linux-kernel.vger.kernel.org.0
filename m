Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7D369BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 21:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbfGOTx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 15:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729525AbfGOTx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:53:59 -0400
Received: from localhost (unknown [88.128.80.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C605620659;
        Mon, 15 Jul 2019 19:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563220438;
        bh=n6cm3L6dN1BEISYwsj9HOpKQvIB6z17LN6vs4l7AxGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0PchMxTgtkRsW4x6czb9dBemK3Z58TGgPvh0urhrrgA0x/DmNEyoBH99H4kzujGoG
         A5S0u/VnIw8SvygmxhZ8SJYnHJsOwF+wuM7HXWCJeqfhNeJNx0GnaAk6BBYaSmn3uw
         L4qRV56lYNs46CCNW0GnW2gcJz7KB9hamUEWKaPk=
Date:   Mon, 15 Jul 2019 21:37:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Emanuel Bennici <benniciemanuel78@gmail.com>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Larry.Finger@lwfinger.net
Subject: Re: [PATCH] staging: rtl8723bs: core: Remove code valid only for 5GHz
Message-ID: <20190715193731.GB27406@kroah.com>
References: <20190714172826.GA6950@hari-Inspiron-1545>
 <CA+d=JG=Zyy_azX2eENRBa366TV3GppNBmZ+r8CggM+YGqVY9aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+d=JG=Zyy_azX2eENRBa366TV3GppNBmZ+r8CggM+YGqVY9aQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 08:51:30AM +0200, Emanuel Bennici wrote:
>  As per TODO ,remove code valid only for 5 GHz(channel > 14).
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> Reviewed-by: Emanuel Bennici <benniciemanuel78@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Please do not send html email to a kernel mailing list :(

Also, what did you do here?  Why resend the whole thing?

confused,

greg k-h
