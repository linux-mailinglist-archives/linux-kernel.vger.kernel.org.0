Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4EFF98DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 19:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKLShW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 13:37:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfKLShV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:37:21 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1F92222C5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573583841;
        bh=Lvy4XTOQ7GGxUfbT/8C8wSIhdjF7sD5Vaz52aFvJGwM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lYXqhODX4CTLOMAeg96i8HpOo2f+BT9urGtJ0c0BgQPMN5DoSeCazZONFNfEXVZ7A
         i0h22T98XfJK9hWokMlxAUXtmBvk5yyrF4qoELEmoBohzHuzQBXOlhYclWRn9nM6YG
         60HT3NFZEbyU+JENvZ3W3T7ZVIIAiIcb8RDxq7NI=
Received: by mail-wm1-f44.google.com with SMTP id l1so4379259wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:37:20 -0800 (PST)
X-Gm-Message-State: APjAAAUrwnc10pBLoXLoIbvsnmPZQQ/d/BKjOjMKEzpYg9CImcplqAxj
        NqjskV1xkq6ofGnk9SM2ePF5dq2uHv7CQ1+GcfH7iw==
X-Google-Smtp-Source: APXvYqwUfcHuWCDDKcAWpJ/cAbvkX3JmAvIbFGgBeuBaLKkbf4657GK0B+Gp3FFR/AkLf84UMnbK3uoBaAmUE5CsujQ=
X-Received: by 2002:a05:600c:1002:: with SMTP id c2mr5288493wmc.79.1573583839351;
 Tue, 12 Nov 2019 10:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223052.990437835@linutronix.de>
In-Reply-To: <20191111223052.990437835@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 10:37:08 -0800
X-Gmail-Original-Message-ID: <CALCETrWsr=KXyg_dc+97StqFHPRkvW_db_b4QvnH+ib9YJ761w@mail.gmail.com>
Message-ID: <CALCETrWsr=KXyg_dc+97StqFHPRkvW_db_b4QvnH+ib9YJ761w@mail.gmail.com>
Subject: Re: [patch V2 15/16] x86/iopl: Remove legacy IOPL option
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 2:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The IOPL emulation via the I/O bitmap is sufficient. Remove the legacy
> cruft dealing with the (e)flags based IOPL mechanism.

Acked-by: Andy Lutomirski <luto@kernel.org>

But I think you could simplify a little bit and have a single config
option that controls the iopl() and iopl() syscalls.
