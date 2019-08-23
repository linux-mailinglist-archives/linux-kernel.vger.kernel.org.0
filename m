Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06E249AB2A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 11:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfHWJLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 05:11:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45837 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfHWJLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:11:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id l1so8162062lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tpf4Sd4sB67NX/Z0IE/0oo2kV9MKJkg6CHsjIEFd3KU=;
        b=hvtDkSp8ReBY5hdjK4hImGWVQ5NMpTNhQhINoHc1bbkSFgdb9Ax378WM+rfSMd7TCd
         L5l9M+I6EkospSpiXQDtwe2KUNFaY2oZKO90OtBFOJJtJ0a0TfO39AMXgnZR9blwIYlv
         Bn7Kp3XyLiXa7GqljQL1bpD/u1+yjvbd7/u5+1xFfEEes5ciwJse2zTxFKWjCXwlfi1e
         7QnEKFbiHGibHqdyTK9H31/3ROaam4eu36TGTJRdAOlxXIv6UmJUvr7R0+aLXYdllKZT
         TwebQ7MADWX7zYvyWeDktJ1SQBr0JH4mC7Erji6wztasivkKVX8d9kwXk3bW8B77kz6N
         dOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tpf4Sd4sB67NX/Z0IE/0oo2kV9MKJkg6CHsjIEFd3KU=;
        b=NXpTpp+RFKO0Zkp21qAIOHEy3vrfRviuXkiYheY9ZbxQZ5JFWovMmy+LDGit2ic/h5
         J9utfqzUfUJoap3E12I82uwxe1LmO9paNY7NjUvJLWQ54r47SjHh5y3IETtvKVB6SNV9
         TPM8v0dy5bWMcviP9i6cvcmPV5r9h0OfY798/hylH4yqOB1qy08tBCR710vkt55eAMDN
         8DU/SEUCyydfKsAfCnVUsp+qPxzDF1Jy0u4qDEg0IdlfQyXXibsnLO0IuqU8ruxqdmWe
         LXkTowfBgUrSbiUftSM9Ov6dtgYvt7v5ByCgN1w2IuN9Ifkjq78SJY9pvDbKENVmOyG0
         XkJQ==
X-Gm-Message-State: APjAAAWabZfJ5K+yHhM2JdRyFQFuaPkjy0n+UNbXsqzyVJoBXPhSeFz/
        mqBv6Xa+sSOURkCRpyhqfu/psV4Vyyzr119rmlTmEA==
X-Google-Smtp-Source: APXvYqz37lVtHx2l7gPIBZDv+uBLRAQ6u2yeaTKA4VZIsyOtvW1TJ9Q5d2CBYS6UXGuidR9DURFQ3Mx2hHusBqV3J30=
X-Received: by 2002:a2e:b174:: with SMTP id a20mr2344817ljm.108.1566551505375;
 Fri, 23 Aug 2019 02:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190814110035.13451-1-ramon.fried@linux.intel.com>
In-Reply-To: <20190814110035.13451-1-ramon.fried@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 11:11:33 +0200
Message-ID: <CACRpkda7_YP7FC0e4JnaXJNB_aGMFbNdjN8kdKfHZ0LVnkyopg@mail.gmail.com>
Subject: Re: [PATCH v3] gpiolib: Take MUX usage into account
To:     Ramon Fried <ramon.fried@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 1:01 PM Ramon Fried <ramon.fried@linux.intel.com> wrote:

> From: Stefan Wahren <stefan.wahren@i2se.com>
>
> The user space like gpioinfo only see the GPIO usage but not the
> MUX usage (e.g. I2C or SPI usage) of a pin. As a user we want to know which
> pin is free/safe to use. So take the MUX usage of strict pinmux controllers
> into account to get a more realistic view for ioctl GPIO_GET_LINEINFO_IOCTL.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Tested-by: Ramon Fried <rfried.dev@gmail.com>
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> ---
> v3:
> * Remove the debug message and replace with comment in code.

This V3 version applied to the pinctrl tree for testing with
Stefan's ACK.

Thanks for hashing this out.

Yours,
Linus Walleij
