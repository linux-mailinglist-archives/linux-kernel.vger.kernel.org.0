Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2910180F07
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 05:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgCKE4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 00:56:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:35278 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgCKE4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 00:56:05 -0400
Received: by mail-io1-f70.google.com with SMTP id w16so655552iot.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 21:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PTAmheRb83mqmqcQhDPjsi3Wza5HOxd3cp66btvqBKk=;
        b=o6joeCeIMfIkosRi5gcvFMOIEiGCUrdpapFT0dhrAYD2EqLMSNRbW4JT5Jz8980omt
         GiLrxgsBmBBY046Gm7BYG60fx80xIr9q156AFrft6xM/NNffHKNkl26f/schA6SBe0Eu
         6x/r9GShmn5/N5reXIiX92TqtBuxq6G4tkuTzHDBh4eR2vdOViNQDgmVr3u+ieWpQoSB
         ciTNYhgpxhBnbmnIJSGeDSZahx+oomgy0/D/4Mihc3ZEXzC94blsFU7fMvsoBWLqk+3r
         TL8RGRLZaWOBusGZYGiM/0WJvE2kAYysKVNLnlM3MoWlJ/j7GAj6Af9PxfEDhLikyIch
         dQjg==
X-Gm-Message-State: ANhLgQ3YsHnFvPuJB4CPC9/rehicfxBKfF0rMJUKA1Tys/nN8LzqVywZ
        a+BgafgV5eEHAP+jWT4s5EtX3I7n3lg/6Dz4UndzAIVURypb
X-Google-Smtp-Source: ADFU+vthrNPKofNyk0KpJ1HImRdkg+YaS9tEx7+ZHPT032pNO/bgZc3l3bt7nz1NMcRU810us7EbYn2aqUapzEc63cfz0gzFeD1t
MIME-Version: 1.0
X-Received: by 2002:a92:c802:: with SMTP id v2mr218215iln.277.1583902562672;
 Tue, 10 Mar 2020 21:56:02 -0700 (PDT)
Date:   Tue, 10 Mar 2020 21:56:02 -0700
In-Reply-To: <CAM_iQpVrasivmeLHfxFpBcTxYr+Er-KCOrdSR0L4Bd7DuzxHhw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b65a605a08d0da7@google.com>
Subject: Re: KASAN: slab-out-of-bounds Write in tcindex_set_parms
From:   syzbot <syzbot+c72da7b9ed57cde6fca2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+c72da7b9ed57cde6fca2@syzkaller.appspotmail.com

Tested on:

commit:         2c19e526 net_sched: hold rtnl lock for tcindex_partial_des..
git tree:       https://github.com/congwang/linux.git tcindex
kernel config:  https://syzkaller.appspot.com/x/.config?x=bcbe864577669742
dashboard link: https://syzkaller.appspot.com/bug?extid=c72da7b9ed57cde6fca2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
