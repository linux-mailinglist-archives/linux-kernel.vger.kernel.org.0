Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9228010AB45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 08:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfK0HpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 02:45:01 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:46477 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfK0HpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 02:45:01 -0500
Received: by mail-io1-f69.google.com with SMTP id b186so2662974iof.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 23:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YRVZo6hNi7keHgsRUhwNxFT/wNgVW78g53M8zInUS00=;
        b=G3+9LYyI0L82zPNaCpX7Pia4/fvYXdwnGvKiaGXb9xMUx09301KGewqidnpOcPlmTs
         7lriSF1Mgwo6HuYDGWyQkTXWsKKDjZqHtAMtuKtd6ETYsBSRzcO2Z0ACg+Z+P8bS8jtJ
         oFRzPvNAIBEgftVYYnf7qhooxsjrb7UrKdtvTDSvxz+kG3siaK7t2xMTDPX/VgquwnU0
         CNLN7RtNaA7YhE/0MZsUged/YzDPR35P7KIEj+qxoddvc8AVbKsEIDmhV2WvLuTLmUx3
         WuZgQf43dp/w2Aixeh3pbiSGbfsMi/lMdaBZodZGm6OGLUAX4MEOPV+aYikaTXqw6r3a
         SsHg==
X-Gm-Message-State: APjAAAXtXnZixMlXs1QbCs38SIg6ScaPrXJm+uodIQoYd+DGNvMXdy9/
        Ulx1Jt4c2WEnn/dnpWBeKDAbfyltPTvnwWbMFXVI5Z/oMECz
X-Google-Smtp-Source: APXvYqxYJS0yXjGWxfF4TAH6sMJkenvzlZJMjdc+2mWHUf8AMRtwUGVMsZ9Z0a//OKYOxpMLZNeVK3k1A+KtoOXLOoIuGb6zNLcu
MIME-Version: 1.0
X-Received: by 2002:a92:50c:: with SMTP id q12mr43328163ile.234.1574840700355;
 Tue, 26 Nov 2019 23:45:00 -0800 (PST)
Date:   Tue, 26 Nov 2019 23:45:00 -0800
In-Reply-To: <201911262053.C6317530@keescook>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085ce5905984f2c8b@google.com>
Subject: Re: WARNING in generic_make_request_checks
From:   syzbot <syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com>
To:     00moses.alexander00@gmail.com, axboe@kernel.dk, bvanassche@acm.org,
        hare@suse.com, hch@lst.de, idryomov@gmail.com,
        joseph.qi@linux.alibaba.com, jthumshirn@suse.de,
        keescook@chromium.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        sagi@grimberg.me, snitzer@redhat.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org, wgh@torlan.ru, zkabelac@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com

Tested on:

commit:         8b2ded1c block: don't warn when doing fsync on read-only d..
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d727e10a28207217
dashboard link: https://syzkaller.appspot.com/bug?extid=21cfe1f803e0e158acf1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
