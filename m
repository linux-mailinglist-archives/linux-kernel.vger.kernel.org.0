Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F9176F73
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 19:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfGZRER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 13:04:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44092 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfGZREQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:04:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so20559051lfm.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 10:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYUogFR8kEbFowTysdWEudek6vyek65cQY5j1T7RbCc=;
        b=aBmcxAZIZKbmB3gU/XL8HnaiU0nUGovN8KNuWe22nxhFAQUJiMoe3N7zB7fDmncxeY
         YmVRTk+FnFWhhs9fNDW5MdGYIwZyxQpEqz8z2Kz7uubrTi7FNWVasJirzZpyCmObojRt
         IflwgjQWZozlYefFSsQvLeSeaqtgNaJOjl0Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYUogFR8kEbFowTysdWEudek6vyek65cQY5j1T7RbCc=;
        b=nVuRFK+VK1p1TgsL2IouYn5B0Cr7wkJt/ubT6+1OKfbPalrvR5mJwgewBOiPzHtOh2
         0KN3c4AT7drgWzyM+u4HeAdzOxUzUY2KRZrv3DSRck5RNDiqEUbfkc5+GB7b6rPvSZYM
         fL3qCz/Oyd2DjL/7ZRnD02T8vI92gE4SzjmqobxVKDliOf2m2uOhfh57xHfXO6naa80U
         A5lfqhaqocv2MqQDkFZDNtiaXqMmNA/8SUvVzAZQ7GgcbLZbp/PnTl3fY3dbBAErqJXX
         G1jdt5o+xwAKRyA3KE44DcyksVzq0a5ButpO5W2nqpGlUz3p8nWkCJ74jGb8imsFKUz8
         2bTw==
X-Gm-Message-State: APjAAAXSAfYQZT5x6ZCQ5aE4P3ksB0yDYAo7ude6/r7sai6zLa9w53kE
        9e0iU40lnMs8y7pkb/7tc0LybYy55+o=
X-Google-Smtp-Source: APXvYqy80Ddhlqhy6NO7eXKl0tgw1GGu29RrXwixLIwVzdeIwIleJkDNgPlsjpChBYqaXhszejRe7w==
X-Received: by 2002:a19:7401:: with SMTP id v1mr44221891lfe.155.1564160654379;
        Fri, 26 Jul 2019 10:04:14 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id o17sm10302585ljg.71.2019.07.26.10.04.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 10:04:13 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id q26so37579553lfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 10:04:13 -0700 (PDT)
X-Received: by 2002:ac2:5601:: with SMTP id v1mr4219260lfd.106.1564160652942;
 Fri, 26 Jul 2019 10:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190725184905.GA28374@char.us.oracle.com>
In-Reply-To: <20190725184905.GA28374@char.us.oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Jul 2019 10:03:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=widq5p7A8X4Jo2fnfL7cAxiLczu3uoJcyZd5tgH=Hc7aA@mail.gmail.com>
Message-ID: <CAHk-=widq5p7A8X4Jo2fnfL7cAxiLczu3uoJcyZd5tgH=Hc7aA@mail.gmail.com>
Subject: Re: [GIT PULL] (swiotlb) for-linus-5.3
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:47 AM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> Please git pull the following branch:
>
> git push gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/konrad/swiotlb.git for/linus-5.3

Please use a proper pull-request.

Not only isn't the above a kosher pull request, probably *because* you
didn't use git pull-request you also never got a notification that the
above branch or tag doesn't actually exist.

Also, the prior swiotlb pull request you mention that contained three
of the fixes here was already pulled a week ago and was part of rc1,
and you should have seen that in the public tree. What's up?

            Linus
