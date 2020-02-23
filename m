Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60B501694A2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 03:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgBWCb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 21:31:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39563 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgBWCbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:31:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id o15so6246747ljg.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lv+/zskqFVdIq9wYZU4Gj6+TZNyU98SMKPYNicpHw4g=;
        b=PdzKp2iGm64BKP+6/6oZhsfTC0LquC9kExy0BphI8KeK0rEElaWmw6ds7noalV8Q5V
         0+UHb2/Y5DN+HwP48Fr362DHpaGN35gYNg1QtVPfHYYSgcKmgPYEJSUsLdwOezgHJwYm
         rbzVeBYbSzQqV+vTo3/JMPpkQRk/AZOMYdEOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lv+/zskqFVdIq9wYZU4Gj6+TZNyU98SMKPYNicpHw4g=;
        b=DJiC59Cg/JFb+Naa0SqLfjItVOHUm5e/gswxuDArBAYbIElLgutiHyBBlUNruWJT0y
         EvykUK1TzBueHJMN39s2gHTreUdhfTN0QjsOo8dMy3wgqjOxfPX1yUm4YmGEamWB78Fl
         I+nNnWuWt/YL15JrSIJN5nQwcp7ogBCMGuGwWi/A4Vm4DmBvuDDVEOIzxkqme/MyOcfR
         RjoYPONCr7NNxZOUFbQi+gqRo4RhHVvxK8MNK8Smxl2aEhqJ4d6ERRuk0iLZOQ+rM/4n
         KxOzhIJy3P3eQ+QpP/QDEBp3zX7SZu64NEFUxJujeDhKVssByfajbBhgBVWHOrVqz0La
         E91w==
X-Gm-Message-State: APjAAAU4f4fqGwpJhaemOvlV7GFL6+ulcUmDVdh8+H5NAAwDD3OUqSGj
        b6P6tOI5Vgl3P56fpQAd68GVlWB07rM=
X-Google-Smtp-Source: APXvYqyMhKXyju48sEcW/OnMED9K3kUbI5hcBxisniCu0SGaiwg3JKnAQGW0g5KAh6nMbLWrnDHApQ==
X-Received: by 2002:a2e:80d1:: with SMTP id r17mr26809836ljg.292.1582425106954;
        Sat, 22 Feb 2020 18:31:46 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id b1sm4709993ljp.72.2020.02.22.18.31.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 18:31:46 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id z5so4286997lfd.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:31:45 -0800 (PST)
X-Received: by 2002:ac2:490e:: with SMTP id n14mr9091492lfi.142.1582425105432;
 Sat, 22 Feb 2020 18:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-24-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200223011626.4103706-24-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Feb 2020 18:31:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJaHi2wzcJ8KBEtm3r_a2OVXHEvPnXMb_WCqA1cU3eGg@mail.gmail.com>
Message-ID: <CAHk-=wiJaHi2wzcJ8KBEtm3r_a2OVXHEvPnXMb_WCqA1cU3eGg@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 24/34] finally fold get_link() into pick_link()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 5:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> kill nd->link_inode, while we are at it

I like that part, but that pick_link() function is now the function from hell.

It's now something like a hundred lines of fairly dense code, isn't it?

Oh well. Maybe it's easier to follow since it's straight-line. So this
is more of an observation than a complaint.

             Linus
