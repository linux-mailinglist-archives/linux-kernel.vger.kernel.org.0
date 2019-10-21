Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25FDF81D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 00:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfJUWkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 18:40:04 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34897 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729620AbfJUWkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 18:40:03 -0400
Received: by mail-vs1-f68.google.com with SMTP id k15so1051892vsp.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ZsNsXP4OTYt0YNh6qKFB6AFECQX69mBiPpRVt9SfH0=;
        b=O/CXUAVGNYcy3a5ZMEhvYVIsdUWMdntI32aa1fCXHK7oi6GQtdX8twOyCLRtqHcLw6
         am1b9fbswrT9o98uh5aDlhm1tPvl0Av/XEHc7jFDFc/FekuKFDvkdmrzLXsS+cBmnejP
         w+a/gseGa6WnbCp/yH1KdCdxNLv/Q43LbeRO19wQ0C6JCREDYSId7agxszZ/KRyBe4dS
         rBqaj2BEFPuwjg8K2IaN+ZdQ2/V18uW5p+D3bRRAW5ncrEsKECvCEFR63WSYX3IplWb4
         GYGuiM7vUIXmh+zLMMdnpEno7Jg6V7tjnP6+5fo5a94md98f+1ELrfUwmGcSvu34YKiS
         XHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZsNsXP4OTYt0YNh6qKFB6AFECQX69mBiPpRVt9SfH0=;
        b=LRZ432uQkVzyF1z82vbxgB446QbsulDDNGg7CYs+OGhfOeV5//zD2gdwjtA78lFHCK
         TxBKSkn9bkGg7dcycNHK0Mm9Xs0OCIiyS1JFgBrnWdKBgE80qApFIEC8bApIr7urs+Xx
         TczaTjuWqrx8xTByfb4JwtBlc2ZzQh85P0/K3pRUc5j53luaPIChLbUb9PnhZry3/rib
         mJ7dB9LHcjyPIN1GKyoXUHTQEkwc2p+8ZLtGhgqGIpooMFGF8abTbmwXx9YXvy2WgfQ7
         tozlETmLopCaqe74zPDr7VzcM5vzNNp7fK7jwbVHMrasRRHNRAaL8kt5A6yManxSVaB2
         Vz2A==
X-Gm-Message-State: APjAAAXyzwfgOVOoNU0mqEoSUyJeQdsOj4ZTke3PHubliC2alCX2/mY9
        yaSKT5FyblQQOvZkoVEjzutbi3wE9rkQ+KmV0XiVFg==
X-Google-Smtp-Source: APXvYqy582En+heI5MQp3ZrQQ6f6MZJsAwNRRmtRSRpMZCKNBzLSU+/wxNeKwJ1tJAW4E2Y1xYNHr6jWiAAsx2LVJZQ=
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr100849vsp.104.1571697602070;
 Mon, 21 Oct 2019 15:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-15-samitolvanen@google.com> <CAKv+Gu-kMzsot5KSPSo_iMsuzcv8J1R5RLT9uGjuzJsxCVUPPg@mail.gmail.com>
In-Reply-To: <CAKv+Gu-kMzsot5KSPSo_iMsuzcv8J1R5RLT9uGjuzJsxCVUPPg@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 21 Oct 2019 15:39:50 -0700
Message-ID: <CABCJKuf-tXu2ZhBMCYTHP3BU8g1i-0GGd7+YvyTDUc1kH2iZvA@mail.gmail.com>
Subject: Re: [PATCH 14/18] arm64: efi: restore x18 if it was corrupted
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 11:20 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> You'll have to elaborate a bit here and explain that this is
> sufficient, given that we run EFI runtime services with interrupts
> enabled.

I can add a note about this in v2. This is called with preemption
disabled and we have a separate interrupt shadow stack, so as far as I
can tell, this should be sufficient. Did you have concerns about this?

Sami
