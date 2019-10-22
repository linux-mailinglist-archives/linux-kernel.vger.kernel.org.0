Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5111E07DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 17:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbfJVPtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 11:49:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35721 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388438AbfJVPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:49:16 -0400
Received: by mail-oi1-f196.google.com with SMTP id x3so14625030oig.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fW5P1wesLCHZQObDiW106qVWcGlV18+kX2FDeNS0bDU=;
        b=TRPruYNbISBS+7rIpRO5ztgbH0jMfci9ZE0JHzU7QzNPDCtFBXmWOUOWwc3VKUBX5V
         yg0Jtrd05x32ud6NRmSGLXWYNdee8wae9FiYboOYE5viUmmRktj16zBdoSQBLjT9+5vp
         1m4Vdph2FcVAR52D/MlxUceq0dz1slR8B9PGkxJnQEd7UFLkT3yDWOO79y68Rb1HBoHk
         oqoaltanJskEcPWQ3rVd1n5O7N4UTJZgLN9HIAWLhXiDh2pTrL6cOHQGDb+fs4eY2Gmi
         VM9m96fmVLqOkr7d+TY3XRt1T0xYm8GrKneHolADTDd0PaKgzc10t4e1evq+lwAEoqh9
         YDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=fW5P1wesLCHZQObDiW106qVWcGlV18+kX2FDeNS0bDU=;
        b=MFoaXOZ6YkpBT6Mv5Xa4Pgw5lRy7wHVRpD2slUyY3XK5JoePlloYUYA3Y36ffkmezq
         /F53DsbHXAJ297ECe8EYEJN2IocwyQmMj98kUhM5yo65+LHF13KB6sS7BUHAubxxg6Ez
         2DV0978iD+XrQg4OU6qD0DSNly4oU6QaTr7IuqRw4Vehran2lMQ7ricehFOXvlCdUDUO
         Z4+FkBmtzII7qXSVl1il+KNMIyy9gpMdkmx7PxY7nhUnkJ5Y7CPjunj+UUWTv+NItolM
         rKJMlLd37DLbf+mWvYjsIeJPEmBb4y8zvi/CgMjOP8dMRbTUeAnklY8Gm3oCdXxkFrpJ
         a2UQ==
X-Gm-Message-State: APjAAAVNGO2QNk7nyi8lImAPCRD3MaKwDLA6pkCX6TrjcPQXHqjjGL2e
        vw9pocCCxfvfQm0xxWksYw==
X-Google-Smtp-Source: APXvYqzbd5bU2MoNBaWevjpW/u6WPXzyk3+hUZtvzTptH1YvNf6I4IJfw3gYMcRxx7zRykXzG8Oohg==
X-Received: by 2002:aca:dd07:: with SMTP id u7mr3706712oig.106.1571759355176;
        Tue, 22 Oct 2019 08:49:15 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id z10sm5423031ote.54.2019.10.22.08.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 08:49:14 -0700 (PDT)
Received: from t560 (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id DACE2180044;
        Tue, 22 Oct 2019 15:49:13 +0000 (UTC)
Date:   Tue, 22 Oct 2019 10:49:12 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: Fix memory leak in __ipmi_bmc_register
Message-ID: <20191022154912.GT14232@t560>
Reply-To: minyard@acm.org
References: <20191021200649.1511-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021200649.1511-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 03:06:48PM -0500, Navid Emamdoost wrote:
> In the impelementation of __ipmi_bmc_register() the allocated memory for
> bmc should be released in case ida_simple_get() fails.

Thanks, queued for next merge window.

-corey

> 
> Fixes: 68e7e50f195f ("ipmi: Don't use BMC product/dev ids in the BMC name")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 2aab80e19ae0..e4928ed46396 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -3031,8 +3031,11 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
>  		bmc->pdev.name = "ipmi_bmc";
>  
>  		rv = ida_simple_get(&ipmi_bmc_ida, 0, 0, GFP_KERNEL);
> -		if (rv < 0)
> +		if (rv < 0) {
> +			kfree(bmc);
>  			goto out;
> +		}
> +
>  		bmc->pdev.dev.driver = &ipmidriver.driver;
>  		bmc->pdev.id = rv;
>  		bmc->pdev.dev.release = release_bmc_device;
> -- 
> 2.17.1
> 
