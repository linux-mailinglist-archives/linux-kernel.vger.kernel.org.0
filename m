Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A50CD887
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 20:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfJFSIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 14:08:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42236 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfJFSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 14:08:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so11261424lje.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flbQh8QSyXP6BbnfTs+H8n25p/Mq0h+HNPEYy/tByz8=;
        b=P1Zwwo362VmJDYKc/k9YtY16SaVT5xekypy3icdc2I+0UiGXEYThp5IOObvGRn9wGc
         ye+kUfJYyByYGQlPZMM0S83TLuAaGcTsiI08JyqcfopJ0rPS7Z/MbAKvLuB31G2UWvem
         u1UrgeeITr+sexh6CkhTQxLOB0qKukBOVhnUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flbQh8QSyXP6BbnfTs+H8n25p/Mq0h+HNPEYy/tByz8=;
        b=O1lXcWHIn0r1gBcIPAF6IyYxkuuQIH6+Lz4WO1EF8ZOdAvBzXun1ZcbnAwjrfleZ+a
         GESEySVxQlgPEdyLk594v1RDMHdsuqV+xURA0KS/GnimqKxfKD7LVgtwcCcr3U4r6yRf
         TmiatA0CAx7myZjn028K590GvZLeIlMhX7CurZNQ273t/w7WDx/4vo/aby1lqFNsZVx6
         R9kf75SJwbBQPwenUgdSE+6l2EpPyRN2OqHIH6zMIBYadJ7vpp7P5aB3gSZaGKJVipkS
         2c8QC6rn4nLNsJf6VlK7RZmDENeC8bXaAGdGVVecf4QScUjhDePHbbcrbQ6r/FRCYkxo
         SPIQ==
X-Gm-Message-State: APjAAAWtGCVrcjlB07TNc3bIXgp9UYy05cmGCXvWAXkKh+aDP29OSRTM
        fKRCtK11Y2LMO2IQVHoMJGo7EVJVQ8c=
X-Google-Smtp-Source: APXvYqxjb9I+YE5LmFhb/ocMd0x17wTprfC8cmOAPWBlopQwdgHCVdPOWl4zSFjpMtlHNd+psk94iQ==
X-Received: by 2002:a2e:b045:: with SMTP id d5mr15922281ljl.105.1570385289806;
        Sun, 06 Oct 2019 11:08:09 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t6sm2599585ljd.102.2019.10.06.11.08.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 11:08:08 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id r2so7664953lfn.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 11:08:08 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr14586548lfp.134.1570385288311;
 Sun, 06 Oct 2019 11:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191005233227.GB25745@shell.armlinux.org.uk> <CAHk-=wiy9MWteoaoV15FJ7QJeRhBtCVgo6ECiLb4khuc5PxHUg@mail.gmail.com>
 <20191006130924.GC25745@shell.armlinux.org.uk>
In-Reply-To: <20191006130924.GC25745@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 11:07:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6jhO1X3VZuZ28aA4m0k6wGhkHRRrJSQpQ69N901D7Mw@mail.gmail.com>
Message-ID: <CAHk-=wh6jhO1X3VZuZ28aA4m0k6wGhkHRRrJSQpQ69N901D7Mw@mail.gmail.com>
Subject: Re: MAP_FIXED_NOREPLACE appears to break older i386 binaries
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 6:09 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> However, I think it _is_ worth highlighting that we seem to have broken
> binary compatibility with older i386 userspace with newer kernels.

Yes, we should get this fixed. But I continue to ask you to point to
the actual binaries for testing..

                Linus
