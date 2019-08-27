Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 158C49F2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfH0S4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 14:56:38 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40400 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730486AbfH0S4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:56:38 -0400
Received: (qmail 1525 invoked by uid 2102); 27 Aug 2019 14:56:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Aug 2019 14:56:36 -0400
Date:   Tue, 27 Aug 2019 14:56:36 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     gregkh@linuxfoundation.org, <bauer.chen@realtek.com>,
        <ricky_wu@realtek.com>, <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] USB: storage: ums-realtek: Whitelist auto-delink
 support
In-Reply-To: <20190827173450.13572-2-kai.heng.feng@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1908271454110.1545-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019, Kai-Heng Feng wrote:

> Auto-delink requires writing special registers to ums-realtek devices.
> Unconditionally enable auto-delink may break newer devices.
> 
> So only enable auto-delink by default for the original three IDs,
> 0x0138, 0x0158 and 0x0159.
> 
> Realtek is working on a patch to properly support auto-delink for other
> IDs.
> 
> BugLink: https://bugs.launchpad.net/bugs/1838886
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
> - Whitelisting instead of adding new module parameter.
> v2:
> - Use auto_delink_support instead of auto_delink_enable.
> 
>  drivers/usb/storage/realtek_cr.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
> index beaffac805af..1d9ce9cbc831 100644
> --- a/drivers/usb/storage/realtek_cr.c
> +++ b/drivers/usb/storage/realtek_cr.c
> @@ -996,12 +996,15 @@ static int init_realtek_cr(struct us_data *us)
>  			goto INIT_FAIL;
>  	}
>  
> -	if (CHECK_FW_VER(chip, 0x5888) || CHECK_FW_VER(chip, 0x5889) ||
> -	    CHECK_FW_VER(chip, 0x5901))
> -		SET_AUTO_DELINK(chip);
> -	if (STATUS_LEN(chip) == 16) {
> -		if (SUPPORT_AUTO_DELINK(chip))
> +	if (CHECK_PID(chip, 0x0138) || CHECK_PID(chip, 0x0158) ||
> +	    CHECK_PID(chip, 0x0159)) {
> +		if (CHECK_FW_VER(chip, 0x5888) || CHECK_FW_VER(chip, 0x5889) ||
> +				CHECK_FW_VER(chip, 0x5901))
>  			SET_AUTO_DELINK(chip);
> +		if (STATUS_LEN(chip) == 16) {
> +			if (SUPPORT_AUTO_DELINK(chip))
> +				SET_AUTO_DELINK(chip);
> +		}
>  	}
>  #ifdef CONFIG_REALTEK_AUTOPM
>  	if (ss_en)

For both patches in this series:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Shouldn't this patch go into the -stable kernels as well?

Alan Stern

