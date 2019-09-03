Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE628A650A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 11:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfICJVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 05:21:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33892 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfICJVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:21:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id g128so12262776oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glcXCjwyqn+HnwC7gVzkRUcxL2AdvVixrYcSTi4w1PU=;
        b=mcK3nweohShcW2LEUMICZbVwxHtOCjxDYckZO4FfQk37KTz/3nkpuLr77dDXYzZxz4
         or6nYv7Vg04A1VkSOntYcSGuOqoqBc18fkMHF5EOKyAIqXvwp60PwkudRRdzqpEHTOFk
         JLUS6thW/ybzyOX6jTAyx3Unl97exqbMOO6GeRaRFWf1SY5GCKm30eGiO8rfMkr3asm9
         n9ZKT/aUSiJNjGdOwETM2FY7y6I/HELN4jGiEPOdSvReA9SfLXUItg4zcRumbYr8rFLS
         AISiYddP9X8DEDcdhNBOCX3wfjYOsXuM5YhVNqcg7RQCwdHTaQXTkVVoWXBZTuA8RhFS
         X7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glcXCjwyqn+HnwC7gVzkRUcxL2AdvVixrYcSTi4w1PU=;
        b=rP4fa7GUJC+pa07gNsht45LjHBHLf0D80NPWMkMfeiA7ogto91y5NRd60TsvEMGhjb
         sjlxDwNlNyuOjYRTBCnWp7l5sYSgfsMNP445npTux/ILxxykCHXB6hpLO82+7aOngpCU
         plH+C83rwchhXc7j7xQz9CUIQn/P5REbCjktmZcZqHXKcvD2NqHcC65liZDrJEwugPI9
         +9GGrcePlGo9he31lyt9mSmMIbTSAh34uvv6s13mKKusjUc7XE/re2JYey3okFH3ys7D
         2uyAdEdM0ChNY3yfI5qPsSg1u5QBSvwwOjzdsCrMvTqom4Js+exqwbMHIUx/WZmS+D5u
         tJZA==
X-Gm-Message-State: APjAAAV15wjnKY7wlUvQc7z9n8BdQmn7q5qPn/40lW/rWX5ZGh0Z5m9c
        W6Wa1kk0X7Vk23qgnG9GCjrscbEElJP5ntAqgjgRSg==
X-Google-Smtp-Source: APXvYqzo2nUjiHesbwnB0H1Z1h3L+spUHg2mts+oMbRKV6XXnJiqEYS55mFoFRlt4i5wbRS3LbqfxQhk9ndU172nJWQ=
X-Received: by 2002:aca:e183:: with SMTP id y125mr14148339oig.27.1567502465778;
 Tue, 03 Sep 2019 02:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190826072929.7696-1-zhang.lyra@gmail.com>
In-Reply-To: <20190826072929.7696-1-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 3 Sep 2019 17:20:54 +0800
Message-ID: <CAMz4ku+j-pSnfp1SJ4WN5seYe=vXxLGH+khaGNrseXi8+WKkoA@mail.gmail.com>
Subject: Re: [PATCH 0/3] keep console alive even if missing the 'enable' clock
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 at 15:29, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> After the commit 4007098f4ce4 (serial: sprd: Add power management for the Spreadtrum serial controller),
> the 'enable' clock was forced to be configured in device tree, otherwise the uart devices couldn't be
> probed successfully.
>
> With this patch-set, the uart device which is used as console would be allowed to register even without
> any clock configured in device tree, this will make debug easier.

Tested on my board, works well and looks good to me. So for the whole series:
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>

>
> Chunyan Zhang (3):
>   serial: sprd: check the right port and membase
>   serial: sprd: add console_initcall in sprd's uart driver
>   serial: sprd: keep console alive even if missing the 'enable' clock
>
>  drivers/tty/serial/sprd_serial.c | 42 ++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> --
> 2.20.1
>


-- 
Baolin Wang
Best Regards
