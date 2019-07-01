Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F0A27E01
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 15:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbfEWNX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 09:23:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42409 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWNX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:23:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so4375430lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 06:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48o4Y/Ltef1ARzeyN7TKfYWMGNJKSHFjsd19o0pyUOU=;
        b=SQ2dol8DC88GjsDbAUPAuFSeOoT5xVfX453fj9wUhtLxOrNEqQKQ8uoc3xDlQbyCpV
         h70NGYYDC0HIhejLpC1kIiGmHHkKH7INMmZpOi28OUfp2IaNMcIexWuUobDW7sqm8Yby
         2Se0Zmk1ruG90ivFN1nafrbIyI6HZa4jvXaIRoD3/vKAx7oxHKkb0FudxV+AgtbVUD1M
         vcsanElgvm+54MGXrGX4L9rQqNANzqAdhkS5gknNfVUWOl/957hrHgL8E3tapPavP0mQ
         fyesw4xU7Ixr6iRftS6IkCCDc0HPh8RqDLES0zR7yjIURYsrTPeG7p0TZY0Yyg7uqGjq
         Q+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48o4Y/Ltef1ARzeyN7TKfYWMGNJKSHFjsd19o0pyUOU=;
        b=KdsMowefggNc660ZpBXqELeJ3uCGX2RhZvjTTROZ5kouDIIi8gRkNikic6sd30GXSI
         oju3xhp3SRQlgK8qI/NSGFmh+rg90U9/x6TLnCR21iyGGvKk+QW8nWlARyZBSDOljb8S
         lzUEcPSKVzeD7pikSmcNU+plzoCJK6IFP5zEqkUPnIpqhgceXN1Os7EMCWkNCPatXeUc
         QHYXOtQMfA+dKncAGipwIyULKG399orKu+8jPIncQOsRaBQxA2/AP7lEsZnTkwXqlesP
         aTZ3MvTgaOfOPtM1yYX3R3IOcSKVRJGCylXv6rC/vv01vD09Rbu4l0f4mIHEglIeQKL3
         pQ3Q==
X-Gm-Message-State: APjAAAXm2ScBklPTsSNDYeUOjcO872GWMprYBdzONsyyPKAHCklWPVjZ
        YBJKV4nRvAyOkqsFAR+xPVsCkZUGTsZYQh3YuoYUjudj
X-Google-Smtp-Source: APXvYqx55jH4S8faPVvbT/I5MfBK/1z0pyX58VxDj0ZAi0VfVcfNPUKLQiWLhvqQQNZdc3DothpXWbh1zHK0K3jIuBY=
X-Received: by 2002:ac2:5612:: with SMTP id v18mr31538690lfd.15.1558617837866;
 Thu, 23 May 2019 06:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <1558366258-3808-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1558366258-3808-1-git-send-email-jrdr.linux@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 23 May 2019 15:23:46 +0200
Message-ID: <CANiq72nubJ6KHXROuDHV8Ap6MJQx6SDKUJCxYuN1_YDy=A_ELw@mail.gmail.com>
Subject: Re: [PATCH 2/2] auxdisplay/ht16k33.c: Convert to use vm_map_pages_zero()
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 5:26 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> While using mmap, the incorrect value of length and vm_pgoff are
> ignored and this driver go ahead with mapping fbdev.buffer
> to user vma.

Typos: values*, goes* (same for the other patch)

> Convert vm_insert_pages() to use vm_map_pages_zero(). We could later
> "fix" these drivers to behave according to the normal vm_pgoff
> offsetting simply by removing the _zero suffix on the function name
> and if that causes regressions, it gives us an easy way to revert.

Would it be possible to add a "Link:" to where these new functions are
discussed/used (maybe a lore.kernel.org link?)?

Thanks for the patch!

Cheers,
Miguel
