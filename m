Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AFF58D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 00:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfF0WDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 18:03:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:52289 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfF0WDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:03:02 -0400
Received: by mail-io1-f70.google.com with SMTP id p12so4166938iog.19
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 15:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ftXeLrFZZFESNRMG9Zi6qnjHWuUjXK+iJ0nKj08mux0=;
        b=pHh66GvdFKeXTk9Rhm0BYfWB2/HXdSrFdsL6HthX7+HFVdks1p1aapXuYK5aomHGYF
         +UxuUl9YL6fohD4cxtKArXnr1l+rW+RTkAZM6FYoMjyAIwtY0cM78KnHoY03jsWCQdG8
         2nlkLFtSLcWJXVXovDYxddzvWqk+1vmFDovQuU8sxzp+DDcnAjRDRrkKvMCIEMpj5PJH
         Gc3ejB8llt7qC76ejJtBJmVZcvi2R5A8aZSuT06pHNmWcQmhaSIxGw7RTUVsXqXEuqcA
         q8ThiSQ6SYoYM3JK4nDWb/ql02MHYmM9QABlXw5g8B13AqA41HMwZmDqxt0xGsLjDSnK
         k5tQ==
X-Gm-Message-State: APjAAAUZuKhQ9tqtYCVMbvwHqQ5u/8VHakQqIqbEGIpmkfYVXlidae8R
        MQ+dC+l4gm3lYqjp9BdKTotlF16rNpDZpy1UHFUfOUU5WnEF
X-Google-Smtp-Source: APXvYqzxGLlwyJHq8vnWF+ACNrGzCFg7Cxze7BBZgd9K0BKAHW1DJUgTAl1u9qWi6ip4+jbkz/j6zvv001Fbtj1t1V/V83PdYYtW
MIME-Version: 1.0
X-Received: by 2002:a6b:3c0a:: with SMTP id k10mr2900377iob.271.1561672981420;
 Thu, 27 Jun 2019 15:03:01 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:03:01 -0700
In-Reply-To: <0000000000005aedf1058c1bf7e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050221b058c555345@google.com>
Subject: Re: WARNING in mark_lock
From:   syzbot <syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        dvyukov@google.com, ebiggers@kernel.org, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Sat Jun 30 13:17:47 2018 +0000

     bpf: sockhash fix omitted bucket lock in sock_close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1436e7e9a00000
start commit:   dc636f5d Add linux-next specific files for 20190620
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1636e7e9a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1236e7e9a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99c104b0092a557b
dashboard link: https://syzkaller.appspot.com/bug?extid=a861f52659ae2596492b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110b24f6a00000

Reported-by: syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
