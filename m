Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C231708CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 20:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgBZTPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 14:15:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46556 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgBZTPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:15:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id k29so235632pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 11:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=faXNTzlMzfy0e5V7zBUCEjYHy/JibUt6egG9EJx7eAQ=;
        b=rSDzK0nz7erP7TYWMWn5OXwHcEK9AYKhIwzGadIOZp45dWbV9abZl2dg25w5qLnb5M
         yORIyj+uhC77CcYP4pcusZicno0GjODCiMFfxCnhRjhNb4kWbyd9XE2sX5UW3gFKIqzv
         WB6DoJkTo7ubO3W8e/J/7JYmWvI+pi+J+W6ua9/QJF7RKMGVn13Io3y1bDbWcx2HzPnG
         RhDQxT/5oXmSggjYDx+MQMEI0zjlaGZTQTqAovAPlrjKUUM+74pqqUaZlqktT3Q9K5jZ
         2GbMbx20+1MwUML5ncMNWMCFKQQAA7+a04ZaYGigMq1dXYmJ2Ln7A1t1mOSZU5Hmvcyd
         i25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=faXNTzlMzfy0e5V7zBUCEjYHy/JibUt6egG9EJx7eAQ=;
        b=gH1LavukLa8R1uznZXenkHiUDvkyTVp5K7nGhy55qcMpj3mHwR8O3ieKrg0wqhpZGk
         2FNpeW8Aeyb4HMGUT8DvZ/6gSTtW3e03SrUEy17zgz7cxza/x7ixT1n3vxyy9By/t6MK
         zOlMUwdAyTEH2e11DOE7JAccmR0h2K+PdiAWJ401WN/BITCCJoWhVXuii+QVF4nyhb3i
         KpcVTgXRNzS8/Jj/joC/0RVI487pH+cXWFBCbMQm80YPVR/f0yRC11t3ywJqUGu01P3U
         ioZ4tLQ0e8m3/KVR+1N2O3qtH5NYtFp9MOImzAhVYPVVwm6H6SGV3Ikn8tYYIEKNettq
         O+yg==
X-Gm-Message-State: APjAAAWH/R/kjwxpDotSPt8SF/TKbbKVA5sH8o1TNdNpzTIyR1dy2nIb
        SerxczvlDse204iGhaSvqbo4Ig==
X-Google-Smtp-Source: APXvYqxaoyBiGyR4E2ZgGkrOw/QHcG71+jo85DyHbTdFVccazV3uMVlAHegbmPhve1uL1y+11TD4oA==
X-Received: by 2002:a65:5283:: with SMTP id y3mr332911pgp.370.1582744533698;
        Wed, 26 Feb 2020 11:15:33 -0800 (PST)
Received: from ?IPv6:2600:1010:b069:8a27:ddd9:92ea:d62b:8a52? ([2600:1010:b069:8a27:ddd9:92ea:d62b:8a52])
        by smtp.gmail.com with ESMTPSA id t15sm3572551pgr.60.2020.02.26.11.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 11:15:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 13/16] x86/entry: Move irqflags and context tracking to C for simple idtentries
Date:   Wed, 26 Feb 2020 11:15:31 -0800
Message-Id: <A4E714B9-ECBA-4984-986C-02B4EAF5018C@amacapital.net>
References: <20200226162811.GA18400@hirez.programming.kicks-ass.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20200226162811.GA18400@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 26, 2020, at 8:28 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> =EF=BB=BFOn Wed, Feb 26, 2020 at 07:11:39AM -0800, Andy Lutomirski wrote:
>=20
>> In some sense, this is a weakness of the magic macro approach.  Some
>> of the entries just want to have code that runs before all the entry
>> fixups.  This is an example of it.  So are the cr2 reads.  It can all
>> be made to work, but it's a bit gross.
>=20
> Right. In my current pile (new patche since last posting) I also have
> one that makes #DB save-clear/restore DR7.
>=20
> I got it early enough that only a watchpoint on the task stack can still
> screw us over, since I also included your patch that excludes
> cpu_entry_area.

Hmm. It would be nice to prevent watchpoints on the task stack, but that wou=
ld need some trickery.  It could be done.

>=20
> Pushing it earlier still would require calling into C from the entry
> stack, which I know is on your todo list, but we're not quite there yet.

Indeed.

This is my main objection to the DEFINE_IDTENTRY stuff. It=E2=80=99s *great*=
 for the easy cases, but it=E2=80=99s not so great for the nasty cases. Mayb=
e we should open code PF, MC, DB, etc.  (And kill the kvm special case for P=
F.  I have a working patch for that and I can send it.)

Anyway, this isn=E2=80=99t actually what I was concerned about. I meant DR6,=
 not DR7.  Specifically, if we get traced too early in do_debug / exc_debug,=
 we can recursively debug and clobber DR6.  The result will be incorrect beh=
avior in the outer do_debug. We can fix this the same way we handle CR2.  I j=
ust haven=E2=80=99t done it on the existing entry code because it=E2=80=99s t=
oo messy.=
