Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD0E15212B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgBDTcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 14:32:18 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42028 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbgBDTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:32:18 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so18275726otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 11:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Et9pRiR1Ma9sl4dJgbbua/nMtmbzH7oTYgwDY47X7gk=;
        b=mWK4nea1vZ+jAlGOExb5wDwpAZ3JWzhU5OdQ8/31S3QOckRF2nYpYo6wWHBDYmVM4j
         MDthJxcFcL/zDT6gYv5DHan4HE3uI3+QrFYOGCUZQx6XENcty1le7xnHUpfu3GPP6A5Q
         zD1HMqARhWC5qO0rwcMm0qVwyVm6espiPRjn1S1kadtT50muRqMQFTPisCGAeCYIXU3U
         XmoG1NdhWw9VIy4/MrBAPmP+rVMk9bPFw2moHnlh+iEbv78d7GZC0NQ6DXeD5ou3lX0H
         4InqYTjATU6AbgeIXLM+1PChmJPFJrwYQnLl6GNPDTwSRhDlNnY9gDPkZauDc0jB0H3G
         VD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Et9pRiR1Ma9sl4dJgbbua/nMtmbzH7oTYgwDY47X7gk=;
        b=JZdiV/yZmKKXVuJPyMHuCUSyXBFPQ1M272aZe1fCysdZjrw4CcWDey+lathP14qTFO
         3aYxEDHwSqap/OYYJ54rfm05oddbLzURYcUWX0jrJ/NdUMd0LuoFaoPvgB5x6AIoxM2d
         pPJVj5OUa4KysEBVXD11no8fnfI62HVJIITpE1QCoxEIFTOzXdhF33p+H3ovbAxSjcag
         8SLrXugWr+fhRvvcgcpXCC3mW+TzFi7lEuoMtutazYZiwrxTsnun94lAuATg2XrPWT//
         fgk0upe2fQEoPvzuWhEviWkW53jRFD8HzdXDSCcV5m5mbq4IWCBfUADAJBVH5Go57lx3
         6qAw==
X-Gm-Message-State: APjAAAUDypH8SFux8zmH54cYs3x8kPmeeB7IPytop65ZHtsdTXvwd2f+
        Dfxfjc9i06Ec4O31dwPRQjI=
X-Google-Smtp-Source: APXvYqxQ67LpNhXsPEsg9KZN32c1olOPxSz/GZrtpkwwa1ocuWDNEP7eW11vQi3Lai5XLFsN73GBAw==
X-Received: by 2002:a9d:588c:: with SMTP id x12mr22627232otg.2.1580844736997;
        Tue, 04 Feb 2020 11:32:16 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id b145sm3997400oii.31.2020.02.04.11.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Feb 2020 11:32:16 -0800 (PST)
Date:   Tue, 4 Feb 2020 12:32:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ASoC: wcd934x: Remove some unnecessary NULL checks
Message-ID: <20200204193215.GA44094@ubuntu-x2-xlarge-x86>
References: <20200204060143.23393-1-natechancellor@gmail.com>
 <20200204100039.GX3897@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204100039.GX3897@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 10:00:39AM +0000, Mark Brown wrote:
> On Mon, Feb 03, 2020 at 11:01:44PM -0700, Nathan Chancellor wrote:
> > Clang warns:
> > 
> > ../sound/soc/codecs/wcd934x.c:1886:11: warning: address of array
> > 'wcd->rx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
> >         if (wcd->rx_chs) {
> >         ~~  ~~~~~^~~~~~
> > ../sound/soc/codecs/wcd934x.c:1894:11: warning: address of array
> > 'wcd->tx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
> >         if (wcd->tx_chs) {
> >         ~~  ~~~~~^~~~~~
> > 2 warnings generated.
> > 
> > Arrays that are in the middle of a struct are never NULL so they don't
> > need a check like this.
> 
> I'm not convincd this is a sensible warning, at the use site a
> pointer to an array in a struct looks identical to an array
> embedded in the struct so it's not such a bad idea to check and
> refactoring of the struct could easily introduce problems.

There have been a few other bugs found with this warning:

9fcf2b3c1c02 ("drm/atmel-hlcdc: check stride values in the first plane")
44d7f1a77d8c ("media: pxa_camera: Fix check for pdev->dev.of_node")
8a72b81e6df5 ("isdn: isdnloop: fix pointer dereference bug")

Other static checkers like smatch will warn about this as well (since I
am sure that is how Dan Carpenter found the same issue in the wcd9335
driver). Isn't an antipattern in the kernel to do things "just in
case we do something later"? There are plenty of NULL checks removed
from the kernel because they do not do anything now.

I'd be fine with changing the check to something else that keeps the
same logic but doesn't create a warning; I am not exactly sure what that
would be because that is more of a specific driver logic thing, which I
am not familiar with.

Cheers,
Nathan
