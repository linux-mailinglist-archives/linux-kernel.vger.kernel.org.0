Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6B65F93E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 15:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfGDNj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 09:39:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36296 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfGDNj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:39:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so3117523plt.3;
        Thu, 04 Jul 2019 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=URhowmNUr4Kh2B0vB2kJm0rLx/vyPLQnOZnEOZDhgXI=;
        b=b2lqLfPAiSwP0Lrk35yjIUdYB6nsgMTvkCnnXtGbZuTKQQzOJYXyy7O6PSjwCHXfCE
         LYKvuPJNYiPEdCWcaFdAKWyhIFcDPy+cbS5QC4njHFS378Uqpm3Di4aC6ynFkg5lqgcU
         Jdi3fOhoKmgcpCqwx5xJ+hv4e35joyxO3CvHOEaEYGn0uCpfDIC5sRlBzHvTwjrOuTpO
         aDXA/5Qozut2888R1FcU7eoBQmu2st47MmmPoWT07kZoZD7n+lyy4r65yqvyszExdsYD
         Y61rU7MP2GRu2gAiXVa+0mVjzAOm8dHgBxbi83O8W0CBfz1wB5Z7HdOBTtembE8d2g0S
         996g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URhowmNUr4Kh2B0vB2kJm0rLx/vyPLQnOZnEOZDhgXI=;
        b=IgTk6BWsL1ebNYsY8Amx34i1sreqv3F9/2RvIPM0Tk4BpN+hovigxmuchDm6J0gnMV
         oWRzETJqp65odlcu69huIxcr8g422ps+c1585zhsISuSWV20bBi8TuaZU2UzkkMfCSEe
         fXOXtTW3SufGHMfl0ljss9CZVfMLHMFwWGz34NtETHk/Q2xIVgIMXR49Xkp8BE6XHPwB
         HmZL5waeVDRN8BU+jgZRJyTlEaS2K22crd3xzXWYY969aJ8g5STvLRi4/j70o0H4sgLT
         pzXYubAzjsbbWQsgSD1STe/1FcP//gyOn0rMpe3txopAs7IWo/iK5srlEXeTay3d35BX
         OeTQ==
X-Gm-Message-State: APjAAAVY8DoAGoOdCyfFBBbx1FxcbQILow0f5zvBFLgCJH8omix5C3BV
        j1xhFO0/mas+mJvJqdJoSFu68utJ36fIkth+NiY=
X-Google-Smtp-Source: APXvYqyLsef5jKivGIbYcHNmbstAFiod+vmSMApgvd2zY8eLE2lQRgLKYKc0vyukE46x7f8V8eDY9YTaLQQOuv/uNM0=
X-Received: by 2002:a17:902:ab90:: with SMTP id f16mr48513603plr.262.1562247597639;
 Thu, 04 Jul 2019 06:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190704090205.19400-1-fe@dev.tdt.de>
In-Reply-To: <20190704090205.19400-1-fe@dev.tdt.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Jul 2019 16:39:46 +0300
Message-ID: <CAHp75Vcocs=9AwX32ouOWFc+wAduCFv2DT_p4JYPUVV0BumjqA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Update pcengines-apuv2 platform device
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 12:02 PM Florian Eckert <fe@dev.tdt.de> wrote:
>
> This patchset adds the following changes to this pcengines-apuv2
> platform device.
>

Before doing anything to this driver, what is the plan for previously
upstreamed:

drivers/leds/leds-apu.c
arch/x86/platform/geode/alix.c

?

> * Add mpcie reset gpio export
> * Add legacy leds gpio definitions
> * Update gpio buttion definitions
>
> Florian Eckert (3):
>   platform/x86/pcengines-apuv2: add mpcie reset gpio export
>   platform/x86/pcengines-apuv2: add legacy leds gpio definitions
>   platform//x86/pcengines-apuv2: update gpio button definition
>
>  drivers/platform/x86/pcengines-apuv2.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
>
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
