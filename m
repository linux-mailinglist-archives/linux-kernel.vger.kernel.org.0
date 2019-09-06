Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF247AB545
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 12:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393005AbfIFKDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 06:03:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38664 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbfIFKDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:03:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id x5so5049356qkh.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 03:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKKnxPPsgAIgwEztVgg1GoTTNsVPqwYHTfDwxBVh/EE=;
        b=XXYpSSaH81bsrGsEBY+9PnjUk6yblb7HmMAbbM6AdcJGzrPCSEUdFaWRXCf1cnEhp1
         jam4nVkMuHulsWChs69qh2fyFcdG3YArzEcqEyHx8MpgfxC2j20XZS0KiRC7dDCvkRrg
         tSNEYzsIkY/DZ0+9AdtnUqn3FopQZgDpG5HDp79kUw/TA46hUiGtN4dyoaGM7zwohZ1u
         zy6WTYKrwM4Q1VPgjLQOxzRiI5vCNTnuyGKKa1shYcu1C/zG62dNMbaSD8uAVmPsioZS
         5r0U1wBxDx26EdJdqXeQo6SlcP7fyHNj4ekfUmy9QvQV9hma6EUDxHxzcf89zWdmI7Zu
         ZZSQ==
X-Gm-Message-State: APjAAAWjLyfWdjwNeBsblrejhK3VsBjBu6uDwkD0BaoBJSX7x/UF+/qE
        493U75ILEZMJciwa9Huq5tzKDYzsj7heX2pl5p0=
X-Google-Smtp-Source: APXvYqxpCALRccn6ODP9KYrflsF0sVz2A7RrYULIVWFnlCGhvGoTB9uHGRbcU86PgkUBURKioMIpZ1WC2hVTyL6RRRQ=
X-Received: by 2002:a37:4b0d:: with SMTP id y13mr7614923qka.3.1567764188695;
 Fri, 06 Sep 2019 03:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190905203527.1478314-1-arnd@arndb.de> <20190906043805.GE2672@vkoul-mobl>
In-Reply-To: <20190906043805.GE2672@vkoul-mobl>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Sep 2019 12:02:52 +0200
Message-ID: <CAK8P3a38ywYFaGekbi6_idwrZvaVX8u8giUpK1r26QAbekLp8Q@mail.gmail.com>
Subject: Re: [PATCH] soundwire: add back ACPI dependency
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 6:39 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 05-09-19, 22:35, Arnd Bergmann wrote:
> > Soundwire gained a warning for randconfig builds without
> > CONFIG_ACPI during the linux-5.3-rc cycle:
> >
> > drivers/soundwire/slave.c:16:12: error: unused function 'sdw_slave_add' [-Werror,-Wunused-function]
> >
> > Add the CONFIG_ACPI dependency at the top level now.
>
> Did you run this yesterday or today. I have applied Srini's patches to
> add DT support for Soundwire couple of days back so we should not see
> this warning anymore

This is on the latest linux-next, which is dated 20190904. As Stephen is
not releasing any more linux-next kernels until later this month, I'm
missing anything that came in afterwards.

       Arnd
