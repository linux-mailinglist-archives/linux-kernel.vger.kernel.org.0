Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6290D44ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfFMSiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 14:38:50 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:37339 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfFMSiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:38:50 -0400
Received: by mail-qt1-f170.google.com with SMTP id y57so23789632qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XUEHXUSNmyMi32vrOhUKl+mDbcbWi1zRqECCE0hmxew=;
        b=UUDhyaYYhO2gE0wGK71phcvyB3iZnqs2ztAyH6sWrxETKIAY8hYDjjaGTVYRPYg3eh
         kS67yzT2cNBhw+GUtQjPLGOJRN7aDI3t3fKJ3WB4epbxQ64O6DmH1p2B9Nd/icQiItEC
         Pw4VrCprrvQbaEyJyWwex5OFP852Kw1Y120HTFQvN5wVgFDEwWf298Vo9YhWJ5gxpmq9
         5vLmcjuyQ5MB/tIsY6NIt3C+Y3teYuOcA3pBbgVhizrR08mLUp+uAr7z/p3qjXhKYh4V
         EaFHuVbY4ZHk65qpLk7pyDpKusOvx3ai/3sUaOXLYHljWrH7R99qN9ES5sNrkVs3DyvO
         HAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XUEHXUSNmyMi32vrOhUKl+mDbcbWi1zRqECCE0hmxew=;
        b=idAGp+hiM+sDUJ0CT3XxKXeuWdEVrVyCyL44J5Junu/DP+aAAL/kovZSoSQflKvK69
         hbmRa7F9GGUXvBwzw6icQgLKmtvpFTdrYYMhDnSdHHMzc3ieW+pLOnnYM7876QFdTvG8
         SD+LapCnE5iz3crFlPlz84aCG+FMZTLR/V1ZAXwmoYVlKI4H3uoyUuIJV8rPRH7/QuL5
         bxN+hhZMXXSU1EYPVT98p7xtGPSO4guv6Lm7oXXoGen+ypMz+YLAewO7sotfdBFGEE9O
         YqxkXBsVeDzs0PGnkBaQd+gQU9axnC/HV1aBa5/L7E+g3E/Ax3nIhL6cm3XC3IVAFLEf
         zGdg==
X-Gm-Message-State: APjAAAU2UZJs1TqkhcbbdDif5EJ1WUJgbUaX4yrvdEo6K2LESjxGOYTA
        7uJJGg/7fRgPjBBWAW9JV5yI8twQYDh2jvhBVeKdTQ==
X-Google-Smtp-Source: APXvYqxaEnkAxv8FL6q2bCba4yHlGp0pIrIe0vfEwYtoOcNefWuszN34Y2cCx+IxMc/v6LrmKqsQiveMw5hlD7isnAs=
X-Received: by 2002:ac8:3037:: with SMTP id f52mr77218114qte.364.1560451129073;
 Thu, 13 Jun 2019 11:38:49 -0700 (PDT)
MIME-Version: 1.0
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Thu, 13 Jun 2019 11:38:38 -0700
Message-ID: <CAJkfWY4nKwyPDh=MuCURst2SZceceeR2v3qrT9UY=VbvLnEmFg@mail.gmail.com>
Subject: Cleanup of -Wunused-const-variable in drivers/usb/host/xhci-tegra.c
To:     treding@nvidia.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I'm looking into cleaning up ignored warnings in the kernel so we can
remove compiler flags to ignore warnings.

There's an unused variable ('mbox_cmd_name') in xhci-tegra.c. Looks
like it was intended for logging or debugging, but never used. Just
wanted to reach out to ask the best steps for cleaning this up.

If the variable is no longer needed I'd like to send a patch to remove it.

https://github.com/ClangBuiltLinux/linux/issues/533

Thanks,
Nathan Huckleberry
