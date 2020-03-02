Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4D317610F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 18:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgCBRbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 12:31:25 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46035 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgCBRbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:31:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id f21so1972299otp.12;
        Mon, 02 Mar 2020 09:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NVPKgHFg9MVyiT7cHNOydbqZKAk4BoNFFQmkh5sX568=;
        b=E2PxvYbZwoHkCYwVTGXf8rnoCKuXV7GehIIvQEH2xqXBrARISieiwO9Gpwog4SYiW2
         RWqGzIUtLzQdPsyM1sHo/JEzNcwNbdHW5pgYUOfaqIkM/+9gimn/rD3P+/S4uDA49fHR
         MCcz9KPO5MRLm3N15WDLubVdd24eoZ80kZ2cov3myAOU0khqzL9+5trl3InaZEd0StPz
         7JkFBG2d6mxNmAaMuB4b4Bg5oCXyGsH8zq2ShnXjF+KgmDPZeYTStyqhwYnMfVy59ZxR
         tQQz1rOFplpwoykG2xv6KhgwnKgzChYkWHjGu0W8BNPwH7YdMlKhgm9uKt/e/BH8XyQc
         8VTw==
X-Gm-Message-State: ANhLgQ37815NbSltr39bC30fphKgZ78vJY6NtLABegIhFWIWKHMx4Fbl
        hHatk8jSyvemohvbWpeAYw==
X-Google-Smtp-Source: ADFU+vsOEBDrhuF9b2zzGgSXC8vvB25Jr9LwNXhpajjyIjPQFJ5pvjn+vl2o0/QC1t0+j7MLLDxw8g==
X-Received: by 2002:a9d:23b6:: with SMTP id t51mr200652otb.15.1583170284181;
        Mon, 02 Mar 2020 09:31:24 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p65sm6547379oif.47.2020.03.02.09.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:31:23 -0800 (PST)
Received: (nullmailer pid 12413 invoked by uid 1000);
        Mon, 02 Mar 2020 17:31:23 -0000
Date:   Mon, 2 Mar 2020 11:31:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alan Tull <atull@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] of: unittest: make gpio overlay test dependent on
 CONFIG_OF_GPIO
Message-ID: <20200302173123.GA12343@bogus>
References: <1582863389-3118-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582863389-3118-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 22:16:29 -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Randconfig testing found compile errors in drivers/of/unittest.c if
> CONFIG_GPIOLIB is not set because CONFIG_OF_GPIO depends on
> CONFIG_GPIOLIB.  Make the gpio overlay test depend on CONFIG_OF_GPIO.
> 
> No code is modified, it is only moved to a different location and
> protected with #ifdef CONFIG_OF_GPIO.  An empty
> of_unittest_overlay_gpio() is added in the #else.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 465 ++++++++++++++++++++++++++------------------------
>  1 file changed, 238 insertions(+), 227 deletions(-)
> 

Applied, thanks.

Rob
