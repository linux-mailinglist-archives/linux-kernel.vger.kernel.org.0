Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78537172805
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 19:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgB0St1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 13:49:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37363 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgB0St0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:49:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so286144pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGeaLHlnGkG2EKVANYEasocr4XU2jYAIuDOZRJsT7Oo=;
        b=XyXxJgvedHV34V4WJqX+Hr1W3blvQ9Hasu/MLokQnm07W62Yj4XxYbDLBD+Oub9RHL
         LL1VgVjONRaR6ahJdPhB2b02mAwIwDg/WoQbB1E16zQJR9KVxb5Ap9cDaN80E1YWkkAG
         XMR45E0mtgatAGy5A/oijIwby9+b7QygKEBYrjZw6eRmifq6pJr+8YZrOZMz8yE1RKDT
         JmyvlF7U3P/vmhWuJ56dadoFI1e0Z2fibqXWNajTLAD8CpQm79ErQMfaAn/GHKT7OX+6
         8MB/26+0SzXiBTIZLUOylD6Fe31YzRhW2c6HGUjMrJr8f0CLEWIa1bmvfmteoHDMFg7g
         RpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGeaLHlnGkG2EKVANYEasocr4XU2jYAIuDOZRJsT7Oo=;
        b=q+VakSg0b06T9pa8eMsxejg2A7yZR1nmj+XwTCzJAvgSYKN5TBeJ0QpaMgaf3cQU8i
         OUgvMyxpykFP0UTVLVfIutnIM5PfcZ1WoB+T3oTryvqGkKhaCetaSUpLGea+mmig2Xr8
         FeGFrOmWLWEOlwkcdellnUSNZk2/NnvKSPyQMJmtt+kwskTOgclxbn7PGX5LTA9rqhRD
         mcAW4Cc2SjSOob2p4bRXijmw8JjLEY8UZHrcoHJSyhLR+Zm5A78TQ9S3hlFj2XIX03OJ
         9/+nD9CI1TysPvI09zm9IeUGHC8p0QY/wIMFTIE7tRQY6MFiheAV5uwbq7QrI8rG+A8H
         0jog==
X-Gm-Message-State: APjAAAWH8g6RxZniXwMUQN5xZtkX5Z4zfT6sHcXzZ97XHuxijXMdXOHt
        ycq4ZVa9XtKyafzEO0geY/T3s38Fzhl+9fe02LoPMQ==
X-Google-Smtp-Source: APXvYqymmOgdXa7CniObsx9VEGVRv2HX0Gml6mbnSA0rHlXFD0LPmOU7h+ebHH3tu2QnqHoViA3n/JuGoldtb3q0fdE=
X-Received: by 2002:a63:fd17:: with SMTP id d23mr711822pgh.159.1582829364378;
 Thu, 27 Feb 2020 10:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20200227063134.261636-1-gthelen@google.com>
In-Reply-To: <20200227063134.261636-1-gthelen@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 27 Feb 2020 10:49:13 -0800
Message-ID: <CAFd5g45X_jW6=8XZ8JY3iMgO1wc92wec4WsKCqJvDmjss5d=5A@mail.gmail.com>
Subject: Re: [PATCH] kunit: add --make_options
To:     Greg Thelen <gthelen@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 10:31 PM Greg Thelen <gthelen@google.com> wrote:
>
> The kunit.py utility builds an ARCH=um kernel and then runs it.  Add
> optional --make_options flag to kunit.py allowing for the operator to
> specify extra build options.
>
> This allows use of the clang compiler for kunit:
>   tools/testing/kunit/kunit.py run --defconfig \
>     --make_options CC=clang --make_options HOSTCC=clang
>
> Signed-off-by: Greg Thelen <gthelen@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks! This is something we have been meaning to do for a while!
