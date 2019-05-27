Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C402BB66
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 22:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfE0U2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 16:28:24 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:50826 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0U2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:28:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 20C932ED4;
        Mon, 27 May 2019 22:28:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GaWlTzEBuJG2; Mon, 27 May 2019 22:28:21 +0200 (CEST)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 3E6AE1969;
        Mon, 27 May 2019 22:28:21 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1hVMEF-00042b-Nw; Mon, 27 May 2019 22:28:19 +0200
Date:   Mon, 27 May 2019 22:28:19 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: speakup: serialio: fix warning
 linux/serial.h is included more than once
Message-ID: <20190527202819.mh635ht2jf4ku7rl@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190526071322.GA3830@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526071322.GA3830@hari-Inspiron-1545>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Kelam, le dim. 26 mai 2019 12:43:22 +0530, a ecrit:
> fix below warning reported by  includecheck
> 
> ./drivers/staging/speakup/serialio.h: linux/serial.h is included more
> than once.
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

That was indeed the result of f79b0d9c223ca09cefffc72304a7bcbc401a1c6f
("staging: speakup: Fixed warning <linux/serial.h> instead of
<asm/serial.h>") which didn't take care of the inclusion above.
I believe <linux/serial.h> only is fine, the important part is in
drivers/staging/speakup/serialio.c which really needs to include
asm/serial.h to get SERIAL_PORT_DFNS

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/staging/speakup/serialio.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/speakup/serialio.h b/drivers/staging/speakup/serialio.h
> index aa691e4..6f8f86f 100644
> --- a/drivers/staging/speakup/serialio.h
> +++ b/drivers/staging/speakup/serialio.h
> @@ -4,9 +4,6 @@
>  
>  #include <linux/serial.h>	/* for rs_table, serial constants */
>  #include <linux/serial_reg.h>	/* for more serial constants */
> -#ifndef __sparc__
> -#include <linux/serial.h>
> -#endif
>  #include <linux/serial_core.h>
>  
>  #include "spk_priv.h"
> -- 
> 2.7.4
> 

-- 
Samuel
> No manual is ever necessary.
May I politely interject here: BULLSHIT.  That's the biggest Apple lie of all!
(Discussion in comp.os.linux.misc on the intuitiveness of interfaces.)
