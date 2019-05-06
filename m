Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B24A156C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfEFX6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:58:45 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39667 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfEFX6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:58:45 -0400
Received: by mail-vs1-f67.google.com with SMTP id g127so9251002vsd.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 16:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mx65sXO1r4vrgQ2kHviuuHpS6yfDT9JxVfsYUs6Yhno=;
        b=XJNA4uFR67wlqSxbXVvJFANNEYgMlJH7KBPzpr3b7DMeji4eUc4UYf6iB8tdfjqLj2
         77oM72iVyJUyg5ERdVepbiioCfuJrdGT64WpTPel7XkYiuWgcVFuRGXKqFaYf/alwG8G
         nTnfmO7nurua4ICMHXTiKYOqKMonbeIU+6AIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mx65sXO1r4vrgQ2kHviuuHpS6yfDT9JxVfsYUs6Yhno=;
        b=gWHDKz84ZJa7/BGJg/zSGkyNPW56mkCIB81E93iE7fBxP/h7ixHR5GR02i8FDL6K1m
         a6HyEktWevcQ4diQsJmA1LkJIC6rmzsWmxXlXkddpINjLWu+tsQZkPitUy1QxATGvqk2
         nqyQ5bBOQX7ggN5FSC7idIOW386l4dCpO0MwHvVV2k8Z9X0vKC+qDhHvwJnxCUPLSElw
         /2q5z4WCECucbOXYB3xe9+4O8Gu6Ds0m6Cq3LWEuTZ6OgSmYk48XKun/n86ytqHJLyyE
         G9JpkdXRoLR3Ohor+Xor4YDZUUM9cC9kxSKuNXWa7QjwxCSSKbCb84HgToBuXMigJkws
         dRpA==
X-Gm-Message-State: APjAAAUm5InBTCuPhjEs6isx4htYMLkYYyI4g4wR42VMN+2rVCbFViqf
        QAF/S1utEjpMOhDqE2d6vMTRO1B9Zi4=
X-Google-Smtp-Source: APXvYqydYDTVYjl6p1jZTQmOu97kjpi8gcX9YfyxRUx7ivkMWj8hfduGJkuywgwag3sgo6ZycEuyxg==
X-Received: by 2002:a67:c508:: with SMTP id e8mr15890339vsk.230.1557187124096;
        Mon, 06 May 2019 16:58:44 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id g3sm1169499vkb.9.2019.05.06.16.58.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 16:58:43 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id z145so9265714vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 16:58:43 -0700 (PDT)
X-Received: by 2002:a67:af10:: with SMTP id v16mr9106628vsl.149.1557187122785;
 Mon, 06 May 2019 16:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190503174730.245762-1-dianders@chromium.org> <CAGXu5jL9cJ+8scZ+Cg9yqdc9+rb563xs-qVjXXuPRJYjNa4Y8w@mail.gmail.com>
In-Reply-To: <CAGXu5jL9cJ+8scZ+Cg9yqdc9+rb563xs-qVjXXuPRJYjNa4Y8w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 May 2019 16:58:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WcjfUwH62bHVELOmzViv7d329r6+HfPqAyXMjKCO7LeQ@mail.gmail.com>
Message-ID: <CAD=FV=WcjfUwH62bHVELOmzViv7d329r6+HfPqAyXMjKCO7LeQ@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Improve backward compatibility with older Chromebooks
To:     Kees Cook <keescook@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, Anton Vorontsov <anton@enomsg.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 6, 2019 at 2:10 PM Kees Cook <keescook@chromium.org> wrote:
>
> From: Douglas Anderson <dianders@chromium.org>
> Date: Fri, May 3, 2019 at 10:48 AM
> To: Kees Cook, Anton Vorontsov
> Cc: <linux-rockchip@lists.infradead.org>, <jwerner@chromium.org>,
> <groeck@chromium.org>, <mka@chromium.org>, <briannorris@chromium.org>,
> Douglas Anderson, Colin Cross, Tony Luck,
> <linux-kernel@vger.kernel.org>
>
> > When you try to run an upstream kernel on an old ARM-based Chromebook
> > you'll find that console-ramoops doesn't work.
> >
> > Old ARM-based Chromebooks, before <https://crrev.com/c/439792>
> > ("ramoops: support upstream {console,pmsg,ftrace}-size properties")
> > used to create a "ramoops" node at the top level that looked like:
> >
> > / {
> >   ramoops {
> >     compatible = "ramoops";
> >     reg = <...>;
> >     record-size = <...>;
> >     dump-oops;
> >   };
> > };
> >
> > ...and these Chromebooks assumed that the downstream kernel would make
> > console_size / pmsg_size match the record size.  The above ramoops
> > node was added by the firmware so it's not easy to make any changes.
> >
> > Let's match the expected behavior, but only for those using the old
> > backward-compatible way of working where ramoops is right under the
> > root node.
> >
> > NOTE: if there are some out-of-tree devices that had ramoops at the
> > top level, left everything but the record size as 0, and somehow
> > doesn't want this behavior, we can try to add more conditions here.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> I like this; thanks! Rob is this okay by you? I just want to
> double-check since it's part of the DT parsing logic.
>
> I'll pick it up and add a Cc: stable.

Hold off a second--I may need to send out a v2 but out of time for the
day.  I think I need a #include file to fix errors on x86:

> implicit declaration of function 'of_node_is_root' [-Werror,-Wimplicit-function-declaration

I'm unfortunately out of time for now, but I'll post a v2 within the next day.


-Doug
