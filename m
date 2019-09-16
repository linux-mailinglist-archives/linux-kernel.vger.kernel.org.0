Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0100B33BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 05:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfIPDbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 23:31:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34114 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfIPDbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 23:31:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id r22so14930981lfm.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 20:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fabntbPdTHBLY+J8GfOMAsjCxQ98iy3fvtylDOTNtXY=;
        b=Rb7ndPRvbfKdFFSW7cp++vq1VHLPlokFSVp6Zh7QLtyhVbwCBEx8Psy7stGdetXSto
         hxKA0uoLhVq+46CqKsFhgvJDUuHcQrcmaa8RyM4+9k0D1SHM3VJxKW8jGMfrDA0XIVTc
         6v1yUfy1cZjQdxtKTGusEupfiPawMV3IOSOvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fabntbPdTHBLY+J8GfOMAsjCxQ98iy3fvtylDOTNtXY=;
        b=ev1Gl38/HumTRBLTP2myra/rxoOWUtAQfdlItOoVtT527SES/dPo1X6daeLoRRweuL
         k+pEJpdggRQCRLe8oFM66wBcyXvXXPWAC4dq/Bcy2EJPylXtfp/ZVpZHYpAniMrLCbIS
         SdJC0i4r00el9HPpm80EmEJfv9DctqlDNc46Cn5tmmrnMVP7+NqKgg878igdXkXe9g1d
         f5/1mFTYfVuqLvI5XLk3OK+TQyQCOlsrLvomQE2WBSl5GJgvNHHJuC1pBAxCJppb+ILk
         sU4+pep3MWpgIvOMh59hFDCmgcTp6dRYMGZxkGqTOvXpWKPTo63HuauAuTFjUWT0vTA2
         kxLw==
X-Gm-Message-State: APjAAAU3PYeAHi8esSZcFnykbtBsm0FsBKpMBqOeYpSgF3YnLNkBCUQD
        cwHebr/kzXxjvZby7PKbX+Cn4sm8kq8=
X-Google-Smtp-Source: APXvYqwVNkjoOhj9HO8U2W5lchW9w9QLnG9/VqRUYw1J874B6VegfDahRhDtz0vBSpP4wl3oyTrG3A==
X-Received: by 2002:a19:c6d5:: with SMTP id w204mr35751551lff.53.1568604707983;
        Sun, 15 Sep 2019 20:31:47 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id d6sm2959548lfa.50.2019.09.15.20.31.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 20:31:45 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id t8so26182506lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 20:31:45 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr11957567lfn.52.1568604704963;
 Sun, 15 Sep 2019 20:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login> <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc>
In-Reply-To: <20190916014050.GA7002@darwi-home-pc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 20:31:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzFdN3hg0H56qYQfXVbV2pXo=uAVXoFF+KOsQguqgfMg@mail.gmail.com>
Message-ID: <CAHk-=whzFdN3hg0H56qYQfXVbV2pXo=uAVXoFF+KOsQguqgfMg@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 6:41 PM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
>
> Yes, the systemd-random-seed(8) process blocks, but this is an
> isolated process, and it's only there as a synchronization point and
> to load/restore random seeds from disk across reboots.
>
> What blocked the system boot was GDM/gnome-session implicitly calling
> getrandom() for the Xorg MIT cookie.

Aahh. I saw that email, but then in the discussion the systemd case
always ended up coming up first, and I never made the connection.

What a complete crock that silly MIT random cookie is, and what a sad
sad reason for blocking.

              Linus
