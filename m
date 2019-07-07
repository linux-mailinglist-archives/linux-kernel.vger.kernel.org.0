Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553A2617B1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2019 23:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfGGVR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 17:17:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34891 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfGGVR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 17:17:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id p197so9517301lfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 14:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khwRExgsrAxesDLfa+MBNv1Kv3bFqCQXDesV7F9LKao=;
        b=Ark+YhDSe2cjbYKXLWFRcC6Zg4N/GRkkzxT43m4iaIAuQN8NmmRJspuz1CcbY7cA3l
         kXIt4/Gaks4V/Ht5T9hR8BRUbU/TxYdtsEocgCSmUawCXES9+asmQ8/q7YB0i/U02/eW
         KOByO/j0JMeifjbX/2rrzc2QtpJKR98kzq/bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khwRExgsrAxesDLfa+MBNv1Kv3bFqCQXDesV7F9LKao=;
        b=OTfGMQjd9hfsdRk8sAZ/mNShQNKILBmug4Wv8Xcz8F/m0kUJN8Y+xjJ5LdSQyBqO6Z
         GvKdcYLpTbO1KAeIUr420CTxmUwF8O4GNd7jKcCLerHuw1+TNvIZL/nIxreh7m1EkEiW
         ba+eBaWbDRbQGnKTWGLVFCBJ0xbS+fhf91lG9rDxXcFNbrmVE3J4P1vLblrWZp+56yQg
         Rmdc5OIInAPQ2I1/Kj0/AbvIjXn5tji1d0z8GWfuVR8odAOfEwKFm/Zw0ndUwynyX3p3
         wq5WUAKuad+pZR8/gcjqB7femHs7uh0/+dBYKYqa/UaDgQ4dt2ogBk8lzU4tYsJjbMAN
         8/lg==
X-Gm-Message-State: APjAAAXkOVcyBio8ZQqPW13d7mWgkgaHRfNoeEDM+zPbOBkeT2HqNFVb
        mldth98sIRxbK1U5v+Fv6QML0i4QP7M=
X-Google-Smtp-Source: APXvYqz9gosT1hTeW6NyyfaMG7QLyT8ls762Lsmz2gckrCIS8G1kJ22+wyV2Xps7f7JrzwQTwTc1mg==
X-Received: by 2002:a19:6519:: with SMTP id z25mr6822795lfb.42.1562534275056;
        Sun, 07 Jul 2019 14:17:55 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id e13sm3214582ljg.102.2019.07.07.14.17.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 14:17:54 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id z15so9474337lfh.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 14:17:54 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr6182613lfb.29.1562534273929;
 Sun, 07 Jul 2019 14:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190706001612.GM17978@ZenIV.linux.org.uk> <20190706002236.26113-1-viro@ZenIV.linux.org.uk>
 <20190706002236.26113-4-viro@ZenIV.linux.org.uk>
In-Reply-To: <20190706002236.26113-4-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Jul 2019 14:17:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgB5NN=N9Z4Y26CTSr1EchMfXbuFvVU4rcKaNca9qVkiA@mail.gmail.com>
Message-ID: <CAHk-=wgB5NN=N9Z4Y26CTSr1EchMfXbuFvVU4rcKaNca9qVkiA@mail.gmail.com>
Subject: Re: [PATCH 4/6] make struct mountpoint bear the dentry reference to
 mountpoint, not struct mount
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 5:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
> +static LIST_HEAD(ex_mountpoints);

What protects the ex_mountpoints list?

It looks like it's the mount_lock, but why isn't that documented?

It sure isn't namespace_sem from the comment above.

                  Linus
