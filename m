Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF92AF9774
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 18:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfKLRnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 12:43:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfKLRnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:43:25 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60599222C2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573580604;
        bh=xwxtyC0AXj0ksCo8SmNdjblvoZqcxlf8VXMMfMSNIFk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WYXd01Csut0FMBhxjI8Pr9vS9FaLHU2s7H09ewvL5b2GJdTza5MAzhWZU+0LAIS0M
         efVYQ0m9CP7asmxVpuEpE/lf4GjPMgDlbw+QIEYJaGPjrUqAalNhcMzXs2QuBluORg
         waAAczd6GGesNyaDtc6nN1NeGQPfKLn1t6Z1njAI=
Received: by mail-wr1-f41.google.com with SMTP id w9so12718933wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:43:24 -0800 (PST)
X-Gm-Message-State: APjAAAVQCGyWanyyhjIef3XjHfSenGNjeEyjIROprVcBK7Ye6Yk0nkms
        krgqRs9yn/7f4f5yZw0FMRm3/9Rad7e1v8zfiWkKgw==
X-Google-Smtp-Source: APXvYqxF8nMeX4jg2o7yQ2IVWo8QTc9SYoxZNBeh7PxlVxrXgCbqSypO9QOFlCXMbDpiI8vIIv8ih/bmEZ2OLloYHQI=
X-Received: by 2002:a5d:640b:: with SMTP id z11mr20907035wru.195.1573580602932;
 Tue, 12 Nov 2019 09:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223052.509914905@linutronix.de>
In-Reply-To: <20191111223052.509914905@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 09:43:11 -0800
X-Gmail-Original-Message-ID: <CALCETrVggkQ1fstXB3+VKA2otOi9z0JTU0PH-fvfqM-kudNtdQ@mail.gmail.com>
Message-ID: <CALCETrVggkQ1fstXB3+VKA2otOi9z0JTU0PH-fvfqM-kudNtdQ@mail.gmail.com>
Subject: Re: [patch V2 10/16] x86/ioperm: Remove bitmap if all permissions dropped
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
> If ioperm() results in a bitmap with all bits set (no permissions to any
> I/O port), then handling that bitmap on context switch and exit to user
> mode is pointless. Drop it.
>
> Move the bitmap exit handling to the ioport code and reuse it for both the
> thread exit path and dropping it. This allows to reuse this code for the
> upcoming iopl() emulation.

Acked-by: Andy Lutomirski <luto@kernel.org>
