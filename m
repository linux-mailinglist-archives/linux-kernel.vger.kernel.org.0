Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A01F911BDB9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 21:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfLKURO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 15:17:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44607 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfLKURN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:17:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id x3so1046140oto.11;
        Wed, 11 Dec 2019 12:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2kOog/nxmL5zIFNNZZ90lVnWQmMNdsJ1FgZwu+X6u8U=;
        b=qroOTdSGjBnF/60li+TuHa+8dCRKY25ODdu7bVvGciJObQ2fJxH0MxRcqH3Wpb9WA4
         jkAk8jeFsgdNK5YDlsY+TdIWH5tInQfu5JWtsbhYsTyveucQyL5gZjGmLmDoprsmSLBb
         /oyywQkiTYZRv3WteBX6UJYKqkd6WlgUgiG14yom+TJUJ48WVuTpkEismQh2/MPSG1yD
         aVHT9T+cLLx0mK0m0dJUJ1wB9GMiQPlbs0Et4VuIGs4FEZolGAe9IQHrdu7eHW4ejzYX
         z5k3lNarNH4OjO7MZBjf3F+mXFe1CM5dX4KJuoFjoD/jL93d69JJ8qYxGC3UMqf7WslN
         mZmQ==
X-Gm-Message-State: APjAAAVbNgzQhaJ5YmbloMqr1e1Phhp0DD7fPn3Ft5UCzxdcDIo5OBWx
        nUtwn0g+zPmZpaFeOld4WA==
X-Google-Smtp-Source: APXvYqyjqnX8GcW1vg1KWzt1cWhIj1i9DfZ54zAp7YBQMZxmrNN0sMbcKww8+nEKrb4E2rBtiJyDsQ==
X-Received: by 2002:a05:6830:1e7c:: with SMTP id m28mr3868872otr.131.1576095432613;
        Wed, 11 Dec 2019 12:17:12 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u11sm1154757oie.53.2019.12.11.12.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 12:17:12 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:17:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        kernel test robot <lkp@intel.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] of/platform: Unconditionally pause/resume sync state
  during kernel init
Message-ID: <20191211201711.GA19428@bogus>
References: <20191209193119.147056-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209193119.147056-1-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Dec 2019 11:31:19 -0800, Saravana Kannan wrote:
> Commit 5e6669387e22 ("of/platform: Pause/resume sync state during init
> and of_platform_populate()") paused/resumed sync state during init only
> if Linux had parsed and populated a devicetree.
> 
> However, the check for that (of_have_populated_dt()) can change after
> of_platform_default_populate_init() executes.  One example of this is
> when devicetree unittests are enabled.  This causes an unmatched
> pause/resume of sync state. To avoid this, just unconditionally
> pause/resume sync state during init.
> 
> Fixes: 5e6669387e22 ("of/platform: Pause/resume sync state during init and of_platform_populate()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Frank Rowand <frowand.list@gmail.com>
> ---
> 
> v1->v2:
> - Updated the commit text to address Frank's comments
> - Added Frank's R-b
> v2->v3:
> - Added this change log to address Greg's comments
> 
>  drivers/of/platform.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Rob
