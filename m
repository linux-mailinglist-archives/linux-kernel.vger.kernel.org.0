Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 872AF67649
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 23:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfGLVns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 17:43:48 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:38817 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfGLVns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 17:43:48 -0400
Received: by mail-lj1-f173.google.com with SMTP id r9so10690741ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 14:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0JPNBjy0Yc6LLkdQ0eiD52O/8DhkWO5WHr1WctPWWk=;
        b=QLa8o/lPUC+CR4D/UB0YRqjYP7B7c70w9Z6IMNK7ev0DajWNbbFtz3Z2i3IQmtecfI
         IpSiwpXkemsclCGOkRqgU4tASHl7xoCJPriP85aNhM0Ko8QlxMYS9TueqpS5lZPAfZcS
         hBycmnXSE/b1eQwLERMz9Yr8UBf0KFAB+XO6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0JPNBjy0Yc6LLkdQ0eiD52O/8DhkWO5WHr1WctPWWk=;
        b=DijgIXASs4iNWRADST16LTXD5+vqWIc2iCuRyuCpbT0IFWjI0VjdBzDhGFPeWlwU+v
         X5+z5sYI8LiYbQrPXcpUDR6XhLdk5rJtl4pcjlNhhZlVhLdPUUgUjrZPPbaGYzMAwM3D
         ryDk3ML6wvwSeF8Wgy1vY3Fxt8NAlRKP/aJ0XgU71JxRz6gFldVwII6z+dkbzm3OIEBf
         8Pnr9R+5EdQZqJAtOulO31kf9E107F2jN45hNSSDPXSvoGqfT+Zg917KbsUHcBK+92bm
         6laErQQOa+tV43akBuYf9nQHnEMAthCo035r+oeORx9dP+u+iGzh0kYYi+ssZBorbEMc
         7hXw==
X-Gm-Message-State: APjAAAWGEtyJ2gyyJqqa/I3VoreVEvR4T9Drs+k+kbK9tgS6WHJ5KYMs
        x4krvY/bJ46J8K+ksgVjcI4CXwAVANs=
X-Google-Smtp-Source: APXvYqzzeqKq9lZuKVQAqNznfg+hQxWWY7Xv0cqOVYeR52XA3YW0ZNZD/lubjQSWYaR3eggKypZmcg==
X-Received: by 2002:a2e:8007:: with SMTP id j7mr7131155ljg.191.1562967825669;
        Fri, 12 Jul 2019 14:43:45 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id j90sm1642883ljb.29.2019.07.12.14.43.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 14:43:44 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id p197so7380264lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 14:43:44 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr5791021lft.79.1562967824388;
 Fri, 12 Jul 2019 14:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190712073623.GA16253@kroah.com> <20190712074023.GD16253@kroah.com>
 <20190712210922.GA102096@archlinux-threadripper> <CAHk-=wh0XHkcLYh+pMPJrf8WmD6zOgXfq7HuLi7gmzb8aPEOvQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh0XHkcLYh+pMPJrf8WmD6zOgXfq7HuLi7gmzb8aPEOvQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jul 2019 14:43:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimmESHGRKNnZV0TfNStqNrruxzXaT_S=8g6K4G84p54w@mail.gmail.com>
Message-ID: <CAHk-=wimmESHGRKNnZV0TfNStqNrruxzXaT_S=8g6K4G84p54w@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core patches for 5.3-rc1
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 2:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> My bad. Will apply the fix properly.

Ok, _now_ your fix is finally in my tree. D'oh.

              Linus
