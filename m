Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7807D77B86
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 21:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfG0TmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 15:42:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54828 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387890AbfG0TmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:42:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so50535002wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RSN/mhoh31wRp3jEuzxki3I6BJGkTgEs7NdlZMu4zVg=;
        b=KqStexPZJJ3/iqTKtWc8M9us5pj4+8mw+Rde81iFF1DpU46bpIuzLIdyFzZi0OHSeU
         G51Had6XkheksEsyb6bZznVtU+JS65TFph/7s8T39urSrVT7UqyegbuVFs2jOcYbQayh
         CHpe9MTS8LcD3ktZodYIurlgaLH7bjpu8gQlHKP0yP8o5azdPIc1z+4Lc7rX3gtjSf/Q
         1DjkgRBpZVEPoykVWpJJcX5Ng3rG0ODouA9ZiTqftiqNcOB/GYD0wCuJE1roTXewiojU
         CPwESkmz0qPBnOpNPIqsofg9geWiLxIwmw+pdmWCkMaVHXRsTSB9rTiELnGvYhltHES+
         n4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RSN/mhoh31wRp3jEuzxki3I6BJGkTgEs7NdlZMu4zVg=;
        b=QgATHVd5K5ZvIeHxMt4+bh2pyDuu2Iz/IZ462fHf7ZyLXLvmkRMZYYGcVUbCwZvOIP
         EXTjVj+5BWHlmeXqTIqoYJyL5nXWiads7iuFAYAF+z1gGoc3AT4eeu/7Ob59rSuNqgb+
         5synoMvSffuX5dSq8o8lefrqGUUk3YMxeYkq7lYDHTEJv6WW21H5zdTtzqjywP3+y2r5
         LpARzNRvIXXzwAglsUxbYTvH9aDPb1uTqtAHPxGnr8FLfcmj3Df17AdyWIG3F37sRpv8
         V+EU/35+/nzV8AnU6MX0bP5Q7YLxtALqrXOaerK/98NmropxvNVDZIZLyDNrWJ3STX27
         6z4w==
X-Gm-Message-State: APjAAAWkAA30tUCh3kXYnp9auGGrb7RIdVvkGh1toAkvcP1wJbqBwOou
        T/cmzNFPh9jSOSpUuWzDVZQ=
X-Google-Smtp-Source: APXvYqwFlDCMjphiT4N5vkY15TtOQFwee1uUINRpiQAhjpb7EiBMzHLsob5pwzop5OzRSMrFRgz7bw==
X-Received: by 2002:a1c:f90f:: with SMTP id x15mr13907303wmh.69.1564256539073;
        Sat, 27 Jul 2019 12:42:19 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id 4sm130694074wro.78.2019.07.27.12.42.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 12:42:18 -0700 (PDT)
Date:   Sat, 27 Jul 2019 21:42:17 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 1/2] pidfd: add P_PIDFD to waitid()
Message-ID: <20190727194217.izpetvy5fz4dqj7q@brauner.io>
References: <20190727085201.11743-1-christian@brauner.io>
 <20190727085201.11743-2-christian@brauner.io>
 <CAHk-=whrh5+aHmgqP9YhZ-yzCtUWT8fPi08ZSJdxusx7aHXOQQ@mail.gmail.com>
 <CAHk-=wgtGyQTLLb7m=jkMY5hOcj+TsOKSoeoJC7Jc1_h_XL+tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgtGyQTLLb7m=jkMY5hOcj+TsOKSoeoJC7Jc1_h_XL+tw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 09:41:25AM -0700, Linus Torvalds wrote:
> On Sat, Jul 27, 2019 at 9:28 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Something like
> >
> >   struct pid *fd_to_pid(unsigned int fd)
> >   {
> >         struct fd f;
> >         struct pid *pid;
> ...
> 
> I forgot to put my usual disclaimer about TOTALLY UNTESTED GARBAGE in
> that email. I want to make that part clear: that code snippet was
> meant as a rough guide of direction, not as a "this works".
> 
> Hopefully that was clear.

Yeah. I don't take code someone else has written without verifying or
testing into my own code. And I hope people do the same with mine. :)

Christian
