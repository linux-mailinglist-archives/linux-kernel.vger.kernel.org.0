Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6752A07F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 23:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404309AbfEXVjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 17:39:33 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44462 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404266AbfEXVjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:39:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id g18so9953148otj.11;
        Fri, 24 May 2019 14:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MZnuQrVtYhASILoiKgGSvtyaXD30T7mtybpr7EUHkI0=;
        b=FIXIzqSKBdqW3IeEojTsBSxwkf+tO3iVEBqAtzl+CEQJs8uArTpBYsecK7Y27C0KHR
         PVbgykQ1GBD2WELNQK7nrGYSkAZcyC4mTIYQm0WZXp+p/QTGQco6YOwnAM42XQPoDdFD
         lfLs8rF/wGZgytxXgdUxumyOBvg6F1op58UZ/rlgtfze5XhiAu7QmpMVCMkf1gU5ycQo
         dk+e8ocpVaFdQkVNdcftO8HBqzo0a0SZfA+rRjDbRFRwiX71rA/6ZQPImmGdDV4Hn7yC
         JluQC+ToVhHUzZBhfv8CH3hR/ynl2BuJROS+hqOisKUksJSkUwAYj+P5QP5tJDTArx68
         tTAg==
X-Gm-Message-State: APjAAAXyNS2myNjI/sCxpqtoayw5C0G+cC9woQORodUreuBkW8BpS4IX
        E/8u5z/nLumcCImnEWZHYg==
X-Google-Smtp-Source: APXvYqw5BvSOtkT3N952ItPOjBDxdFeno87FHqsvmHwgpc7SH3iSjbrbWBg9qsXShtRYA+fPs87FAg==
X-Received: by 2002:a9d:3b49:: with SMTP id z67mr52513759otb.236.1558733970346;
        Fri, 24 May 2019 14:39:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 63sm1428369ota.28.2019.05.24.14.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 14:39:29 -0700 (PDT)
Date:   Fri, 24 May 2019 16:39:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v2 3/3] of/fdt: Mark initial_boot_params as
 __ro_after_init
Message-ID: <20190524213929.GA11780@bogus>
References: <20190514204053.124122-1-swboyd@chromium.org>
 <20190514204053.124122-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514204053.124122-4-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 13:40:53 -0700, Stephen Boyd wrote:
> The FDT pointer, i.e. initial_boot_params, shouldn't be changed after
> init. It's only set by boot code and then the only user of the FDT is
> the raw sysfs reading API. Mark this pointer with __ro_after_init so
> that the pointer can't be changed after init.
> 
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/of/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
