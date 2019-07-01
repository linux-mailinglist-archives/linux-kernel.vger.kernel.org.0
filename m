Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 745905B558
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 08:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfGAGxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 02:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbfGAGxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:53:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B506620663;
        Mon,  1 Jul 2019 06:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561964024;
        bh=odWFKN/v6uhJ1wZgS3JZoIz8uAE4V7d8K7ikdqDiizc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDDq4nK31Qe0QMmIlQI0ShcHdCjqdzm2mx4JIVE/ppBqGuyh9NzvE56GHJhk7KJqp
         t//eppnFnh4OXVqSzagqK33KHVX4SthEFLRyAjwQIYLIfUmzhFZN9Rta3qB+SV+Zoh
         RPcO8tIzb7NafFAFQr53YaL1bcJ/14X/QnLmBLGY=
Date:   Mon, 1 Jul 2019 08:53:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] staging/rtl8723bs/hal: fix comparison to
 true/false is error prone
Message-ID: <20190701065341.GA2481@kroah.com>
References: <20190629101909.GA14880@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629101909.GA14880@hari-Inspiron-1545>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2019 at 03:49:09PM +0530, Hariprasad Kelam wrote:
> fix below issues reported by checkpatch
> 
> CHECK: Using comparison to false is error prone
> CHECK: Using comparison to true is error prone
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/hal_intf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

As Dan said, you sent 10 patches with the same subject, so I can't take
these.

Also, please properly "thread" the patches so they show up linked to
each other.  git send-email will do this automatically for you if you
use it (and you should) for multiple emails.

thanks,

greg k-h
