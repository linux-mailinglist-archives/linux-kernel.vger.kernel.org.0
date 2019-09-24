Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06847BD057
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 19:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394594AbfIXRMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 13:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389586AbfIXRMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:12:09 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 494E521841
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 17:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569345128;
        bh=SRE4w45g2rUmKQrrhnWYkWFb0+EjC7R6yTgfc4Pc+Es=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cul4lPj43R8SyZJQUrm1p46lCQuMZI9UnsJcDgpnHzZJ8uDFW8mskgD538ujFAp7r
         GMQjnCrwIiJv5CpFT5sD2o9WeddqpRNSJZ+ZvBu1++0hAreStOeIqgualI3wNRokzO
         FJFSzQhe72b1eUfPKiXabbR3dq929RWk06sPT5YY=
Received: by mail-wm1-f43.google.com with SMTP id 7so1038922wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 10:12:08 -0700 (PDT)
X-Gm-Message-State: APjAAAU4Zp3VVSxIr5mgrIDaZv9o2gu5mCE3JV/+hOW9AvxbbuB41aW5
        hQT6vAJVq/ZefZdgr2lIfNS700ms4gK5rGexnZLCtw==
X-Google-Smtp-Source: APXvYqz3Q0HHqCyDvH+elSspozaob5vsw8VZ7sTVeqI9f4cRrzEBFK5bbTHm3tCuCwTdatbEuC0akEIkOQ4fshlQF84=
X-Received: by 2002:a1c:3803:: with SMTP id f3mr1303822wma.161.1569345126773;
 Tue, 24 Sep 2019 10:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190920131907.6886-1-christian.brauner@ubuntu.com> <20190924064420.6353-1-christian.brauner@ubuntu.com>
In-Reply-To: <20190924064420.6353-1-christian.brauner@ubuntu.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 24 Sep 2019 10:11:55 -0700
X-Gmail-Original-Message-ID: <CALCETrUdjCZ2tyGHuYi0TOQDtxEDAYdv-17=-5MKpfzFdiPNMw@mail.gmail.com>
Message-ID: <CALCETrUdjCZ2tyGHuYi0TOQDtxEDAYdv-17=-5MKpfzFdiPNMw@mail.gmail.com>
Subject: Re: [PATCH v1] seccomp: simplify secure_computing()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-um@lists.infradead.org, Andrew Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Drewry <wad@chromium.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:44 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Afaict, the struct seccomp_data argument to secure_computing() is unused
> by all current callers. So let's remove it.
> The argument was added in [1]. It was added because having the arch
> supply the syscall arguments used to be faster than having it done by
> secure_computing() (cf. Andy's comment in [2]). This is not true anymore
> though.
>
> /* References */
> [1]: 2f275de5d1ed ("seccomp: Add a seccomp_data parameter secure_computing()")
> [2]: https://lore.kernel.org/r/CALCETrU_fs_At-hTpr231kpaAd0z7xJN4ku-DvzhRU6cvcJA_w@mail.gmail.com
>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: x86@kernel.org

Acked-by: Andy Lutomirski <luto@kernel.org>
