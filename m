Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C4174012
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 20:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgB1TCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 14:02:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1TCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:02:16 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84CAA246B5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 19:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582916535;
        bh=RRX0Q3Pd6bQrUaDTY4Y++QQe4nlfj+rP1qpxupz/Ipg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cXZb11UUyULsJN01zmnl5lMYPJpyuxDATP4yQpAnFP5K6OskYKMfE+jwYFwelDdFu
         xyZ25QFTPFLX6xBWm/mi89uUaC+XcI+eeN7ODzkGqx8iucom85BpqEZRQ+nH5zizao
         6n25rlNXTBCVCQr2kw20l3MJAZ/ycbepiByDT5z4=
Received: by mail-wr1-f52.google.com with SMTP id l5so4228995wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 11:02:15 -0800 (PST)
X-Gm-Message-State: APjAAAW+wypmVq9UxcrJExxWWDKA3iH30AoiN8N2oiIFg3Wh+37MWt+c
        YIMQCoTJB0ih1SyatXVxIzFNBHxruVQnMneLlmeBGg==
X-Google-Smtp-Source: APXvYqxpVEvcka5rH5AEcJi1MlIEWJFzHscL2zMl5v12QwKuJLyHeZIHNntbz9NPFZYXnLT6cYqFjXXg6CqIah5GwrU=
X-Received: by 2002:adf:ea85:: with SMTP id s5mr5974601wrm.75.1582916533984;
 Fri, 28 Feb 2020 11:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20200227132826.195669-1-brgerst@gmail.com> <20200227132826.195669-9-brgerst@gmail.com>
In-Reply-To: <20200227132826.195669-9-brgerst@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 28 Feb 2020 11:02:02 -0800
X-Gmail-Original-Message-ID: <CALCETrUGLcQQkp3e9-A8r+VSzvwbzn0Lzi-yeVyi6BT+YvB+9A@mail.gmail.com>
Message-ID: <CALCETrUGLcQQkp3e9-A8r+VSzvwbzn0Lzi-yeVyi6BT+YvB+9A@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] x86: Drop asmlinkage from syscalls
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 5:28 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> asmlinkage is no longer required since the syscall ABI is now fully under
> x86 architecture control.  This makes the 32-bit native syscalls a bit more
> effecient by passing in regs via EAX instead of on the stack.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Reviewed-by: Andy Lutomirski <luto@kernel.org>
