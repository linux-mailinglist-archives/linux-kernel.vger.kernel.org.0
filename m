Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C5832246
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 08:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfFBGUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 02:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfFBGUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 02:20:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E2124F6A;
        Sun,  2 Jun 2019 06:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559456450;
        bh=vhBKwCxwAgvEEdMJpzjBTxKgav4wSMPXDFR+K4mBLm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FnYNb4YAy5jvKsdSs5P79OE5CNT9qtCcKA9hBr4W+qmUs/+UeTKaMRZXENw8A0i0A
         JSle85ss5/U+eNgxkyQm3cWV/9g40GbDz5IwpPjOiqLPB/s/kVvowVK9XUyexmfEyI
         qDnI5XqhBBogc5exi+uc5HR4B0VsjA5HArGN3xis=
Date:   Sun, 2 Jun 2019 08:20:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Mishra <linux.dkm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, himadri18.07@gmail.com,
        straube.linux@gmail.com
Subject: Re: [PATCH 0/8] staging: rtl8712: Fixed CamelCase in struct _adapter
 from drv_types.h
Message-ID: <20190602062047.GA12076@kroah.com>
References: <cover.1559412149.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559412149.git.linux.dkm@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2019 at 12:13:34AM +0530, Deepak Mishra wrote:
> This patchset fixes CamelCase checks in struct _adapter in drv_types.h
> and in files where struct _adapter is used by renaming the variables
> without camel case. 
> 
> These check were reported by checkpatch.pl
>   
> Deepak Mishra (8):
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h

All of these patches had the same subject line, yet did diffferent
things, that's not ok :(

Please fix this series up to have unique subject lines and resend.

thanks,

greg k-h
