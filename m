Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46FFC18FB84
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 18:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgCWRa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 13:30:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:38176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgCWRa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:30:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A8B1CAC26;
        Mon, 23 Mar 2020 17:30:57 +0000 (UTC)
Date:   Mon, 23 Mar 2020 10:29:54 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     oneukum@suse.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 7/8] usb, cdc-acm: optimize barrier usage for Rmw atomic
 bitops
Message-ID: <20200323172954.pyxw5v4pmuvkbjrp@linux-p48b>
References: <20200129181545.25302-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129181545.25302-1-dave@stgolabs.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping? Can these please be picked up?

On Wed, 29 Jan 2020, Davidlohr Bueso wrote:

>We can avoid the unnecessary barrier on non LL/SC architectures,
>such as x86. Instead, use the smp_mb__after_atomic() call.
>
>Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>---
> drivers/usb/class/cdc-acm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
>index 62f4fb9b362f..0bc4b558f387 100644
>--- a/drivers/usb/class/cdc-acm.c
>+++ b/drivers/usb/class/cdc-acm.c
>@@ -842,7 +842,7 @@ static void acm_tty_unthrottle(struct tty_struct *tty)
> 	clear_bit(ACM_THROTTLED, &acm->flags);
>
> 	/* Matches the smp_mb__after_atomic() in acm_read_bulk_callback(). */
>-	smp_mb();
>+	smp_mb__after_atomic();
>
> 	acm_submit_read_urbs(acm, GFP_KERNEL);
> }
>-- 
>2.16.4
>
