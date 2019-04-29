Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF25DEB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 22:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfD2UV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 16:21:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33085 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2UV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:21:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id f23so10664295ljc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KBkvUzTALKgFLj/TOeD9d/FpBJiRxV8AwPVY9LOciU=;
        b=OxXZEkxbYVzsZQ7Cy5ZsCi/u7kILgUKY0trvo9FOK+C+EkZRHqW8ZFkNORrDIB/mqL
         F/DSCTJh2z/j8+NKw8b00XyqeE7sxk5+H0Bxooo63jGIVK8qknkJLbfkGup5Jj50YRvg
         NW6+HnkqAnsclagMIbZlDrPBCOOSVVvs2zEnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KBkvUzTALKgFLj/TOeD9d/FpBJiRxV8AwPVY9LOciU=;
        b=kdCFMQISv1jO3P88MNrFGCkCHWJrFOc/lYlrwXojlOGFw5aztp+HMn9a7ve05OFqUt
         89PQClaLmXb+dUkJRW0kTqYi7ad2AkMMR0UNC8qPRHE6bvY0j7rQGc9F0BAhkc1cWG3f
         tUNdNeK7hunFnSGWWjArYvYhCdTRMWnwUDeCsz3Q6/opq6Mh/GdhAI3qwwamjBft0gR+
         751eBf2yk406cIp6e6CRc50d8MWQx36xh0wDgmhP6s4gVJm2rLEJEIyzYN8jo8niJ+9A
         K4I29qDGyB68AexfGO+Ep7SXzlj6uyBNPEdDfJQB6DBG/oYFy3Dc9NKi2CZGdVaw0X1W
         K/rA==
X-Gm-Message-State: APjAAAWa5ymcK8SDLFFf9iMpqlA5mcm57kNv5Xk/f0FS4zvDBs3/SHhP
        JBNSpc1MYTnSZj+dD6v0Jy9itXYjj2w=
X-Google-Smtp-Source: APXvYqyt4za4W5JVorPa/BBVhuhy8csPOW5jMf/SgcjIOFEFAENtHq99zfXIKwi6F5CmdDstnlkGdw==
X-Received: by 2002:a2e:9546:: with SMTP id t6mr7551213ljh.51.1556569286649;
        Mon, 29 Apr 2019 13:21:26 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id h21sm3031615ljf.16.2019.04.29.13.21.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:21:23 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id w23so8892812lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:21:23 -0700 (PDT)
X-Received: by 2002:ac2:4567:: with SMTP id k7mr34223361lfm.166.1556569282855;
 Mon, 29 Apr 2019 13:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
In-Reply-To: <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 13:21:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com>
Message-ID: <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Jann Horn <jannh@google.com>
Cc:     Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:55 PM Jann Horn <jannh@google.com> wrote:
>
> ... I guess that already has a name, and it's called vfork(). (Well,
> except that the Linux vfork() isn't a real vfork().)

What?

Linux vfork() is very much a real vfork(). What do you mean?

                 Linus
