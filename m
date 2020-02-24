Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727EB16ABCA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 17:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBXQjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 11:39:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51587 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgBXQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:39:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so9645030wmi.1;
        Mon, 24 Feb 2020 08:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0sdWUeHuBr96/VIOIWdMJQh5Jm26LqtJhhLqkI4P9E=;
        b=VR/V9ht7eiYkE1kOrJhTS3S18UETRmWMnanPviE4Sdd/KzC6tw7wU5EHE9HI1rWNwF
         v8HHl2b0AWJFaNXX3OoheDHUt0Piu6RAX7x4lnjTIGjq5uuSkaKjMfDSa+TnSHfx40vF
         Nw0sfJQjmWfvOCanXcycN+b2SWmK6rUb9dG/cyGpiHQrgJvJJzcTU4CuIYVLH0ANNUF2
         ATCQ3HsGEVTj2/RHrRztv2Gc0AFq3GGyPSvivAb0u4QvZjau0nr7CWBrK3lZ5BgRzhMp
         IqBmqodaKIHqLCGn/avqnAk82WOg2nN8FrnzkQHTWq5ou12Eqj10iauss70qgojNX2Qg
         9arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0sdWUeHuBr96/VIOIWdMJQh5Jm26LqtJhhLqkI4P9E=;
        b=gRbK6CBchLq4hcIovdeJ4Q1wXEVnsfwxT8771YVBPg48U220BhaUanO0BI4O148shr
         GYdiswM4yT91RcHQBPYL/03TeD+2E1WhhoS7YDPbpE+J0NTm29f0FGz52mi+1680IoSE
         f/BWcrRUor8Su/j2Q5VMG0fvvNE1v5zXjE/5KghmsFYb9ON4iEeZcRJ/frUBcwzgv8Ox
         Oz6Y02OtlNrShhvP3Yt+In6+d3deU9DzU3a5kGZlGu1UvTC2J3ZhtUeL21XXQk0p+U7Q
         rL600ty0YfMgvVDXw5OgPzJLXf0DhR5nxKMSRHagIDkPj9rzFHH83BYoKFAJYrE/ARqN
         nR5A==
X-Gm-Message-State: APjAAAXX8q7Xb+kWh/kZZ3ScW/PHUYU8q5vTbEtrFs77wJOrkjN5TrRg
        GbGH5u3G223yGTiprfz0XrEXaIL4pueQDOl+bWA=
X-Google-Smtp-Source: APXvYqzGVFtlF1/ctbev1R8M6BKDpsFvi7TsUPAVaI36W478E4LcYTtrw4XOKhMNTwx+y8oTUMYDP1jkbBVmzfLMrEo=
X-Received: by 2002:a05:600c:217:: with SMTP id 23mr22803384wmi.124.1582562355408;
 Mon, 24 Feb 2020 08:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20200127165646.19806-1-andrew.smirnov@gmail.com>
 <20200127165646.19806-4-andrew.smirnov@gmail.com> <VI1PR0402MB348585D73873E2DFE6B8751698180@VI1PR0402MB3485.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB348585D73873E2DFE6B8751698180@VI1PR0402MB3485.eurprd04.prod.outlook.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 24 Feb 2020 08:39:03 -0800
Message-ID: <CAHQ1cqHERbU-dgMZ4=7Htz9Z-AgyTuAx7amBgzDYdxq4Rfqe=g@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] crypto: caam - use devm_kzalloc to allocate JR data
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:23 AM Horia Geanta <horia.geanta@nxp.com> wrote:
>
> On 1/27/2020 6:57 PM, Andrey Smirnov wrote:
> > Use devm_kzalloc() to allocate JR data in order to make sure that it
> > is initialized consistently every time.
> >
> The commit message is a bit vague.
>
> I assume this is needed in patch 4/9, which adds a new member (hwrng)
> in caam_drv_private_jr structure.
>
> If so, it's probably better to have the change merged into patch 4/9.
>

Yes, it is specifically needed for 4/9, but it's generally a good
practice to zero out allocated memory, so I made it a separate patch.
Will fold it into 4/9, since that's what you prefer.

Thanks,
Andrey Smirnov
