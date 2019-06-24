Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89CA51B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 21:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfFXTp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 15:45:27 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:39878 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfFXTp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:45:27 -0400
Received: by mail-lj1-f176.google.com with SMTP id v18so13786647ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOESn/qQaoyqyNDPIMYen/vQAdPBp5pl7Zqakdc+XiE=;
        b=bv6b0nQaSxv3RfGAtQsqlRoLkYuhh502/N0q7/XsVfyh9bA4BkYMrYmVw4sqKkctNv
         WRTHWYeEVs4xTZttAh3BmYyMLufXRz6dzZQ7rvnem1ZFD2A2qRCFkiUvIhJ0ZSdCdhXx
         i9YbKcQir1cwRedTfA14rtx6yM9WIGsyC0tPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOESn/qQaoyqyNDPIMYen/vQAdPBp5pl7Zqakdc+XiE=;
        b=joGuamapWAPjb63nFcoGHRQNMaBBGjEhgG7irEW+Jhd81SKCwFqx+9Hw6IuXNtCPLh
         wfIwIbeMoFrK69P/CwHO44vGQw345kpLWFicBHkVXK0ssWhqf26gBnyUVttBfCgm5vcE
         6kRWSlo/3lNbUHLbAoGYI2rpya/Qq5M/mJRK9q+371Kbtfdar0q9pxfCEr4Wc3VjFYPX
         /DRB6tcdDbcOr1c5LXvifF+FHexk8Ok+YqmyuDNDqlUZvbE1UtLWCI+STRmhTdmkTKdW
         VD1iUCG7DNeMZeJJXCz8fPJYsqOVDfpuzsGmux0Kn50LhLIl3Vc6TmVNyZru80F/YmvD
         15vg==
X-Gm-Message-State: APjAAAWjaevaDgOupfebh5Cfx53dLUnWiiBO/401VAtHY91ZHmm8s1CN
        zK6oNiB2ryWaOIvKwPoFvE+S403XrDQ=
X-Google-Smtp-Source: APXvYqzZyQOdPOqVO+WlwaOmqvPwRd+6wK+DiAkAXYdXyHlAoW6xYi4Ft6Xyj0aCCxhh/pKhdFmhkA==
X-Received: by 2002:a2e:6348:: with SMTP id x69mr72733684ljb.186.1561405524640;
        Mon, 24 Jun 2019 12:45:24 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id l25sm1669917lfk.57.2019.06.24.12.45.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:45:23 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id v24so13764069ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:45:23 -0700 (PDT)
X-Received: by 2002:a2e:95d5:: with SMTP id y21mr64383920ljh.84.1561405523515;
 Mon, 24 Jun 2019 12:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190617100054.GE16364@dell> <20190624143411.GI4699@dell>
In-Reply-To: <20190624143411.GI4699@dell>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jun 2019 03:45:07 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjFZr5xfa-8t=5nhcMDzXQeu4wBggJ1htc7Z5T84dQkXA@mail.gmail.com>
Message-ID: <CAHk-=wjFZr5xfa-8t=5nhcMDzXQeu4wBggJ1htc7Z5T84dQkXA@mail.gmail.com>
Subject: Re: [GIT PULL v2] MFD fixes for v5.2
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:34 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Hopefully this is more to your liking.

I would actually have preferred you to throw the old buggy "fix" away,
and just do the final state.

But the end result looks sane, so I pulled it.

           Linus
