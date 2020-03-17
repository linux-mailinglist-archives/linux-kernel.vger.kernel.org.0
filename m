Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216D9188D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 20:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgCQTAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 15:00:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33268 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCQTAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:00:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id m5so12242713pgg.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIJJdVcrbCM1Uy5C18NJ7lLDk8OKxklWqi5JifEremM=;
        b=t1yRuystaceBAj2vdu/nWWcgFCniTGzwYUiNO3l4lHaEkq7FTc7csqHVrUPsB9a/mO
         Y5RgaJz4/YljCTcjyz2xC8Y60p/WqlGd4aQfgQJRSsynwMjLks2O3zfOXqFb4HUXXSjZ
         tIk5cL5WVibK8V/yTbaDXTmdiM8QHpBhYWXAgEH057XQImkEJuBx9peYb8lgPO1eRrD/
         tTwKugBzuwFGOD8sd8RNGDW95uQyDj6OBMN7tgGhYx0EDTh8qQXz1nerH9AKmRPA2ANE
         +vxhQaQmFIMCKeymNUiAkvFmEYHwrcJHTFcMb7BNZ60pJGh02aMTTAApJHvo6fyZcU3y
         D1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIJJdVcrbCM1Uy5C18NJ7lLDk8OKxklWqi5JifEremM=;
        b=sGLzlN3Vak93A0phM9E3qrvPV4/Vi+UflKrrUguDfumPmBZpmyfzEC899/cOj1Pt1u
         qQEBD5KMbn6gY9SYMXt7HE0wDOUyk46tPUq0PMJIJbkhh0MTYN6nkDIF0iDVd6BCj5pu
         dIyW8LnJQ+F3vOakBpfQwA4O+ifgLR/4zMt2A75xbRMogMaXRHtPksiVpmQU3m4eH0on
         5rKtpM9wC5+2ZBoD3qbMCPxF8L0supidm3+KclmGt08p9ez6E3dxH2SMKp2pZkxT2tSs
         ViYfQqzDHnMXP5nwOho1kOTQcyNo0dK4N+m6EuOBpUeCkksuRle1iDgq6e6Drf7/vNyb
         0fxw==
X-Gm-Message-State: ANhLgQ0LzAu5baIO3BDAPYRrVCdNx0zQ4cx1Tr/e5G8O38kXar0ChzbD
        3xwULjSn/2O9AKv9XWwh7BDt20qR2y61k/9O/NB4XQ==
X-Google-Smtp-Source: ADFU+vsTvGgKUFwFLLQGeCQr0N0/ivnCHwSCvZxKOhpjrFCzdjXOv6yQY6SsHgDcAB73dGzQo/Y2fxB5PC9A5Xylw9A=
X-Received: by 2002:a62:8343:: with SMTP id h64mr231036pfe.166.1584471614689;
 Tue, 17 Mar 2020 12:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <1584466534-13248-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1584466534-13248-1-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 17 Mar 2020 12:00:03 -0700
Message-ID: <CAFd5g46AZC7EPgxfTRdws_4u6V=AxCGASG7jxCJXuXU=hJUxog@mail.gmail.com>
Subject: Re: [PATCH] arch/um: falloc.h needs to be directly included for older libc
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        alex.dewar@gmx.co.uk, erelx.geron@intel.com,
        Johannes Berg <johannes.berg@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 10:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> When building UML with glibc 2.17 installed, compilation
> of arch/um/os-Linux/file.c fails due to failure to find
> FALLOC_FL_PUNCH_HOLE and FALLOC_FL_KEEP_SIZE definitions.
>
> It appears that /usr/include/bits/fcntl-linux.h (indirectly
> included by /usr/include/fcntl.h) does not include falloc.h
> with an older glibc, whereas a more up-to-date version
> does.
>
> Adding the direct include to file.c resolves the issue
> and does not cause problems for more recent glibc.
>
> Fixes: 50109b5a03b4 ("um: Add support for DISCARD in the UBD Driver")
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
