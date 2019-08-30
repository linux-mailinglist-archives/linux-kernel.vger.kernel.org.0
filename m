Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0C47A3C18
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 18:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfH3QeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 12:34:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44174 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3QeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:34:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id u14so471312ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjdkwsKSf2VRq5W1pF0YFvlLHvkAKLdWUUMauCVdd1k=;
        b=cZ97VWp463OQmkWYxTJ3976yRGFL44HW3ecfvAYbV7yurzSFFe5/p6MB3LHoNqdarN
         R/fxSaFNSs360fZmHMPWTChJym4lYPeKwQcycWe+7oBNP0/w5DXo7BCLGzCvzSMeRcI0
         PMrJnck7KEGRpprtR2Wfi/laL2lQscD73tsCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjdkwsKSf2VRq5W1pF0YFvlLHvkAKLdWUUMauCVdd1k=;
        b=dDDXecFDMZoWp2tkN5eWPZP8pE4COdMDWFuYcrfn2YMI8qe300e5mB3BNj1KUGQLLp
         PEzQLUwUh6pBnMKBytfy8xetEGR7+9duSYLEJ/aKC4bNY1IwzW+IAltIz08xuPcspOm1
         MCySy+8yQDil50qikezLk6w5iPV5bcKOA4hzSyfHxs2UTXuEjh4C2wSetean7Z76/gMr
         g/n6y/dlpj5JjvgAMTmCHhPj4SdQdTM1BADbrtmGJQ92Sp/fvSHEfCsnbh3FXCt4K1sa
         gwLlLuIzInhaiwgIdVfgePaKi63540piepZxLMdXXXu+Id2b5UQcPhmiPTmEjdxjrr6P
         +b6A==
X-Gm-Message-State: APjAAAV8/ehFylBi3XwRryupeQYEN3VEYXZJGtbEmM3rShKxFwVHJh5b
        6F/FGIh6TBko6BYTa9/abPSiey5s29c=
X-Google-Smtp-Source: APXvYqw1uk/WQJFy75vQ9Z/GxO7dXbqtf93lwHVgORfiDKd96H0BsI0bJqg4xYvtUJ2YYzYlZPBq5g==
X-Received: by 2002:a2e:91c6:: with SMTP id u6mr9166739ljg.68.1567182861070;
        Fri, 30 Aug 2019 09:34:21 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id g28sm571541lja.89.2019.08.30.09.34.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 09:34:20 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id u29so5795702lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:34:20 -0700 (PDT)
X-Received: by 2002:ac2:4c12:: with SMTP id t18mr10064627lfq.134.1567182859940;
 Fri, 30 Aug 2019 09:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2OZPybUQ=2xXcF4Qft-Gpe3a1mvgPncJZugETnaOxsvw@mail.gmail.com>
In-Reply-To: <CAK8P3a2OZPybUQ=2xXcF4Qft-Gpe3a1mvgPncJZugETnaOxsvw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Aug 2019 09:34:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgq71zNZtcb7vAsgb0EEozJsBDrLC0L+91tmMCBG=8FiQ@mail.gmail.com>
Message-ID: <CAHk-=wgq71zNZtcb7vAsgb0EEozJsBDrLC0L+91tmMCBG=8FiQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for Linux-5.3
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 9:26 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git armsoc-fixes
>
> for you to fetch changes up to 7a6c9dbb36a415c5901313fc89871fd19f533656:

Nope. That's a stale tag for me, pointing to commit 7bd9d465140a. Your
old pull request from end of July, it looks like.

Forgot to push out? Or forgot to use "-f" to overwrite the old tag?

                    Linus
