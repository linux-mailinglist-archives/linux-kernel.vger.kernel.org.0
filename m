Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD53013AD7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 16:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgANPVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 10:21:20 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41111 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:21:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id x129so12390887qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+VTsT8at9VIYcyBlipNY0A9XMLE3LU+9wMyoR7dVL0=;
        b=lL0gwmIhu/QDzkMudcYSE1LRGOYpJCSrcnNAnosiNNFrMsIQnFJdQKehKILwE2iJ1+
         oLPDtSrEhjqtp4xNou9CkH+yJ5kLYMxJmjRRs4h8GcfvMdzvlOYtwEaIt/Z/hz4etL3m
         Ml9T7bFe+8SQbg1lX1Fx6K0Y3uU5OQbjTlkF+HwF4e7Uj9O3oPfMsgQju+a4l+oNYyid
         DwDon1lBHobwlkezy+kQHcCTg4wk3gPhXeAowUOqQDRIGBdirwKzHxRXgJVV/tinq75c
         1Fmo8g/Kka4lWODeK0+WZh5RyO/ylvA4TSvlRB0hG4DUX383lclX3Ad9gnPVMpIbv+IP
         /Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+VTsT8at9VIYcyBlipNY0A9XMLE3LU+9wMyoR7dVL0=;
        b=PMHfwC/qxNw5NAZggsA6H3IMe1SACsEm5WsguWenwXMiKElp1f+RSWJ6DMk2BAB3U9
         4d8fPW5UN5Lve3DqQ6jLGYexMnomftImYy8OcIQ7NjVgC6O11lqJqFvUWLQ9oG1T1v6u
         1GoGY+SrCPgOEAqh2UAtzKp4ajpmqTJPpM0zsLFc5hQtfVu/JF2VP7+qGwnN1Bkj5qPS
         vwigsDzhtwbllP7iqdIZlEsKc08C6koVS2ync1+HlFmyr4No0hlcwIzc9inhXx5MMw3g
         M3QZiETVnGtOtpLIS5QNF6ksYIA95TFW5D7Y2xzOWYFiStRb5FTKtN3l6sdMSalpwDOw
         Deag==
X-Gm-Message-State: APjAAAXKYs2ScfD+xcPlDtmIBVPxpl8zlVgaHQGDUuhlYrEkrm8hJeJw
        qA/Bo19kAIujOb6XPR36delV6xxaHFtSXprd/5uxHg==
X-Google-Smtp-Source: APXvYqzYb+WwkBTvjUQEo/PYA/bPJBYaNM8e/I+hFwISaSzbgnhWPIFu1r3OE+UEzf1dXdEYsq/cQkQafH4NDMIYODM=
X-Received: by 2002:a37:e312:: with SMTP id y18mr22622227qki.250.1579015278856;
 Tue, 14 Jan 2020 07:21:18 -0800 (PST)
MIME-Version: 1.0
References: <000000000000486474059c19f4d7@google.com> <CACT4Y+av-ipjsdtsXs4d55w=inNHJqho3s3XKfU0Jo7f98yi8w@mail.gmail.com>
 <1579013812.12230.21.camel@linux.ibm.com>
In-Reply-To: <1579013812.12230.21.camel@linux.ibm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Jan 2020 16:21:07 +0100
Message-ID: <CACT4Y+bgQVmibpeJgpwb_JTKW6jx3dzv0M-NGVat8qvJTo4X7A@mail.gmail.com>
Subject: Re: inconsistent lock state in ima_process_queued_keys
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     syzbot <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 3:57 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2020-01-14 at 14:58 +0100, Dmitry Vyukov wrote:
> > On Tue, Jan 14, 2020 at 2:56 PM syzbot
> > <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    1b851f98 Add linux-next specific files for 20200114
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=12bcbb25e00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3e7d9cf7ebfa08ad
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=a4a503d7f37292ae1664
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com
> >
> > +Lakshmi, you seem to have submitted a number of changes to this file recently.
> >
> > This completely breaks linux-next testing for us, every kernel crashes
> > a few minutes after boot.
> >
> > 2020/01/14 14:45:00 vm-26: crash: inconsistent lock state in
> > ima_process_queued_keys
>
> Yikes!  Are you running with an IMA policy?

I don't know.

>  I assume this is being
> caused by commit 8f5d2d06f217 ("IMA: Defined timer to free queued
> keys".  Does reverting it prevent this from happening?

The following seems to help, but don't know if it's the right fix or not.

diff --git a/security/integrity/ima/ima_asymmetric_keys.c
b/security/integrity/ima/ima_asymmetric_keys.c
index 61e478f9e8199..49d559501fe62 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -103,17 +103,18 @@ static bool ima_queue_key(struct key *keyring,
const void *payload,
 {
        bool queued = false;
        struct ima_key_entry *entry;
+       unsigned long flags;

        entry = ima_alloc_key_entry(keyring, payload, payload_len);
        if (!entry)
                return false;

-       spin_lock(&ima_keys_lock);
+       spin_lock_irqsave(&ima_keys_lock, flags);
        if (!ima_process_keys) {
                list_add_tail(&entry->list, &ima_keys);
                queued = true;
        }
-       spin_unlock(&ima_keys_lock);
+       spin_unlock_irqrestore(&ima_keys_lock, flags);

        if (!queued)
                ima_free_key_entry(entry);
