Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18C312DBC8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 21:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLaUJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 15:09:39 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:34644 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfLaUJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 15:09:39 -0500
Received: by mail-il1-f193.google.com with SMTP id s15so30912549iln.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 12:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMq021Q6rh63I8HW48j7kZEsvOhOgIZ1P3FZVqzZ6gs=;
        b=NL9WDD4etkkaMu8o4/dZyhklcox08jitUCc6ApGajt0g1CT75OqTdEm20laAlLM+2W
         DYN98su9dPkX9FoAB6DyR69f2A3wDWuevmMDq0kSkkXKrRze6i3nxiLTMUOobg8Jwjb0
         n0mezUNSThxFYUzfxRb+LpPFsPOrZ/62BZC8R1lfursTX7eoU8PkF7w5uR6wtLQ8cyS5
         H+rlblyYk3NBI89zMrTgJ9IpZmHszxW2mdLsSorWcaIDo/HzCfWSNaAt3C8HQroIYxVe
         /QDzOQZgHgXqSUzUJafbn/P1tPn1E2uB6dXxjSn8Svn+aqUb4LDQHmTw6Y5ToynJ3BHY
         q23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMq021Q6rh63I8HW48j7kZEsvOhOgIZ1P3FZVqzZ6gs=;
        b=PHYZHnkubVEsF8wrmbB97yfkGZndgeVIyO4gqalOPeK5jj7pj0PsnbYPEZqPjhhyj7
         X25ORL/qMG/Ohd4y9wSxAnulUXy20AgYSiy9cAVu8RYxa0fZqHb2SYGyqfHFJn4xfTfY
         ULZLUBHcJJPDihSmbtjaZAiBQsWJea0pxwjWbvOXhlzeMNgDRhnX+tqxQ/KOhRCm3DAq
         gKzZJMTViOMOVm5XIVSQFH+eQpwXyaxOJkecs34NPvinaAeKME6A7Rb+Fe3jfppuHmoQ
         NWSagH2C4FFyN6gzIVB49HnR/ti6QmgEnamqivIbiRyjFRl6AVjjkIQO01ttVOoRnCw+
         B6pw==
X-Gm-Message-State: APjAAAUzQhW8G7vBxEQ6X7u/sbkqPjk5NePR3fUCFnC/1FXwwmV9939E
        SttwlH8fLrG5oJGBb7XaOxKd/sorYEbx3Ym6SNQWTMwJ
X-Google-Smtp-Source: APXvYqzWKYncZtJiNoouaDYXXOYbH4WHkENN/PJ9VURiiLNO1UznOkEcd0n2TVRxmtVo9Y4DmvTPhVEoc44I90W3rOM=
X-Received: by 2002:a92:4891:: with SMTP id j17mr59752468ilg.33.1577822978611;
 Tue, 31 Dec 2019 12:09:38 -0800 (PST)
MIME-Version: 1.0
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
In-Reply-To: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 31 Dec 2019 14:09:27 -0600
Message-ID: <CABb+yY0qh-qWJWxEaB9_XxmiFb=xP0hOxpm1j54seeT3dMKt2w@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 3:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The SCMI specification is fairly independent of the transport protocol,
> which can be a simple mailbox (already implemented) or anything else.
> The current Linux implementation however is very much dependent of the
> mailbox transport layer.
>
> This patch makes the SCMI core code (driver.c) independent of the
> mailbox transport layer and moves all mailbox related code to a new
> file: mailbox.c.
>
> We can now implement more transport protocols to transport SCMI
> messages.
>
> The transport protocols just need to provide struct scmi_transport_ops,
> with its version of the callbacks to enable exchange of SCMI messages.
>
We can either add new transport layer between SCMI and Mailbox layers,
or we can write new transport as a mailbox driver (which I always
thought could be a usecase). Right now I am of no strong opinion
either way.  Depends, what other transport do you have in mind?

Cheers!
