Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40D710C0E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 00:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfK0X6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 18:58:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40332 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfK0X6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 18:58:41 -0500
Received: by mail-qk1-f196.google.com with SMTP id a137so19373304qkc.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 15:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3WUEtOVqQkZFCkhjjxrIAxoTowOJXCq4QS2LfgvlaI=;
        b=Aah2cc2YM0jiYqAcIE90XoHLZdq3QXri37FqgF0EOP/1wTYW0fOKqBoH6Dg7Tn3vyc
         rWEhzubRlIOLm/FBQQYQzEtLXgDutfIIdqu9qRVDooFgUO/VBXsjovf2B2s5LTpM5lpq
         q27Hd52fANKgRR7OX7YQG+IMEvhfGQYx0bnLdHr+J7v79SHHvw+B7OxARdFOK+UBUcQt
         2+V9ZO3voPpLxGBxvm/ik5CHf2NNL6iOQsz8VVQjZtAXgv0/yiugtYawzJY/VcP0jF6z
         PoHpjGMr7fQO14OANPj/rf5nyjjvnDmD+adXc7+FBKaVp5dyDApcac/pb0hISkTdeKxy
         jKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3WUEtOVqQkZFCkhjjxrIAxoTowOJXCq4QS2LfgvlaI=;
        b=JcZsjuGsX5c81St0pUD/nxBpTu8FC4g3XOj+YRkryvqVHzA6PEGPiHDxIbP2FbK9hn
         3qnwQAjAM3jV3mCI08BA+ccRgGfa6jC2gCDbGCilmW28BZwq48mKacyfzqRP9K/CAEQd
         a38mPPo8tSZD4GspQ3owxNmx4tmRURnO/B818WfCgBcVr3qhdKR9AXw+eB2KLRtyQvL/
         5omuOhfdXho7oqnRL8EHMkDgSAgG9e4NJIb+T6sQpKkN7z3j+4Lf0zK1+pgtJ3j3vr7/
         7x82f7odS+vgio+U+h3idwCgQ2rXBmWERL2DUDfHrnd85woXAKgGIjT+oXTYdrJ/rXKo
         sDrA==
X-Gm-Message-State: APjAAAVYVn9sbuvI4s7JqxzRNjJpDe8YgH4s6AGm18z5CbrPZ4hyk7FG
        Q4nuQc4oeDFva5UUxNfTWl8vZnAmcK9Uovlnlxyulg==
X-Google-Smtp-Source: APXvYqxZ3fYPwmk4+mWdgkml/CxCD/cZA+hVrli74YtbeQMx676MyN3FZbkequj/3CcA5kCvGYoQMiNZX/pdiSyNC2w=
X-Received: by 2002:a37:a08d:: with SMTP id j135mr7499764qke.455.1574899120904;
 Wed, 27 Nov 2019 15:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20191127231926.162437-1-heidifahim@google.com>
In-Reply-To: <20191127231926.162437-1-heidifahim@google.com>
From:   Heidi Fahim <heidifahim@google.com>
Date:   Wed, 27 Nov 2019 15:58:29 -0800
Message-ID: <CAMVcs3vKjd8XVku8VUq2R-OKKSq-X2L=h4niFxuoPBe_D63JAA@mail.gmail.com>
Subject: Re: [PATCH] kunit: testing kunit: Bug fix in test_run_timeout function
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, shuah@kernel.org
Cc:     sj38.park@gmail.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 3:19 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Assert in test_run_timeout was not updated with the build_dir argument
> and caused the following error:
> AssertionError: Expected call: run_kernel(timeout=3453)
> Actual call: run_kernel(build_dir=None, timeout=3453)
>
> Needed to update kunit_tool_test to reflect this fix
> https://lkml.org/lkml/2019/9/6/3

Wrong url, here is the correct link to the fix that caused this bug:
https://lkml.org/lkml/2019/9/6/351
