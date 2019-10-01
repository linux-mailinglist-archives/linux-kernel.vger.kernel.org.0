Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A9EC3243
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 13:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfJALUJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Oct 2019 07:20:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59752 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbfJALUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:20:08 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iFGCM-0005Ot-9a
        for linux-kernel@vger.kernel.org; Tue, 01 Oct 2019 11:20:06 +0000
Received: by mail-pg1-f199.google.com with SMTP id a31so11007381pgm.20
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8p03PIW0mfMY9KmkRItRfLHi9HckdQkm+AoAxesOob4=;
        b=Ys6ET8r0crNBT0pRwOAbygbCrgHhU/aT79TWf99YYXi+5wm6SsHWhTzHVZ7SRgHBpJ
         KKRW25NGtHibIFd0tEgPBHeGxQqmBU+i29Z5d4pC30r5cakZlcF5bOJ2O5/Rnc1j6tdb
         YQkHNWtZomV3rVUBThSFSDH9AXCLjkWxPqOoHeJI/byMcC3Zfq2gSIquQIZ1wA/ZT0tJ
         RLkpOXS6WS2mCqmNFjTJxEcCIxgr8ixsvayNIC9lnZLX+WMTi5fcEt4EzEyhgJHTR0LL
         Ujd7hPc2A2JvkO6PJ6uMlXkq8hgCaRz+URg3uzTLjeQUkeKVJd+ztK5FzMHHvAGqJYl2
         F8Ew==
X-Gm-Message-State: APjAAAVxD0bW6dW36dp0sSGge8UIizCsRIJAFM6r4e/4ZsRn4kd7/92N
        sZreYWWjm5c+rwPNk78OLLFEfEa5WqZSzUJfSlkZYAt+PupxBo00iOvaYQLcXCatpA1i20Ugjva
        cgRtd9mRhMJ3ui+DQ8j3E+pQ8ysERfNsadDy84rVzRg==
X-Received: by 2002:a17:90a:6547:: with SMTP id f7mr4766186pjs.13.1569928804787;
        Tue, 01 Oct 2019 04:20:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw1AsmTP8jYinyq6QqtsHpMsdxz1vsrrqa9ulpv52JUBiGqYjrxzi8cYoHpEx+4BJrLsVZCUg==
X-Received: by 2002:a17:90a:6547:: with SMTP id f7mr4766156pjs.13.1569928804391;
        Tue, 01 Oct 2019 04:20:04 -0700 (PDT)
Received: from 2001-b011-380f-3c42-1844-8b0c-6a55-1ec2.dynamic-ip6.hinet.net (2001-b011-380f-3c42-1844-8b0c-6a55-1ec2.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:1844:8b0c:6a55:1ec2])
        by smtp.gmail.com with ESMTPSA id w11sm17024335pfd.116.2019.10.01.04.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 04:20:03 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.18\))
Subject: Re: [PATCH] Revert "Input: elantech - enable SMBus on new (2018+)
 systems"
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20191001070845.9720-1-kai.heng.feng@canonical.com>
Date:   Tue, 1 Oct 2019 19:20:01 +0800
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <9EF87E3C-6CE0-4AD2-B2F9-C7FF9D978AFD@canonical.com>
References: <20191001070845.9720-1-kai.heng.feng@canonical.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3594.4.18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

> On Oct 1, 2019, at 15:08, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> This reverts commit 883a2a80f79ca5c0c105605fafabd1f3df99b34c.
> 
> Apparently use dmi_get_bios_year() as manufacturing date isn't accurate
> and this breaks older laptops with new BIOS update.
> 
> So let's revert this patch.
> 
> There are still new HP laptops still need to use SMBus to support all
> features, but it'll be enabled via a whitelist.

Before I make a manifest of devices, do you have any idea of the uniqueness of PNP IDs?
Or should I use DMI strings in this case?

Kai-Heng

> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> drivers/input/mouse/elantech.c | 55 ++++++++++++++++++----------------
> 1 file changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 04fe43440a3c..2d8434b7b623 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1827,31 +1827,6 @@ static int elantech_create_smbus(struct psmouse *psmouse,
> 				  leave_breadcrumbs);
> }
> 
> -static bool elantech_use_host_notify(struct psmouse *psmouse,
> -				     struct elantech_device_info *info)
> -{
> -	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> -		return true;
> -
> -	switch (info->bus) {
> -	case ETP_BUS_PS2_ONLY:
> -		/* expected case */
> -		break;
> -	case ETP_BUS_SMB_HST_NTFY_ONLY:
> -	case ETP_BUS_PS2_SMB_HST_NTFY:
> -		/* SMbus implementation is stable since 2018 */
> -		if (dmi_get_bios_year() >= 2018)
> -			return true;
> -		/* fall through */
> -	default:
> -		psmouse_dbg(psmouse,
> -			    "Ignoring SMBus bus provider %d\n", info->bus);
> -		break;
> -	}
> -
> -	return false;
> -}
> -
> /**
>  * elantech_setup_smbus - called once the PS/2 devices are enumerated
>  * and decides to instantiate a SMBus InterTouch device.
> @@ -1871,7 +1846,7 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
> 		 * i2c_blacklist_pnp_ids.
> 		 * Old ICs are up to the user to decide.
> 		 */
> -		if (!elantech_use_host_notify(psmouse, info) ||
> +		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
> 		    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
> 			return -ENXIO;
> 	}
> @@ -1891,6 +1866,34 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
> 	return 0;
> }
> 
> +static bool elantech_use_host_notify(struct psmouse *psmouse,
> +				     struct elantech_device_info *info)
> +{
> +	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> +		return true;
> +
> +	switch (info->bus) {
> +	case ETP_BUS_PS2_ONLY:
> +		/* expected case */
> +		break;
> +	case ETP_BUS_SMB_ALERT_ONLY:
> +		/* fall-through  */
> +	case ETP_BUS_PS2_SMB_ALERT:
> +		psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
> +		break;
> +	case ETP_BUS_SMB_HST_NTFY_ONLY:
> +		/* fall-through  */
> +	case ETP_BUS_PS2_SMB_HST_NTFY:
> +		return true;
> +	default:
> +		psmouse_dbg(psmouse,
> +			    "Ignoring SMBus bus provider %d.\n",
> +			    info->bus);
> +	}
> +
> +	return false;
> +}
> +
> int elantech_init_smbus(struct psmouse *psmouse)
> {
> 	struct elantech_device_info info;
> -- 
> 2.17.1
> 

