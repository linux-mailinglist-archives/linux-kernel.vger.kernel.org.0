Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0583DFBB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 23:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKMWNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 17:13:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38630 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMWNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:13:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so2602172pfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 14:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B1TprubRRi78z9gJem80g0pHSHDAim7q+mO0ht29ilM=;
        b=SdspMzPQwDfDssw3Dm56chFpozK5NPuvKrcHR5wGkG4HLmpdHe0b/81EGjpB0Vts7X
         M2/o742K5cFOte7jVr6zGMbe4U2TKFwuugJyKL7X4eOys7si6GU8t11D84a2f7zsNcDe
         g+wkQ6tW73i+cLZivUPduPtKoy/kFsXwhbXEwsczyJlMLGciT0PngZBu7YbzFSphNZaT
         CEnmYLBeZjiuJewKEwE0k4rKza9RfKpBiD6+q2daAHZ3AoKdNuJveVIZEhIss2F9MoMd
         VNaiCDObnp6zvikTDMlo8XXDNOMX7oZuQB/192PwUFe6ysh/2g1CTLEbLQ1ZZkxRarlD
         KfGw==
X-Gm-Message-State: APjAAAVMOvw6KBz+QWxCHpeh65oGgIMcUqAC4bJ13YBFBy+ZkgH7Ib3Z
        7p6glqi2HEFWKR4BB7zP0ic=
X-Google-Smtp-Source: APXvYqwrkwPsaq/318HMgnfBFILwMt348GaPD0y6JM/tNlMtbvWyRlE3YKJ3zXcG1yVYGHseqZ2HZA==
X-Received: by 2002:a63:e306:: with SMTP id f6mr5635390pgh.386.1573683200824;
        Wed, 13 Nov 2019 14:13:20 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g20sm3340474pgk.46.2019.11.13.14.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 14:13:19 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E8D73403DC; Wed, 13 Nov 2019 22:13:18 +0000 (UTC)
Date:   Wed, 13 Nov 2019 22:13:18 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Salyzyn <salyzyn@android.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Tim Murray <timmurray@google.com>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] firmware_class: make firmware caching configurable
Message-ID: <20191113221318.GA11244@42.do-not-panic.com>
References: <20191113210124.59909-1-salyzyn@android.com>
 <20191113215031.GA3944533@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113215031.GA3944533@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 05:50:31AM +0800, Greg Kroah-Hartman wrote:
> On Wed, Nov 13, 2019 at 01:01:13PM -0800, Mark Salyzyn wrote:
> > +config FW_CACHE
> > +	bool "Enable firmware caching during suspend"
> > +	depends on PM_SLEEP
> > +	default y
> And finally, 'default y' is only a good idea if your machine can not
> boot without the option.  I don't think that's the case here, correct?

default y if PM_SLEEP

Would try to enable this if PM_SLEEP was disabled. So the depends on
will force this on for all systems by default if PM_SLEEP is enabled,
which is what how this works today.

We enable this feature today by default if you have PM_SLEEP.

  Luis
