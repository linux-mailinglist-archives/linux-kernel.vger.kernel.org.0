Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8859FF2364
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 01:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfKGAmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 19:42:32 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34519 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKGAmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:42:32 -0500
Received: by mail-oi1-f195.google.com with SMTP id l202so455915oig.1;
        Wed, 06 Nov 2019 16:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1JTzFbfhb/cFqOkdjeEU3D+7fvKCSD5Tw7DPVs1gzY4=;
        b=AGJ9iQUaKXLRv2ThQjlrL7KpjvrTubmUHp6iuodXTRRiWWr6ZI69lO9bwETHkcb3sS
         24xMifBO38H+ux+V6oDUG4hCmhJKF0h4lfDLku/5ftUddq46NOI+S0RMzE3oedBOez6x
         y4g86lFY1ViuaNKKeJYEF88kyqdgLmpVgylW1ZHXFjCjwdJhSmbbg2rhcLxfha3T3iMh
         JHVBOKLQ620UNI7R+WFAWK1u61Y3LLhDfpvw0BYmpytdRzxVBeoGEuRkxiie6QZLwN3B
         xG/E96wCMCK7kO49gQ10HQfZRknPh2T7ypZ802rY+fe1fvaW82ddrTjtpYLWDqO1d58G
         DvLw==
X-Gm-Message-State: APjAAAUxUks7MC7InGKsGG3azw8b8GHCdOGh1R7Izqk9xPeMerQsYn/4
        t4qE7SWAvgQ8+EShY1tg+g==
X-Google-Smtp-Source: APXvYqzyVpO1CbsMuh5VXMD2Fxe4IE5P746ZUlNrOoNJSLgcUCEgqmGuvccCrvTh624W6toqeO6JCQ==
X-Received: by 2002:a05:6808:4c3:: with SMTP id a3mr823200oie.40.1573087350765;
        Wed, 06 Nov 2019 16:42:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q3sm201157oti.49.2019.11.06.16.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:42:30 -0800 (PST)
Date:   Wed, 6 Nov 2019 18:42:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] of: property: Minor style clean up of
 of_link_to_phandle()
Message-ID: <20191107004229.GA11145@bogus>
References: <20191105065000.50407-1-saravanak@google.com>
 <20191105065000.50407-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105065000.50407-2-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Nov 2019 22:49:58 -0800, Saravana Kannan wrote:
> Adding a debug log instead of silently ignoring a phandle for an early
> device. Also, return the right error code instead of 0 even though the
> actual execution flow won't change.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
