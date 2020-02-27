Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB23172AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 23:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgB0WPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 17:15:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45094 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgB0WPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:15:49 -0500
Received: by mail-io1-f68.google.com with SMTP id w9so1201349iob.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sS6jPYTpZ18cW7Yx6dHlAo6XqtjDIW5BTwHXH9hMdcg=;
        b=VTX2AS/iJyVpKvpZYtu1fkoEMKs2JOA/Oxy/J/CTQXMOThLY2DkHQJZ7uT2XeH8ywL
         enhylSKeaKjh3HWr9YvZYdgCeQx8fjOCkI2ZvMl+Vw/ztyqWVLRNYAZ35dVSoK2I3XCZ
         fjOmnpDq9Z6fMxZwN2sr8iZLKgvVNKfx5kLtA6wZX5xYaZ4wnSQPQAPg9whoPVBbYX+u
         rbZAhIpTPng0kdskuBKB8+lF/xYOUFlxTpLUrN9EgtQ3+7+Q6DGj66EIvwOjyLIiwPYL
         5aRik4btkoHooFOQke/O89tZxEK+sKE3YbugYRppjdMRqovrHCRuK0QoZcy8YtscRkyL
         dYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sS6jPYTpZ18cW7Yx6dHlAo6XqtjDIW5BTwHXH9hMdcg=;
        b=kGdwOp14HXjHoKuIMAWKOTvpt/ZNSRUHVnVSYP4fKYJLITS/AOIZ+wDI3HYE4mX5iD
         5WHK2Y8vNGQNg7sQhrKLKgLLpcfukR9cRv6WTOA7z6E3y96fWIKF/eUjFoEcF7Me+w9N
         IZneVkkb0A8CNkqDLPdkN31uDoikupIzOyT+Bd6tkLS+uSzoSTU4efzgR9Sj7nxAmMj5
         +ZBV7LVVecJIyHt94Aby/NYMyIE+/9mBR58vRhbV2w06ebzSC5IpRWSL/KtM7UDcZgvp
         ZtZ1gCb4kv3YAQGCUSDAhmku5OKEOLsJkFGw6J6PLun6MWLnGWrHG/ByRS4wFWUrIzIf
         38lQ==
X-Gm-Message-State: APjAAAVBRdPSeDmEHoyLAM0pp3yJjZ3j8Kvh0y0ZG1ieOGLX+T/e9L9o
        JU5vGHuNxfxHEAhPDK0Jrborb6zDJyAkIGaQpVy30w==
X-Google-Smtp-Source: APXvYqyJFNbbAECVFsSrLP75dad1wv1jfSH5W4J7cQZAVIZDcwK6drQ7tI/nDDDqJotqWMt4QyEyQ3SzslcDmn1aHD8=
X-Received: by 2002:a5e:df06:: with SMTP id f6mr1243123ioq.84.1582841748073;
 Thu, 27 Feb 2020 14:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191216114636.GB1515069@kroah.com> <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
 <20191216201834.GA785904@mit.edu> <46e8f6b3-46ac-6600-ba40-9545b7e44016@i-love.sakura.ne.jp>
 <CACT4Y+ZLaR=GR2nssb_buGC0ULNpQW6jvX0p8NAE-vReDY5fPA@mail.gmail.com>
 <CACT4Y+Y1NTsRmifm2QLCnGom_=TnOo5Nf4EzQ=7gCJLYzx9gKA@mail.gmail.com>
 <CACdnJut=Sp9fF7ysb+Giiky0QRfakczJyK2AH2puJPYWQQKhdQ@mail.gmail.com>
 <4abd90ad-dc1a-7228-1f1c-b106097bcaef@i-love.sakura.ne.jp> <9e5b7fde-4a18-a10b-fc53-c025bf96e8f9@i-love.sakura.ne.jp>
In-Reply-To: <9e5b7fde-4a18-a10b-fc53-c025bf96e8f9@i-love.sakura.ne.jp>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 27 Feb 2020 14:15:36 -0800
Message-ID: <CACdnJutc7OQeoor6WLTh8as10da_CN=crs79v3Fp0mJTaO=+yw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 2:11 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:

> Here is an example of need to lockdown specific ations. Can we proceed?

As I said before, unless the thing being blocked is a primitive that's
intended to allow modification or reading of kernel memory (directly
or indirectly), I don't think lockdown is the right place for it to
be.
