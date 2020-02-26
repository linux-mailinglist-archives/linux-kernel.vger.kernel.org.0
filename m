Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4165116F4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 02:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgBZBMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 20:12:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40888 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgBZBMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:12:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id t24so424535pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 17:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6uX/nJPriJhQm0pTaKBAXAE1KxbsYiYr0UB81o3mu3c=;
        b=ZUieuG1LEZrc+9UMd8Wjg9qwl8Km3LnAYcJc34XaejDqleddc1z6mkrin5d2aNGbnx
         1kxPiDHq3D7QAFjE7Np/pfMOnDRrYe9eREd/gDffXMjTkuFZoxzH96UVdirYAllTyMSD
         Y3xw8W4nd+mMxqiylK+WwywhatDceOMfSLwEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6uX/nJPriJhQm0pTaKBAXAE1KxbsYiYr0UB81o3mu3c=;
        b=Rp+iYDejV3KNfIOMfSVJzavobMTFHIAkM1ASHK1cewUpAOBkTibFEVIInDTsvolHm0
         2cAd6LLz7Uc5UB50GcM4z3AoyOWqylE4b3Zd83zP7atLGNjlI8vwR4RdZhtg5x4T7OyA
         LwN0uc+JB71aMIPVuKhWUII6D2x6gtp/GhCh9slOs/oK1ko0Awk2HnAuYK7U99DR3Yih
         EgFaA1SoCBAYxAYKq1BkL8mE58AkX0XK6SaROdfkErOxF7863a9Gr6XNgPpFJKF78i5O
         S/okW2ZqUlCTP8S1TyzO8EUkszn1ci+75HzNQEAnzXXWxVyJl+YnoQEGMYwemLGuCfx3
         MBig==
X-Gm-Message-State: APjAAAUiHUV2FeXSanhaRG6ANu2sw3ih62FeodbeocnzGrbc/9aXdJ+r
        H4uCrPNlNgdJdQYHK5jVTx/HKLVYQBM=
X-Google-Smtp-Source: APXvYqzrHVv6NdG4njh41aTPOq431N0eMbjw8Fo1OeFZkv+MOqi4PyYAAAwFt/ENjO4X1RKyvNihRg==
X-Received: by 2002:a62:f94d:: with SMTP id g13mr1537803pfm.60.1582679530660;
        Tue, 25 Feb 2020 17:12:10 -0800 (PST)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id w21sm209079pgc.87.2020.02.25.17.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 17:12:10 -0800 (PST)
Date:   Tue, 25 Feb 2020 17:12:08 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, Enrico Granata <egranata@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ting Shen <phoenixshen@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fei Shao <fshao@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Evan Green <evgreen@chromium.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH 0/8] Migrate all cros_ec_cmd_xfer() calls to
 cros_ec_cmd_xfer_status()
Message-ID: <20200226011208.GD197302@google.com>
References: <20200220155859.906647-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220155859.906647-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 04:58:51PM +0100, Enric Balletbo i Serra wrote:
> Dear all,
> 
> The purpose of this series is get rid of the remaining places where the
> cros_ec_cmd_xfer() function is used in favour of the
> cros_ec_cmd_xfer_status() helper. This allows us to make the
> cros_ec_cmd_xfer() function private and only expose to the users a
> single way to send commands to the Embedded Controller.
> 
> With these changes we also want to help future improvements in the
> interface, like the Prashant's series (i.e [1]) to introduce a
> cros_ec_cmd() that will allow us to remove more duplicated code in
> different places.
> 
> Best regards,
>  Enric
> 
> Note: Prashant, looks like you should fix your sendmail as the patches
>       are not threaded.
> 
> [1] https://lkml.org/lkml/2020/2/5/614
> 
> Enric Balletbo i Serra (8):
>   platform/chrome: cros_ec_proto: Report command not supported
>   Input: cros_ec_keyb: Use cros_ec_cmd_xfer_status helper
>   platform/chrome: cros_ec_vbc: Use cros_ec_cmd_xfer_status helper
>   platform/chrome: cros_ec_chardev: Use cros_ec_cmd_xfer_status helper
>   platform/chrome: cros_ec_sysfs: Use cros_ec_cmd_xfer_status helper
>   platform/chrome: cros_ec_lightbar: Use cros_ec_cmd_xfer_status helper
>   platform/chrome: cros_ec: Use cros_ec_cmd_xfer_status helper
>   platform/chrome: cros_ec_proto: Do not export cros_ec_cmd_xfer()

I picked this series on a device running 4.19 and didn't see any
unusual behaviour or dmesg logs, so for the entire series:

Tested-by: Prashant Malani <pmalani@chromium.org>
> 
>  drivers/input/keyboard/cros_ec_keyb.c       | 14 +++---
>  drivers/platform/chrome/cros_ec.c           |  2 +-
>  drivers/platform/chrome/cros_ec_chardev.c   |  2 +-
>  drivers/platform/chrome/cros_ec_lightbar.c  | 50 ++++++---------------
>  drivers/platform/chrome/cros_ec_proto.c     | 14 ++++--
>  drivers/platform/chrome/cros_ec_sysfs.c     | 36 +++++++--------
>  drivers/platform/chrome/cros_ec_vbc.c       |  4 +-
>  include/linux/platform_data/cros_ec_proto.h |  3 --
>  8 files changed, 50 insertions(+), 75 deletions(-)
> 
> -- 
> 2.25.0
> 
