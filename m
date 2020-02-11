Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD966159BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 23:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgBKWOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 17:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgBKWOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:14:05 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48C0D20848
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 22:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581459244;
        bh=Tzo7oLihh6XmYdZ4fKdx4WcMxH4KEKF1Qm1JB/jwLwY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VpUH9q2Ld9f0sZfPeirYatwOo0AY9GNGwCayffYWwmErMNp068fBLBmJfdfSc/lE1
         1KTgyuEpfu3cUeSrxuONfZouwJuPNKBDZ+9U4pgZ1McQo3gStxCp/uwgNkRzBij3/W
         mVANOrP5chQlopRUZpNrxR4trUkQQr/2dH+S486o=
Received: by mail-wr1-f46.google.com with SMTP id t2so14552933wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:14:04 -0800 (PST)
X-Gm-Message-State: APjAAAV9AFnmi6WrK80tmWsxEkg4xuJO08BwpXhttWaGjnSUAxi0z4hp
        1TILHSs4pAgcDghG2hJc2DW7aG67MAY10/7n2VEMYA==
X-Google-Smtp-Source: APXvYqydo76PkEmj5PG5O27EmrWOjY3nLu09O+yXpO0pI2+Gs1e7Uz84BfjfNy+FRfjeX2dRElyHGQ0YcfBM+E5UZeM=
X-Received: by 2002:a5d:5305:: with SMTP id e5mr11001033wrv.18.1581459242661;
 Tue, 11 Feb 2020 14:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-8-joro@8bytes.org>
In-Reply-To: <20200211135256.24617-8-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 11 Feb 2020 14:13:50 -0800
X-Gmail-Original-Message-ID: <CALCETrVVjECt2TNVDJcuS68663ioPTiEY13-1uO_gWYjWaVwPA@mail.gmail.com>
Message-ID: <CALCETrVVjECt2TNVDJcuS68663ioPTiEY13-1uO_gWYjWaVwPA@mail.gmail.com>
Subject: Re: [PATCH 07/62] x86/boot/compressed/64: Disable red-zone usage
To:     Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> The x86-64 ABI defines a red-zone on the stack:
>
>   The 128-byte area beyond the location pointed to by %rsp is
>   considered to be reserved and shall not be modified by signal or
>   interrupt handlers. 10 Therefore, functions may use this area for
>   temporary data that is not needed across function calls. In
>   particular, leaf functions may use this area for their entire stack
>   frame, rather than adjusting the stack pointer in the prologue and
>   epilogue. This area is known as the red zone.
>
> This is not compatible with exception handling, so disable it for the
> pre-decompression boot code.

Acked-by: Andy Lutomirski <luto@kernel.org>

I admit that I thought we already supported exceptions this early.  At
least I seem to remember writing this code.  Maybe it never got
upstreamed?

--Andy
