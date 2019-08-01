Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570147D8F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 12:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfHAKAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 06:00:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55382 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHAKAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:00:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so63960555wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 03:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvHG7Hz/9Ob9jRno4A8HIYiT+6WnolNDgY5X2fx9PzU=;
        b=jGl8hQ/pylifHAOf3LpUpjcMCa5xTk3o+Q7hIr2Zk43YehF+D2KOJVACNGmIekvP8t
         0fz+rZ/9PtRp4D2+7EKqYokYbm+LUPjdQtaPTQrYoirgot6tSTDgDaWTFeKmCd42f2ka
         5rViSC5YK4uLRwZ4rcKL6Ty1mnr9yS1Rt7VP4c6nKbdP4gLtoJDKRCPA1p/dsKwTVV7J
         QjfKlLJ3WarnA/ldHWKIqG7iBGrtljS1TDe08rV6CGEwZTRErFVHFQqeqF3hrBqwOba9
         UXSK5K5XbLzVljkbulWklgFpcEU7AFsVdH3OAzfvngez1lUliGdIWrt/4yrLIqLNljx5
         R/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvHG7Hz/9Ob9jRno4A8HIYiT+6WnolNDgY5X2fx9PzU=;
        b=tG+A+8Zi05BY531RRRkhjhYNEP+HGaBJP44riVT0d+MFo0tstkArH54dEMyfqs13qn
         Ylkc/6r6ZdU2mmcHodPPwv4aXA00+tDx9a79pl5wr4zxfVcp0b1hwOMym/qqIWsHwqv8
         pY8Eg13ceq2qDIYoG3JSdwRqX2XqDSTbjXfOQNSxCMvKzsoVe2rQU8aZS9d+kE77N5dJ
         R9RE7AwNe1tnIxhkD+km0PEiYeZDo6RkLzYqP8AQKZXrR0mUrRbuwUX3yU+uASx6LC1y
         RcS50Z9CmMj2iaYpXtR8va3db3hTEIK8DTgSY4reoIaSLKQ6bqqjhk+ACHt1fyxEsBYk
         rKUQ==
X-Gm-Message-State: APjAAAUVaotxuBPtDr8M72sl2O9+wrPPWdDTkpgfx/l5lqffyot4k4kT
        bOrQ9CznXqwoP1tUnFQzaTOpI0+gUmvjHfoIPeI=
X-Google-Smtp-Source: APXvYqzT72lIJX2ZUzpbek39yvgjAfsK6WJhLdzqr139lfB2Vbf6gWavQ9ep9qqYNrYgh51kzEO4py2b6kecaqVXnrM=
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr106706275wmd.87.1564653640133;
 Thu, 01 Aug 2019 03:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190718081943.10272-1-daniel.baluta@nxp.com> <CAEnQRZDwBBR5qQT9NQX7c6kyrjp2Mw_so=QgkARw-gUgj3VeEA@mail.gmail.com>
 <20190723074633.GJ15632@dragon>
In-Reply-To: <20190723074633.GJ15632@dragon>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 1 Aug 2019 13:00:28 +0300
Message-ID: <CAEnQRZDQd5x69CFaUULyh-5zR+g8Tw1VmUjPBQKJe-GHzhHjwA@mail.gmail.com>
Subject: Re: [PATCH] firmware: imx: Add DSP IPC protocol interface
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 10:47 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Tue, Jul 23, 2019 at 10:44:09AM +0300, Daniel Baluta wrote:
> > Just realized that for this patch I forgot to add [PATCH v3]. Shawn,
> > should I resend?
>
> No need.

Just sent v4 out there adding support for remove. Hope you can have some time
to have a look.

thanks,
daniel.
