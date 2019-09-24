Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8ABD30F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 21:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441969AbfIXTvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 15:51:22 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:38237 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfIXTvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:51:22 -0400
Received: by mail-vs1-f41.google.com with SMTP id b123so2175833vsb.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=expR+lx8jNlMjEW8KxfeBAd/u8Jyytgx3jfeBbC+1qo=;
        b=tCY8PZ3n3ImZVsV0hT6tV0wl59O/CgcRxQZ5aBtaEzbfs2pzyMjwRC4q64N3xjlkch
         rlyoGe5QIEH+CsLClgAmvJzJLLQzm/3Xs3Cd/gIfg9vlJtJkrxO5wqNaOwNVCeH+EZvz
         Hp7QmrYDU/tH0K1rDD3qFHin1wmJObtZDnCLkOdlk2SSF3826vHPU529c+v/MuOSWamY
         walhypDOchsoUYjju6UsWne2FNRJtr9+HX8+KRTOHHKlq0PbP4caljbd/p48CXWmMzG7
         8h0w7Pt2MsV+SQ6E8IxJ2UUQ7b0S+9PzuYICCue7QjMS7XJUtXY5HtpSZ7JWtR6xPAWz
         p37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=expR+lx8jNlMjEW8KxfeBAd/u8Jyytgx3jfeBbC+1qo=;
        b=oQw3b91oBt2Fn/VPfSPeDnu4yzqNrKA82Nn6GWWM9fS8/pHnb5spbGoB6hBPYXuG3A
         TSk04XqQBUMZ13HZyNJ1ygu3/ewmF2n0ptvQKqMO8tUZreIqpwAGnGQphdxKCxs9bSB+
         CDehKsY1z++Kv6umbcdCl/zXxdVC0WgXlddlwIvZoopJ76mM7rPQYmPNR+ZbWl5avpud
         ZGTlCBNqiuRwKNGVtHALG3ZvHwslCkZ+3tl60jIlU5Rx87l2FmZBCH1t03QR2NZndIKz
         5reds7GTTSwuU4EV8q46vrBAWE7O8k6000ixdMwZPErQUTuRrburwv0mzahqfQdFL55q
         rbaA==
X-Gm-Message-State: APjAAAXCHz0rudV3gGSqCfAJ3RXO9Dh17ZTa7cN5/j8oLIBmTx9+wlvg
        Dy7AEG6E2/5Z5W+AbOKFkMAJyhyTUqeVQ4HmeflyGA==
X-Google-Smtp-Source: APXvYqw3wL+3Hof5zDTfPf1FlstSF3LbtQdbl/cGM0YRsJ0x67IZPSL+PZNfcfBsjD2Es1rWG1+614W85pYMV+gh5TM=
X-Received: by 2002:a67:7f57:: with SMTP id a84mr2654419vsd.112.1569354680636;
 Tue, 24 Sep 2019 12:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190913211402.193018-1-samitolvanen@google.com> <201909231626.A912664DA1@keescook>
In-Reply-To: <201909231626.A912664DA1@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 24 Sep 2019 12:51:09 -0700
Message-ID: <CABCJKudtyL4UO+45GMLNT6vZK-FEB-Nvry=aPEnWDY3v0goOew@mail.gmail.com>
Subject: Re: [PATCH] x86: use the correct function type for native_set_fixmap
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 4:28 PM Kees Cook <keescook@chromium.org> wrote:
> Is it correct that pv_mmu_ops can't be changed since this is an external
> API?

Someone else probably knows better, but yes, we could also fix this by
changing set_fixmap to accept enum fixed_addresses as the first
parameter, and changing the type of xen_set_fixmap instead.

Sami
