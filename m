Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F6343D59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfFMPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731888AbfFMJup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:50:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0188E20896;
        Thu, 13 Jun 2019 09:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560419444;
        bh=PpeT9VU2erDRkCNoGBBH48Cc61wP3h71WxXB0A/GzrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmdZW/8MwTluVDoHeT+7w8rueLxvdgt+8NBIsT4o7FnT3svFK9XywHpFpyUYbWq+h
         cXhc4oeCpUshCeRJqh20FIJR6FCgQi1KwWmOCM8g47YUDa4a2SSU/ClXjLf9E5uE6E
         GO+sR1HRSaOg8C4TDpxCr4r9Z7LvUiCRLFc6Xvt4=
Date:   Thu, 13 Jun 2019 11:50:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8723bs: hal: sdio_halinit: fix
 comparison to true/false is error prone
Message-ID: <20190613095042.GA17445@kroah.com>
References: <20190612022956.GA23698@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612022956.GA23698@hari-Inspiron-1545>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 07:59:57AM +0530, Hariprasad Kelam wrote:
> CHECK: Using comparison to false is error prone
> CHECK: Using comparison to true is error prone
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Patch seems to be corrupt, please rebase and resend.

thanks,

greg k-h
