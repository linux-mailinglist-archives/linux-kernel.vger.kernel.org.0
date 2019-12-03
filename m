Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D14112066
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 00:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfLCXob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 18:44:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45483 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLCXob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 18:44:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so2613889pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 15:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmVwi65CWiJjwCJUR0CFb8uCvZ6Xi+9s8UtGSyRd46k=;
        b=MZUIf5jnSV7XWugzNbjYEJQilfXNtwyyP5KRIeWEbvC8koooPV6r+OX+f4CPnp5HIr
         UPttTaGiY5cZeuO68HkXYF1zbXFbgNJXB0tybDsLlJaafZYuTzoV+I+kldkVXP2X7Axm
         iTdlacJqYZ43+ojAzHaF/lJWCc8bFIFCpmD6J/0QePnso0ukb478GzP0Op8ZFw3qW3uR
         MIXDD/rsPJpTqszvu7O+lbHLoh28HGNkNaf73lRTn+u3JXvhWBw0kkGvJxAYaYAUbpiW
         4NJubPjdkIDP7cArLCISmyKmAptza1qRgXCZxSU8/+wTHcd0thCY7wU3X/6kxdz7nKD2
         vMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmVwi65CWiJjwCJUR0CFb8uCvZ6Xi+9s8UtGSyRd46k=;
        b=pZWfMD2SlND6/SfEWQuTLTfYbb1xsZM3CgYleiS86JD5E2tfWh0Dfxf8OsEgrhUu0y
         pfim2VDaIjSMtH8xbp2FRkt2V6myrJaZQehwUGqSESFa3Mp/58uR5aRjT6fYox2usadt
         U0Mc4yabwENeF+JHXYmt3gNiOqzcfOR3fmB0Tng9zLtSvpBMAyA7zEptPDsakAnF5dsW
         xGrBnA6ZHqIUOcyUinqPWMOOQutFQ7pe3MXErJW1oknW/OKXxCUfMwlaCNffgMF/ngc9
         ebraEVU1jIz0RH9aMNbRh8kM9WOzW1vZVG699vW81xfiigYerf1E3RjvmeCketDCHRvF
         8ewQ==
X-Gm-Message-State: APjAAAWgwS95gvX4bfZd5BVpfSJAvdmvp2wuBtZmKNwHBWECKd5IQ2Oq
        cJWFzYtgw6GGYj/tXM4yrxkymq5CiGkSKf9tbIo3oA==
X-Google-Smtp-Source: APXvYqyv4i+NpsBtYtRV3LYVXtRCPYQX4vOZgjxEtoC6uhZ4RpjVYWwnLfHiarLH5P/evG9t3D/1hcDpDqsveH3CAeY=
X-Received: by 2002:a63:480f:: with SMTP id v15mr278308pga.201.1575416669991;
 Tue, 03 Dec 2019 15:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20191121235058.21653-1-davidgow@google.com>
In-Reply-To: <20191121235058.21653-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 15:44:18 -0800
Message-ID: <CAFd5g46Z_vVb92Y-sfWi68=HFy5+kukZXvT9usEEnhBUvPg3AQ@mail.gmail.com>
Subject: Re: [PATCH kselftest/test] kunit: Always print actual pointer values
 in asserts
To:     David Gow <davidgow@google.com>, Kees Cook <keescook@chromium.org>
Cc:     shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 3:51 PM David Gow <davidgow@google.com> wrote:
>
> KUnit assertions and expectations will print the values being tested. If
> these are pointers (e.g., KUNIT_EXPECT_PTR_EQ(test, a, b)), these
> pointers are currently printed with the %pK format specifier, which -- to
> prevent information leaks which may compromise, e.g., ASLR -- are often
> either hashed or replaced with ____ptrval____ or similar, making debugging
> tests difficult.
>
> By replacing %pK with %px as Documentation/core-api/printk-formats.rst
> suggests, we disable this security feature for KUnit assertions and
> expectations, allowing the actual pointer values to be printed. Given
> that KUnit is not intended for use in production kernels, and the
> pointers are only printed on failing tests, this seems like a worthwhile
> tradeoff.

I agree. However, I also remember that others in the past yelled at me
for assuming that KUnit would not be built into production kernels.

I feel like +Kees Cook would have a good opinion on this (or will at
least CC the right people).

>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
