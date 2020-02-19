Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A22F2164EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 20:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgBST0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 14:26:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44287 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgBST0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:26:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so1561482ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fTub4GYfjONmIT82CPg1N7dCoXEnM2Sw2O8KqYucXw=;
        b=TTXA143+I9mRmEBx9/1NhLISHKMsH6waUZcmcpT1BguCNEKTR0hF7JmV5HoBZEGz3o
         db9fi0sUaay+pAz0CQoHWY2cCDHTPEMKkMTVnGzY174vOn3S+TeHtv27+wikNuljtZEX
         gzePqVGy4l+pJiMwf4qLcoz9ecA3N8Y267gYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fTub4GYfjONmIT82CPg1N7dCoXEnM2Sw2O8KqYucXw=;
        b=FmuiYAGA94qjF5EQYlEKv7UGPO6LVq46wvemwK5SzCL7oZtXzCCOLgpV/CruDhBkL6
         367tNsIqtFiu/1GBNemfSDAUcr8BHUBXjY4YJhqf6MbRyHM+yN5kIV4CNfO4ONHSM2LX
         Q5gfknZS6TG/17Ij1s8iUnbqIg86rP/4Pf/DqLYiitJAliTCqAx/K3jG/G/+o5wC/f6w
         e8pPbgyZkynfxI6bebgYsafrdd5X9wb6mELR269HnB9jXD6rfwAgaeTDxFEDEYzMAfTZ
         kb8Mh06EkSYxb1hfJ+DSDuWexN8vFCktC4Q9mHnDEfbQj9zv4hRcjjHv08a1JlCkalg3
         3V7g==
X-Gm-Message-State: APjAAAXSilKCimHO83LFZDgPIzfVnAq0taF/RSATf2TUdGoB7KEM5qku
        SWdXKXJdfKYkwrPL0qwXHVyZOnTcuw0=
X-Google-Smtp-Source: APXvYqz5YuqJg/QzVV1QQ0vyalE2q9QJkKMO90c9/0aCbF9Gc8f1TpsRxwK2+nM0cRA/0+99X5v98Q==
X-Received: by 2002:a2e:a0d0:: with SMTP id f16mr16586450ljm.130.1582140395809;
        Wed, 19 Feb 2020 11:26:35 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v13sm293486lfq.69.2020.02.19.11.26.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 11:26:35 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id n18so1578261ljo.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:26:34 -0800 (PST)
X-Received: by 2002:a2e:909a:: with SMTP id l26mr16050682ljg.209.1582140394436;
 Wed, 19 Feb 2020 11:26:34 -0800 (PST)
MIME-Version: 1.0
References: <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk>
 <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com>
 <227117.1582124888@warthog.procyon.org.uk> <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com>
 <241568.1582134931@warthog.procyon.org.uk> <CAHk-=wi=UbOwm8PMQUB1xaXRWEhhoVFdsKDSz=bX++rMQOUj0w@mail.gmail.com>
 <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com>
In-Reply-To: <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Feb 2020 11:26:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whE0uzJy1C5z-GB-s7YioW_yhiEaes4cNa6tLJwyx19gA@mail.gmail.com>
Message-ID: <CAHk-=whE0uzJy1C5z-GB-s7YioW_yhiEaes4cNa6tLJwyx19gA@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: syscalls: Add create_automount() and remove_automount()
To:     David Howells <dhowells@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>, coda@cs.cmu.edu,
        linux-afs@lists.infradead.org, CIFS <linux-cifs@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 11:07 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Actually, since this is apparently a different filetype, the _logical_
> thing to do is to use "mknod()".

Btw, don't get me wrong. I realize that you want to send other
information too in order to fill in all the metadata for what the
mountpoint then _does_.

So the "mknod()" thing would be just to create a local placeholder
(and an exclusive name) on the client - and then you do the ioctl on
that (or whatever) that sends over the metadata to the server along
with the name.

Think of it as a way to get a place to hook into things, and a (local
only) reservation for the name.

               Linus
