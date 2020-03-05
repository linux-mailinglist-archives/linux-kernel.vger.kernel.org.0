Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB4B17B09A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 22:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgCEVZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 16:25:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41870 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgCEVZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:25:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id z65so2877995pfz.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 13:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajV8smT+f8sjiZ+RvnRGvGz6QEWErk3TEm6WtYdFaY4=;
        b=PD4/aQa2ZLv3yStD0yB0ftfKVsfmPuxn8sddykSIcKSP9k2S2SZgmSvtk8Qci/seRO
         zqp5VQs2trR7GQT47cRxPmyfkGpOr1b3cIU7oNlG9BiSxtJ8g9XbFwC7yCzfX0vjbrVF
         vVLzXjnDDrax6SOgUnuX7AYkLp8DzaM6zHAYLTE/oVrRB6KSPxrG6pDr/vYvAPeXAWON
         vk91gC4iqYvNoX0rby45VaGLhvZsdXjuscR6G/+mSMtxAx+6YH/D2Ffeq0wT0uI5M/e7
         h1qNUtTmRaRWW+jieeapG55XxcQO5J+WRABXUC116zlQr85Vfgx3FZKLrL3HZovRQizK
         YH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajV8smT+f8sjiZ+RvnRGvGz6QEWErk3TEm6WtYdFaY4=;
        b=qte2Dt5hwwLJgoxMe4lu05dfDuORKnG08tqddP0zK2IbpbvvaCcQdSWAPIA6j+Yv9/
         IdO3KyoK8P8r+ZPuOgbYBExIa2I/RAYPove0v1LuHrHByFzT5q05piCkzoaW+PLA2aSA
         cHtckHUAFV6U26+fl1vciLU6d6vyMu8Fa0+Fbb5+x0NNnD07Tp6kWeBjCKePT20c5YZS
         a8bw494zWOEwxiOPcR07SaDzOkWAV861TbSlD31iRb7yiQjlQ288fK8VOXzeL3QaqArI
         XVrQDjySoTqDOOCjhJKuUeykijqCUK6+US6CYnfD+KqQsV79Pkj2E3vCCeHUbVJoS7vO
         RCkQ==
X-Gm-Message-State: ANhLgQ1/N+PN9CAGp0gnL0FZSHQq7+Rgrz9bg5gl7BY10x/LIXQCc1KG
        a89Hd0av7LroLpgccWF6gMkqXyhf6k0SNrxWbpZF41rLEKQ=
X-Google-Smtp-Source: ADFU+vs/yd8sl8AGOF4udEAV6HbPfrhJNTZpdS0+B2FFxE8/Db+V/XPyzKCC8/zYHslLQzpePU8Xrg+lyAT+TBlzx7k=
X-Received: by 2002:a63:6cc6:: with SMTP id h189mr98575pgc.201.1583443552247;
 Thu, 05 Mar 2020 13:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20200305200409.239406-1-heidifahim@google.com>
In-Reply-To: <20200305200409.239406-1-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 5 Mar 2020 13:25:41 -0800
Message-ID: <CAFd5g45HSuxcP8_-yaJY4M=Acy14L=FTwY3GT_m-eTVtP6NJhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: kunit_parser: make parser more robust
To:     Heidi Fahim <heidifahim@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 12:04 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Previously, kunit_parser did not properly handle kunit TAP output that
> - had any prefixes (generated from different configs e.g.
> CONFIG_PRINTK_TIME)
> - had unrelated kernel output mixed in the middle of
> it, which has shown up when testing with allyesconfig
> To remove prefixes, the parser looks for the first line that includes
> TAP output, "TAP version 14".  It then determines the length of the
> string before this sequence, and strips that number of characters off
> the beginning of the following lines until the last KUnit output line is
> reached.
> These fixes have been tested with additional tests in the
> KUnitParseTest and their associated logs have also been added.
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
