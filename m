Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B29F9855
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 19:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKLSO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 13:14:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfKLSO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:14:59 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFE4A21D7F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 18:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573582499;
        bh=jOCRZ134TH/Z5OvplR+xWIKdoVTbK0FwzXlo6x6EI1g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2qQtK+k+W63uyl+K++Kx6mXhTYm2E1/YgoXq/i6A6RejYoJ88CA6QtWIN9cSj1Hem
         c5mXSJ952QlQBXit940lPL7NLoOJcPDdrH7XFXKn1nB6LzBSZyPIEozsGE2QWUEuKx
         GLaUBDMs/i2pTXRvKC/McVaNmniW8A6jxjSniBhE=
Received: by mail-wr1-f48.google.com with SMTP id r10so19647243wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:14:58 -0800 (PST)
X-Gm-Message-State: APjAAAW/ktvyIYhd9N33ZWL1kHRsAM+QWtgU/tvT5K1TpKuH6ZatwLXk
        XUACqlflgKt6YCo96DEaCbfzcGqH4NgR7PJUbQ5LZA==
X-Google-Smtp-Source: APXvYqzUQhkEAnUillaLsJS8haTpPoOV5yJD3j8l+NlEz0VtuDNIagjrxpwNSnlnaIiYq7bMLPuoKnmTjGfxwCfSJNQ=
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr27885258wrm.106.1573582497243;
 Tue, 12 Nov 2019 10:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223052.790754100@linutronix.de>
In-Reply-To: <20191111223052.790754100@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 10:14:46 -0800
X-Gmail-Original-Message-ID: <CALCETrVrk-p6+sjjtP=uuh3n9GDJifydiBHjTbfw0cha+_1c-w@mail.gmail.com>
Message-ID: <CALCETrVrk-p6+sjjtP=uuh3n9GDJifydiBHjTbfw0cha+_1c-w@mail.gmail.com>
Subject: Re: [patch V2 13/16] x86/iopl: Fixup misleading comment
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
> The comment for the sys_iopl() implementation is outdated and actively
> misleading in some parts. Fix it up.

Acked-by: Andy Lutomirski <luto@kernel.org>
