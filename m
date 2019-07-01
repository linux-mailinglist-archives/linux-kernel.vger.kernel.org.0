Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A33B5BEA5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 16:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfGAOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 10:48:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35424 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbfGAOs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:48:58 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so29471958ioo.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6YcGWfOU8rFsr47ij/9QYJL9sEYCWLhNptNeqOoAi0=;
        b=K3yJdL9Mr0Yzp2bwDn4QsngYGZhC7It+tkAQHGbENhMnb5nJgOc+dBhfWsO4MEO3oV
         bEIRkF/DHhsgx8UZG61pxaFBAwfW2Hq3lWsz+jpL+xRjw+ZlO+/vP01a6jagyZvUjq5l
         elKNn0FjpSrZIWzxJC4mlCEmvA+A6/8relqbSewIKsE9/NvCfpQIszJjQjJ3tChT9AIR
         iDn42aHRugRGyx5xmmG+EfeNMc3jtdFJLguFYEwV+MrZQ83jX+3r+WndNyingUFBqpjn
         9JGESWuEfHjWmjaa/Avn1P1EZV9TOvOdSxemkqdfGLbFqDW3Ss5byq2ECe5hHgrgj9Q3
         KDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6YcGWfOU8rFsr47ij/9QYJL9sEYCWLhNptNeqOoAi0=;
        b=pxpGutDh3v3ewIdZ3DZMRNKsj1kAdzCxmHp9pazNhnTL1XEpw95JkRtwQ1oMRVnXEW
         Cgb6vNQZIVMhcbn9XxOZnDNDH42s6Bsd0zt/C/LGxRdSuvHXF3M3ZY70tg1/fPRepCN4
         GYETU/VFg6svF2+sn3Ht983WEGp+EBNZ3+Bq8nk36o0qCawqgfTC8o+nyehu95EP7Xu8
         VuOaS9yhinh32MdGmyyA++IpLA6uh0FFIo30nY0UVbNpE5RSEQ/mrbgulVw7/bVoCNMa
         1B4rMTWGKx6jFj8xEi86QJ5ATHZptTgQrFw5PAKLhcV92vKILQNAd2fkqKtpN9DpUU5E
         OMqQ==
X-Gm-Message-State: APjAAAUwzNMQre7k7UgMBNQzvMpTFTgbaxm8WR1ZyyKUc2Wtqj2gYBER
        aIeUwe3zJQxe4FZEPRsbUuFn1SZxuDSAc+59IYp7YA==
X-Google-Smtp-Source: APXvYqzUJmuBYuVAjhf6yTj6LxkHzZwqx0Qg+4XKjRCmyODJb1NLbenuAlb8zq4pZoQb4hDAW3FIQstcxFk6dedV10k=
X-Received: by 2002:a02:22c6:: with SMTP id o189mr28192020jao.35.1561992537157;
 Mon, 01 Jul 2019 07:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190701040415.219001-1-joel@joelfernandes.org>
 <20190701040415.219001-3-joel@joelfernandes.org> <20190701122358.nzebpuunp6o5jxhx@linutronix.de>
 <20190701141403.GA246562@google.com>
In-Reply-To: <20190701141403.GA246562@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 1 Jul 2019 16:48:43 +0200
Message-ID: <CACT4Y+bJ-tNvMsfHcFEsWdjtBnaLTP9q=u7PCk4VMVPvW51WLQ@mail.gmail.com>
Subject: Re: [RFC 3/3] Revert "rcutorture: Tweak kvm options"
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 4:14 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Mon, Jul 01, 2019 at 02:23:58PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-07-01 00:04:15 [-0400], Joel Fernandes (Google) wrote:
> > > This reverts commit a6fda6dab93c2c06ef4b8cb4b9258df6674d2438 which
> > > causes kvm.sh to not run on my machines. The qemu-system-x86_64 command
> > > runs but does nothing.
> >
> > Nope. I would like to know *why* you need 'noapic' to work. Is it a
> > brand new or old qemu-system-x86_64?
>
> I did not have time to debug yesterday and I posted this particular revert as
> an 'RFC' just to make aware of this problem.
>
> I spent some more time just now, it looks like this has nothing to do with
> 'noapic' and appears to be a problem on debian distros with the e1000e NIC.
> May be this NIC was added to the virtual hardware because of -machine in the
> patch?
>
> Any if I add the following to the qemu command that kvm.sh runs, it works again:
> -net nic,model=e1000
>
> Without it I get:
>  qemu-system-x86_64: Initialization of device e1000e failed: failed to find romfile "efi-e1000e.rom"
>
> Seems to be mentioned here:
> https://bugs.launchpad.net/ubuntu/+source/ipxe/+bug/1737211
>
> And in syzkaller as well:
> https://github.com/google/syzkaller/blob/master/vm/qemu/qemu.go#L88
>
> Adding Dmitry who is syzkaller owner for any thoughts as well.

I don't have many thoughts on this. That particular error looked like
a bug in the package in the particular distro/version.


> I'm happy to write a patch to set the nic model as e1000 and send it out if
> we agree this solution is good enough.
>
>  - Joel
>
