Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D86146BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 15:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgAWOxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 09:53:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34827 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgAWOxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:53:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id j1so3790054lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 06:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tP2rc3sKgqYT9el7f1WHPuLRZRmFlraniNcLzRTh1pc=;
        b=IoZ+hHh9hNTkHT2YdnouTrYjcsSt8gBQuva/8HSDudsOjNdpBl4/AY6qjsAHBlriLV
         nTHyHpV+MwD85kPFu8T95GN+dtKdP69SnHaFGu9mMcuxKzDrxWNde1TNydE3OP+B1pDi
         YdKXnPtMUKfYQz+qEHDPX1SXImBIn5SKSC5ld3HA4mRE8mwoPRm2KAblSga8TJUt8lEV
         HUCMahOwnl0Qgb5YsPjJK+Uf3STpWDbV5hPuSUlPye0aJKEqyc5myrXRWOe/3odRhFVy
         gF8bxp2wwGmuv/sSJ77ptgBBO+GfpuXC/w9pS0s942Qk6Q5hbrRW5/BrbI+px+OdoBA5
         ddQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tP2rc3sKgqYT9el7f1WHPuLRZRmFlraniNcLzRTh1pc=;
        b=sVLtXtyrIroUwA7aG09/VDtOWDQABoKmGT7t4qypAYW0nBaE7NoHmc8+XxXM+886J5
         g9K8QQ8rTReOp6VZ36VPPUlNsrsRUaszsrzImrOY1QlIAtwVt7/D0BHT0Or3qVbfERjX
         lboN0hhw44sBwvvfPbgkMxYCanN+gAWpONqJCXr6vRHLCYVwkVBqc1g+f9Wqa4IpKHOl
         b+n0h6YtToEikIpue2RkPUqkbVyHce/rfFhEqdtXv7yVuXfewmws+abCF7ZKC1x0uhki
         uRWqxfTOCLgb8Q13VZcbmcmNjPFNGzDY5bdIzbgifqzeFT2Wrz2faZ1b5bp6kb3+gQ3Q
         PU2g==
X-Gm-Message-State: APjAAAWsViGIuRfnwS/DAesluWJdd8JNxHl3u7uomPFjZIpzqKAwM6Vb
        0ddIMnNB8aMoqdu5XbeZrT/OuEt72gLSYsD+44Hu3g==
X-Google-Smtp-Source: APXvYqwfj7WWn0juBVOB8AF0fnjeeNkmI+4iRvbuJD3XjPlxz72XbJT6NEb8X5O+9ai22dAUSazBreWyIu9u9mNdGqM=
X-Received: by 2002:a2e:98c4:: with SMTP id s4mr23335397ljj.102.1579791224055;
 Thu, 23 Jan 2020 06:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20200115073811.24438-1-bigunclemax@gmail.com>
In-Reply-To: <20200115073811.24438-1-bigunclemax@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jan 2020 15:53:33 +0100
Message-ID: <CACRpkdYqTCmG1=HM0QphPou43HFSXBNB5HH1R8xH0KEb=zxC1Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: clear irq in edge cause register before
 unmask edge irq
To:     Maxim <bigunclemax@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-pwm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 8:40 AM Maxim <bigunclemax@gmail.com> wrote:

> From: Maxim Kiselev <bigunclemax@gmail.com>
>
> When input GPIO set from 0 to 1, the interrupt bit asserted in the GPIO
> Interrupt Cause Register (ICR) even if the corresponding interrupt
> masked in the GPIO Interrupt Mask Register.
>
> Because interrupt mask register only affects assertion of the interrupt
> bits in Main Interrupt Cause Register and it does not affect the
> setting of bits in the GPIO ICR.
>
> So, there is problem, when we unmask interrupt with already
> asserted bit in the GPIO ICR, then false interrupt immediately occurs
> even if GPIO don't change their value since last unmask.
>
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>

Since there is no feedback from the MVEBU maintainers I have
tentatively applied the patch for v5.6 so it gets some testing.

Yours,
Linus Walleij
