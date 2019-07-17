Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6526C6BFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 18:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfGQQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 12:50:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38415 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbfGQQuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:50:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id n11so24065249qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XH5XQyD8DWa/SvKRgH4wl/Y2fbyFH6tgDRoMo0vIhhY=;
        b=gB1evY8iTPI6wfVzoXC+7BeHJtHWmdvHLjC8PnnCntCDln0SaiT2PXdqU5NYqnog3Z
         XVB5Wt3nYRL6NuSs0CgYTHiJ91zMm8i5A81ZY8q2OAH0hiFpILG6UlKl8OSyLTGD8cSQ
         YM5FKH8IAtdRDsohoy5a1a677OGbxx4mc8fRnGAL8Lbiu5KCl/VjYZj8EzP6gqX1kiim
         wTToDzhldW1cNFTwySsulv3c3NlWbkEyOcNVJVKWhqMsSNqXgDc0qMh1+GEkaEQYT1pJ
         mWlsw/RSPEDQI3q7NbArQVrjeu9lm/gboJDHJdWa+ZNgQDYbIFqtoRXzJIActcXSbrEI
         M54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XH5XQyD8DWa/SvKRgH4wl/Y2fbyFH6tgDRoMo0vIhhY=;
        b=XrHlp/0gBGkhU/k47mlelpem/RbfpvcMALJvja/RNbWdgNmunqSxCuJYmQQ9eYao5b
         BfAtNsE21TtYpGjqYQcNy/Qg8DloneeJGp01khgWqnQkazdY4dLAop+Ci7+i1UIH7LxY
         DuSwMdSHRySOCBXeiWci8Tr0HcwSN58Y19AfF/3q5TW9xpEiAO+zsUnSYLSsrsRvqtAS
         SkspEwGh78bZ7JTiKo1hSEA0poyDKhBGMYqq1xsbmRKZzVsEC9wx399bqGWLj6PndxPm
         0GxpnITJeSSJjUUXBwsxqBs2VfM26i8Zy/pESSM250EmvlUEpLtWT+8K+Pqx4PdGmBDb
         WE3w==
X-Gm-Message-State: APjAAAULBYSUcix1XU3gCZsF8bwpq6JeF1cRyMnB0teqKnPD/rBLvVvk
        8KGZspL9IfgzFTMb6ZBwBVMq/A==
X-Google-Smtp-Source: APXvYqyYhM0GPsQWijd96/WpMOLz0ToqCooX486o7mCVsOebCRI1o1wjyQCLw53tIr7eh92YQVXtDQ==
X-Received: by 2002:a0c:acfb:: with SMTP id n56mr29627290qvc.87.1563382212870;
        Wed, 17 Jul 2019 09:50:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id k38sm14299332qtk.10.2019.07.17.09.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 09:50:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hnn87-0000MT-Q3; Wed, 17 Jul 2019 13:50:11 -0300
Date:   Wed, 17 Jul 2019 13:50:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
Message-ID: <20190717165011.GI12119@ziepe.ca>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-2-swboyd@chromium.org>
 <20190717113956.GA12119@ziepe.ca>
 <5d2f4ff9.1c69fb81.3c314.ab00@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d2f4ff9.1c69fb81.3c314.ab00@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 09:42:32AM -0700, Stephen Boyd wrote:
> Quoting Jason Gunthorpe (2019-07-17 04:39:56)
> > On Tue, Jul 16, 2019 at 03:45:13PM -0700, Stephen Boyd wrote:
> > > The hwrng_fill() function can run while devices are suspending and
> > > resuming. If the hwrng is behind a bus such as i2c or SPI and that bus
> > > is suspended, the hwrng may hang the bus while attempting to add some
> > > randomness. It's been observed on ChromeOS devices with suspend-to-idle
> > > (s2idle) and an i2c based hwrng that this kthread may run and ask the
> > > hwrng device for randomness before the i2c bus has been resumed.
> > 
> > You mean the TPM here right?
> 
> In my case yes, but in general it isn't the TPM.
> 
> > 
> > Should we be more careful in the TPM code to check if the TPM is
> > suspended before trying to use it, rather than muck up callers?
> > 
> 
> Given that it's not just a TPM issue I don't see how checking in the TPM
> is going to fix this problem. It's better to not try to get random bytes
> from the hwrng when the device could be suspended.

I think the same comment would apply to all the other suspend capable
hwrngs...

It just seems weird to do this, what about all the other tpm API
users? Do they have a racy problem with suspend too?

Jason
