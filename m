Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C19116538
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 04:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLIDKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 22:10:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45815 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfLIDKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 22:10:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id d20so13816387ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 19:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsO7dZNBIbPprBYyThs91AYRzpngSHQwAmXmPwKBIg0=;
        b=MEH4ND4Nbsa4gl4HUUT5shBi2298BFMiOLZ4+lFC2yve4Ysbypny+1LndDWz1cqNTn
         4oOqiljoOg+6px1pt4OX19oYw3KLSxMURevpnBdU9w0Twjw/NymP62DqGoJk504Xl2N3
         6N3ACDfBvVDPRNdQ8p5o0tC5Mtx69DXAZkVXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsO7dZNBIbPprBYyThs91AYRzpngSHQwAmXmPwKBIg0=;
        b=Dpmoa2EXbizENnicoVHo3VwzQKiJYVpK4q0BfrVUJwOxyoxgnyWfsWFB/fOBS5+KUM
         xIWK1rEMAfA/RoJBx8H2HLi6jk2YbeNEhlWYY/UvQlOMtSQSjhpqjPOT9XWt2PnQzDbO
         61toqTCzniVoD1oSc47BdZxGZ4NZYTfj0+98p8fIGXpzME931Bn3XAypMz9qF3P9+5Hz
         oLH5kG6rVe8lzZd/crjJDWYcRjQi3rk5kqZnqe3F7ht+fX4nyVvrWqtPxecMfdV6BH8i
         QdpkzceembNBkDxScJHqqulqrQ0lUucrH2vPrK914vgDleYoq+D8hzL3R6EEu+BUgx4E
         6KJw==
X-Gm-Message-State: APjAAAUrU59IGXZ62k8KIzzryWSuUBZXrhZvyJWYG6VKQhWGpwlkKUF2
        bipcIvi24aH3FJJ1z7F8je9lttJN3HI=
X-Google-Smtp-Source: APXvYqzWknV0OGXuIjzd758A9iu76vrEO7rHBAJkmJV6lGQqgAyHCuibYvw36i8HYXGQ9ifRuwwxVA==
X-Received: by 2002:a2e:9008:: with SMTP id h8mr15728064ljg.217.1575861041087;
        Sun, 08 Dec 2019 19:10:41 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id h7sm10068760lfj.29.2019.12.08.19.10.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 19:10:40 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id c19so13802561lji.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 19:10:40 -0800 (PST)
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr15611418ljj.1.1575861039824;
 Sun, 08 Dec 2019 19:10:39 -0800 (PST)
MIME-Version: 1.0
References: <30808b0b-367a-266a-7ef4-de69c08e1319@internode.on.net>
 <09396dca-3643-9a4b-070a-e7db2a07235e@internode.on.net> <CAHk-=wjj8SQx4YzS8yw7ZJJKiVLBY0g=d8rCSyPCM=8Pzmz+Zg@mail.gmail.com>
 <20191209025209.GA4203@ZenIV.linux.org.uk>
In-Reply-To: <20191209025209.GA4203@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Dec 2019 19:10:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=whY0GL-FpnjUmc7fjDqz-yRJ=QBO7LT6aEzt-_raAb1bw@mail.gmail.com>
Message-ID: <CAHk-=whY0GL-FpnjUmc7fjDqz-yRJ=QBO7LT6aEzt-_raAb1bw@mail.gmail.com>
Subject: Re: refcount_t: underflow; use-after-free with CIFS umount after
 scsi-misc commit ef2cc88e2a205b8a11a19e78db63a70d3728cdf5
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arthur Marsh <arthur.marsh@internode.on.net>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 8, 2019 at 6:52 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, the thing that is IME absolutely incompatible with bisection
> is CONFIG_GCC_PLUGIN_RANDSTRUCT.  It can affect frequencies badly
> enough, even in the cases when the bug isn't directly dependent
> upon that thing.

It will easily affect timing in major ways, yes.

You're right that at least the CI bots might want to disable it for
bisecting. Or force a particular seed for RANDSTRUCT - I seem to
recall that there was some way to make it be at least repeatable for
any particular structure.

         Linus
