Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9942E1156A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 18:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLFRmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 12:42:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40068 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfLFRmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:42:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id s22so8516589ljs.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 09:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=WqxsPeJTqe0UTYzVZZORXptVNgtf0JJE2rfn+zKoxE0=;
        b=HEM5YKK+f18dJOv7O5XyTyH6kcLpLZWCy5ByaSBms4vRNoJHfyQhYai33MpmgjQAKw
         e4HTdH9FU+7ZhhfH22g2T+NlIXmxO5BdoiJwiHAnY61oeF00SA8vEvO13akaHSJi9pxQ
         r+BNkk83o/o+SYg4tAqP373X9EHeHt02SZ7pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=WqxsPeJTqe0UTYzVZZORXptVNgtf0JJE2rfn+zKoxE0=;
        b=Oid/j6T8APCYtjiFH+yxLaJDxqBusFEvbkinH1CbRdG113XYCzmYnYlsgEaFVXnZmU
         sZkvOgXrECu73xH5fhP1TyQIK1DWGXvAtBb4GVhaG4SAGb5NRaB9PFy09Vaj28AsDMjI
         8Xjo6GKNbkv/EcPOaAHwtVvuxrY82oVrA86DRBqAMBHw8gHFvIMjlEPhbcsZZFcFEYiO
         KOnF5zSPe777maDHUheZ8FTuNI1I3CCcewPaLfzDge+93ucxCQxvfWhRmhg2wgO722Xb
         mKnl/sRVxZXQUsTyxHEuQVp+Mea85XeQBK8btuZLwd9KOfvMFi39JXJRs6oDZN9fI/dp
         u5Sg==
X-Gm-Message-State: APjAAAV3RDaddcQNjBrHdn0gZvWEFKy57oca5mpRNCaJ8O0An46sydfS
        mYjKELwkAAf87K4VOPJh+AmIFeN9o7I=
X-Google-Smtp-Source: APXvYqzOhwpYWofyBEpLQPVQrsqcBn5OJ5qxjJyGhacsJlsIEuhf5WcMfgy5MxqqO9/lfQmkExeVKg==
X-Received: by 2002:a2e:864f:: with SMTP id i15mr9055703ljj.29.1575654139073;
        Fri, 06 Dec 2019 09:42:19 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id m10sm7076841lfa.46.2019.12.06.09.42.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 09:42:18 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id e28so8492917ljo.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 09:42:17 -0800 (PST)
X-Received: by 2002:a2e:9041:: with SMTP id n1mr9575560ljg.133.1575654137423;
 Fri, 06 Dec 2019 09:42:17 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
In-Reply-To: <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 09:42:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wga+oXMeMjftCKGT=BA=B2Ucfwx18C5eV-DcPwOAJ18Fg@mail.gmail.com>
Message-ID: <CAHk-=wga+oXMeMjftCKGT=BA=B2Ucfwx18C5eV-DcPwOAJ18Fg@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 9:09 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Does the btrfs test that fails actually require a btrfs filesystem?

Nope.

DavidH, you can do this:

   git clone git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
   cd btrfs-progs
   ./autogen.sh
   make

and it looks like that

   make TEST=016\* test-misc

should work - all you need is btrfs and loop built as modules.

               Linus
