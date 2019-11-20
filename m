Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02F31044D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 21:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKTURV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 15:17:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33243 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfKTURV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:17:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay6so324019plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:user-agent:date;
        bh=pEcboEGWgRcR/lCzkZsNrTAeSBzrBEcSRW5Q19SXbMI=;
        b=EQ65JBR8bkeY9w4g/Uc09Y4QqY5RWsrMSpC5TXkqOYfEwzwY+zBJfbxvIxys0nqjFy
         02qA8zcrbdxss7Z6s0fO8IYZ5yywKee2UPfYlgGwEbt1owwZNYuTR8739myDYq87p60K
         ThgCbPjw2lXpTi7Q3s24f+XS315ywP8gZaqHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to
         :user-agent:date;
        bh=pEcboEGWgRcR/lCzkZsNrTAeSBzrBEcSRW5Q19SXbMI=;
        b=O3nN+h3BTM+uqqsgxis7W0I4yQWCqH4ywFXNIu2cs0n11GFxL3myl7YUIsE4dbD6WP
         zqZbei8F8PmoPOJ5Bg+GUqPQOSnziQsKkYbEIZXiOHoh5Voqfti5Zp1WfFyA4Q1QnYTb
         WwwvS9xVMEtS7/sVfjlLi5mFqJ09aoDkg9dPzKAJhx4JbG8r8L+8FgtX8JJyXx524YZZ
         NNOLXLepprcopVo4Yo8T8GTUXsQd8odPsfeWimWHCOgFUbyAfs5PGFkVVHXvVPsApJpw
         JLxag0kOGG1nNzrAPsSaRut1WKK64wmiuo2/rBUUi1itf6mcjzdUuocmowGnxPsvBvOb
         koSA==
X-Gm-Message-State: APjAAAXIzOkod8LQIJs5HGhfrdEV+ghFkC50Ef4QoSEuuCrzrJ/Rqsu9
        AA7pHNQ78FYJVqWZHbaKRkkAiA==
X-Google-Smtp-Source: APXvYqzpSqQYefyJ3ZiEe7Zp8CiqqyaHPThJUtrwF7mFi9vdQx6QxD53EHr8zOke3ntXqED5vcNQhw==
X-Received: by 2002:a17:902:b481:: with SMTP id y1mr4627808plr.76.1574281040440;
        Wed, 20 Nov 2019 12:17:20 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s15sm89632pgc.3.2019.11.20.12.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 12:17:19 -0800 (PST)
Message-ID: <5dd59f4f.1c69fb81.17c48.0540@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1574247349.14298.30.camel@suse.com>
References: <000000000000cdaa560596acbc4e@google.com> <5dcee59a.1c69fb81.188d.e4b9@mx.google.com> <1574247349.14298.30.camel@suse.com>
Subject: Re: INFO: task hung in chaoskey_disconnect
From:   Stephen Boyd <swboyd@chromium.org>
To:     Oliver Neukum <oneukum@suse.com>, alexandre.belloni@bootlin.com,
        andreyknvl@google.com, arnd@arndb.de, b.zolnierkie@samsung.com,
        gregkh@linuxfoundation.org, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, lvivier@redhat.com,
        mchehab+samsung@kernel.org, mpm@selenic.com,
        syzbot <syzbot+f41c4f7c6d8b0b778780@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
User-Agent: alot/0.8.1
Date:   Wed, 20 Nov 2019 12:17:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Oliver Neukum (2019-11-20 02:55:49)
> Am Freitag, den 15.11.2019, 09:51 -0800 schrieb Stephen Boyd:
> > Quoting syzbot (2019-11-06 04:32:09)
> > > Hello,
> > >=20
> > > syzbot found the following crash on:
> > >=20
> > > HEAD commit:    b1aa9d83 usb: raw: add raw-gadget interface
> > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16ae2adce=
00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D79de80330=
003b5f7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Df41c4f7c6d8=
b0b778780
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1024815=
8e00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16afbf7ce=
00000
> > >=20
> > > IMPORTANT: if you fix the bug, please add the following tag to the co=
mmit:
> > > Reported-by: syzbot+f41c4f7c6d8b0b778780@syzkaller.appspotmail.com
> >=20
> > I suspect this is because of the kthread getting stuck problem reported
> > by Maciej. Maybe try the commit that Herbert picked up.
>=20
> Do you have a commit ID so we can test an exported patch?
>=20

I sent the patch in. See https://lkml.kernel.org/r/00000000000019acd8059770=
942b@google.com
for what happened. It didn't make a difference. I'll have to stare at it
a little more to figure out what's going on.

