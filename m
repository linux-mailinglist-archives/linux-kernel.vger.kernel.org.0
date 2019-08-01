Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6B7DBC0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfHAMqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 08:46:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55655 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbfHAMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:46:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so64516453wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 05:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cZCY92RMfghZJsFP1Vz0w4UO7UoxBKe+hI+aMfOaKM8=;
        b=vUXnXx5kNtIFZ0huFPiV/HxhJIbQdYlkFxXwCPijUEreVyNC/1pxQMald0tr6/5oU+
         Ku4JTGZOhL69MmV/Q5dbk4vWDah5/JPXEMYMNks43DojB8zmCbVBMLURc1fImEZ3YdI2
         doKD9u7bejJ/UhT/GPcMTjZ3kZuOJbdM7J2rwAqwTZGpSbztlqyjT6hvwS7ltXOWjcBk
         TrrLVnQKDRIuXxZS6tfQvsGHNDhV8M+CJGdf4t3WAuO9zvRHvrl20GzPHvRRlfXh2a0J
         Ljef/yOoYB7o1JF7ZWTjXgMEN9MOgFo75dmzLwOg0n27FcmGHiQyvs9PyZVPgyw/6NZ0
         KxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cZCY92RMfghZJsFP1Vz0w4UO7UoxBKe+hI+aMfOaKM8=;
        b=Ql07FfKbD2MVLw/5hFDHXzlvfGh04fEGhkW79JRdTrVTcyGfrP2FSObvNqdEPaRn8v
         c9wy10oraYjMHI7UnHxfzBZtWEn8qJ4ST9x7T5CI+gkmZp/k8EZQmX65HbMRA2Ng8Qna
         VevU3kqIAa55wg8ZnHBIJBnG2EQVCPSSsSZK/VI0WJnG4iNidmiR2I/tReCAtc7+52F5
         RaStUOpmvHkyH4KHcqMBCOSp6yijfVFU6RR4cl0JWwRlT21GJ6gh0vDZitH8rDN5v8q5
         XcwVMuYl+Dgb9xscsaSKUXH8IemU8z2wt0nmV6p+sHTvCVQUTSiMn31ce+KH35vZW0pP
         Zg5Q==
X-Gm-Message-State: APjAAAWeNfm1yUCE8NSc2+3dtq0gDRYQSmffEgE+ACgW4cKfK4+hZzxf
        J2Ed1qxzpyDDYjMQ/aA15lV0Ag==
X-Google-Smtp-Source: APXvYqx/EB+krQbuHfDMiwKikaXaFO+7qwPqB2cAqkBDAaRdrKTmsFkpl+/WGtL6bOLXv0IkeDY/3A==
X-Received: by 2002:a1c:3cc4:: with SMTP id j187mr110992050wma.36.1564663582722;
        Thu, 01 Aug 2019 05:46:22 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id f70sm96317715wme.22.2019.08.01.05.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 05:46:21 -0700 (PDT)
Date:   Thu, 1 Aug 2019 14:46:18 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        khilman@baylibre.com, mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, baylibre-upstreaming@groups.io,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] crypto: amlogic: Add crypto accelerator for amlogic
 GXL
Message-ID: <20190801124618.GA30316@Red>
References: <1564083776-20540-1-git-send-email-clabbe@baylibre.com>
 <1564083776-20540-3-git-send-email-clabbe@baylibre.com>
 <CAFBinCD7pgUaBJgeGHTOu-uZRA9a6K2kxPsu+huKe23wcnKPoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCD7pgUaBJgeGHTOu-uZRA9a6K2kxPsu+huKe23wcnKPoA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 02:17:38PM +0200, Martin Blumenstingl wrote:
> Hi Corentin,
> 
> it's great to see you working on this :)
> 
> On Thu, Jul 25, 2019 at 9:45 PM Corentin Labbe <clabbe@baylibre.com> wrote:
> >
> > This patch adds support for the amlogic GXL cryptographic offloader present
> > on GXL SoCs.
> >
> > This driver supports AES cipher in CBC/ECB mode.
> >
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  drivers/crypto/Kconfig                  |   2 +
> >  drivers/crypto/Makefile                 |   1 +
> >  drivers/crypto/amlogic/Kconfig          |  24 ++
> >  drivers/crypto/amlogic/Makefile         |   2 +
> >  drivers/crypto/amlogic/amlogic-cipher.c | 358 ++++++++++++++++++++++++
> >  drivers/crypto/amlogic/amlogic-core.c   | 326 +++++++++++++++++++++
> >  drivers/crypto/amlogic/amlogic.h        | 172 ++++++++++++
> >  7 files changed, 885 insertions(+)
> >  create mode 100644 drivers/crypto/amlogic/Kconfig
> >  create mode 100644 drivers/crypto/amlogic/Makefile
> >  create mode 100644 drivers/crypto/amlogic/amlogic-cipher.c
> >  create mode 100644 drivers/crypto/amlogic/amlogic-core.c
> >  create mode 100644 drivers/crypto/amlogic/amlogic.h
> there are two different crypto IPs on Amlogic SoCs:
> - GXL and newer use the "BLKMV" crypto IP
> - GXBB, Meson8/Meson8b/Meson8m2 (and probably older SoCs) use the
> "NDMA" crypto IP
> 

I believed it was the opposite. (BLKMV the older, NDMA the newer)
Anyway, on the datasheet I found (s905d), neither NDMA or BLKMV is mentioned, it is just called Crypto Engine.
So I think GXL is the best choice.

> personally I think it makes sense to either have the IP name (blkmv)
> or SoC name (GXL) in the file or directory names as well as being
> consistent with that in the Kconfig option names

Ok I will rename files to amlogic-gxl-xxx

Thanks

