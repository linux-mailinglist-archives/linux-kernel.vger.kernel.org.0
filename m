Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7F011C2F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 03:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfLLCGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 21:06:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45469 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfLLCGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:06:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so287073pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 18:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8uVJuk9Rij22sABZy2BWSypOjcfhaayG9+6fPbQbo4=;
        b=kJlWk2d8oy9p5Y0PRDaFDUDjrYDaNJqrDSBo/7NW3RUFN0wawvqDXTJf+eYArOA1KS
         L4U0DzZxi66nDk6Rqk8bZ2i8fLsH4TorrtqhtGiK83RQ8OJIPE4Igae1H82+RoBfHtxc
         KhPChDpzklLsHIWQtFhmd66zg8Vk6EYmbQNj2yHokXqXzgwkIPc2GX+irfLUGz6jV7kX
         ZM9IRXqS2A36l1VOeJjFWyEqcon+NEUR/IYh2ITZfvVrXExLSMMoyWNenGh4ebbZi0L0
         JUAP+U6BxU+R70W7ojw9TnGVnOzt7ODDIzjGV/AN/Y9rymQVRAoXYtslGduK7r2Nameh
         MwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8uVJuk9Rij22sABZy2BWSypOjcfhaayG9+6fPbQbo4=;
        b=KJZP7ULBeltXeUrGX4JdSfVSFiK4Eqoyz87Yi5FAEGT8lBOO04mqKjUVbjblWjEh3m
         jdw81bZhyeimsb3zbdmn/M4Ff4kOI6b8pBEzRWIDZ/CaV9ApnKGZNTLeXmt75QZd+JG3
         vAVlyQuW1Xn/gwva3YTc7rydPRYSFxiwh23ScCVOCc5IZqUkYaOvCrdH3traS753ghAA
         rKE1LzDJxrD+XmXlH573HPmbAIqpEkxhfWV8SfspbvoEjPjSlQmXX9gxD3j2vYIO3iFz
         XDhvzVtbmxISjGwMERNbPVEeW9WWeSTASSmPDcqZErwXTGgMA8jbRjNG4e6riSiYH9i/
         1Upg==
X-Gm-Message-State: APjAAAV0mxjnPxgKmAlNB5DRFVYb2meJAOz5gwdsY5N0hNc2K5M0mAXd
        9IeqYRtHxOWUq4RAeIYkVGhViqawy0oZpXkobWujxQ==
X-Google-Smtp-Source: APXvYqwMuQVtQeasph6V25QIqqP76VeDN8XIyJ4UupJQ3Egb1/mmDEEURWdiUS8rqAYz+CzRrEM4bFbeFjrv7MR5Aew=
X-Received: by 2002:a63:597:: with SMTP id 145mr7496590pgf.384.1576116381498;
 Wed, 11 Dec 2019 18:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20191211163310.4788-1-sj38.park@gmail.com> <3dab421e-6aa5-90e4-791e-53482f5c1fe8@kernel.org>
 <CAEjAshqjjVgtf_JxNvi3WOvkrjOp_-YjK=rY7GE0Mt40Y1EMqQ@mail.gmail.com> <CAFd5g4649_C0tSy3W-KzN05Y8K5zZtGUGVYFA9iAKvaXsPentw@mail.gmail.com>
In-Reply-To: <CAFd5g4649_C0tSy3W-KzN05Y8K5zZtGUGVYFA9iAKvaXsPentw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 Dec 2019 18:06:10 -0800
Message-ID: <CAFd5g46X4P7dfJWVw9hdvhVupanuZU-_KWGzostRy_e1Z=P1Og@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Fix nits in the kunit
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, SeongJae Park <sjpark@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 9:45 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Dec 11, 2019 at 9:40 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > On Wed, Dec 11, 2019 at 6:22 PM shuah <shuah@kernel.org> wrote:
> > >
> > > On 12/11/19 9:33 AM, SeongJae Park wrote:
> > > > May I ask some comments?

SeongJae,

I reviewed and tested all your patches. Everything looks good to me
with one minor caveat: I tried applying your patches on
kselftest/fixes[1] and got the following error:

error: patch failed: Documentation/dev-tools/kunit/start.rst:21
error: Documentation/dev-tools/kunit/start.rst: patch does not apply
Patch failed at 0005 kunit: Rename 'kunitconfig' to '.kunitconfig'

I think the merge conflict is fairly straightforward, but it would
still probably make Shuah's life easier if you rebased your patches.

Cheers!

P.S. Thanks for the patch adding the test case for test the build_dir
thing. I really appreciate that!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=fixes
