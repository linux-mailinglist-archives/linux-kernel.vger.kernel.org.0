Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0803C78B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 14:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfG2MTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 08:19:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36438 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfG2MS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:18:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so58397601ljj.3;
        Mon, 29 Jul 2019 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHoxMyQA6kSrFJxXpyiV+IieJpLzNWL4IkZqs98PDx8=;
        b=jbAZxACt64pCVZRPdYTO6bc2vXa4ld10XHt0YApN2vDvR47mq6DamPBCdKAnS3lRmt
         MenvKMYTWsX0THdu7OkNfQ8/WJaWWfthdJZzfGa2eIDlPy6r2cH/Zml1LAD5lC77hgyR
         wCQQmecaSB7huytlu7WMGDOgw/Uy7J6NykyxOZWuj1jJxaE+I3Ko+42QI/HAuH8wF5CC
         z4iip9y/ZoaOMn9LAwW8lMtz99gU9Ng4yTbf5l7vwFrQEo8vjHicLhsUMLnZwRVJW0bG
         /YFeLLaobZrs2dTg3ks6KLTDdou/P2GXzPSJYAOtpx5gaIXg6MUTr+aoWBtiozTQmdY2
         dn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHoxMyQA6kSrFJxXpyiV+IieJpLzNWL4IkZqs98PDx8=;
        b=EVqkbGAGFbcFsPXTF79HIG4bUcDGV3rCR7LUH0nVYimH/0VPyySuC9MyxqQZZh2QpJ
         EKiWx4W44PCyuamO/Q3JmPQ3/7b5s1oOpaFIL2ECETlZPMaS3RYGhGOwLQrmB66pAXfP
         7bsjlt5iBGWdePlfOX0Xk+tSUPKjpu34I4+d58kFaNMgIfLJqhtD+ULH24WpAP+JMxPe
         ZLxMU2ITvz6IIviiuHNre9I1xe6Ixa9X11OQW+1tnkGTvGrQs6L5KpiCSzBfbNqVSKUg
         c61JQuBUYZ5xKIGrkS/CpZyyEW3gsQvvlrddyJXB9UGeWYaiscCQvjXXZUeyAtECg+hK
         nU8Q==
X-Gm-Message-State: APjAAAXK/Fi9IDoqliPt7yuxl2u4u8BRYFPYrmLQi9XPs9nuDSHcw2uA
        6j9tjuKedV+XLalsbMrbGI1e7hT32ch3ZY14ZWQ=
X-Google-Smtp-Source: APXvYqysQdZFO4P/tp354iNeuFQYqW32qWFHcnvkV9JqmCqp9aTaQNiKQTyV59gsaic8TYmRtI9rWh0QxXKZhEGC8gY=
X-Received: by 2002:a2e:8650:: with SMTP id i16mr58240101ljj.178.1564402737462;
 Mon, 29 Jul 2019 05:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <1564384997-16775-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1564384997-16775-1-git-send-email-abel.vesa@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Jul 2019 09:19:01 -0300
Message-ID: <CAOMZO5C0WbaDzFcjeXeS1PivWUme=bzPur6Hj_xNz1oVzvpW2Q@mail.gmail.com>
Subject: Re: [PATCH v2] clk: imx8mq: Mark AHB clock as critical
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Guido Gunther <agx@sigxcpu.org>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Mon, Jul 29, 2019 at 4:23 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Keep the AHB clock always on since there is no driver to control it and
> all the other clocks that use it as parent rely on it being always enabled.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Tested-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>
> Changes since v1:
>  * added comment in code why this clock is critical
>  * added T-b by Daniel
>
> This needs to go in ASAP to fix the boot hang.

Which boot hang exactly? Are you referring to the TMU clock hang?

On the TMU clock hang, the issue was that the qoriq_thermal needs to
enable the TMU clock.

Please always provide a detailed description in the commit log.

Also, if this fixes a hang it should contain a Fixes tag.
