Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE309D66CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbfJNQDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 12:03:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45805 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNQDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:03:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so9175709pgj.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrIaBUAl4Zs70Rvgh9Rg9A2Po5PtzGSRs+KQTItvpaE=;
        b=FJRy+r/zmSx0gTnh8nKk1MPaEhd9110EYn+G/+d4CpMIFscpk01MlyLHoHm5nqZ8ue
         CuEul5WqlGE6j/Va+TR2Yui1YW7GVr2UUJY+9m2nC1JwH5BH8lcHf9U9XardiDiGlOoi
         LaSSoXJLXvlrU+VQVXnO4lV/hae2O2+UoHmjSciqevrjzzXyJTp2d2+Y56+KcxRdCA6F
         7jmUcI5EAM3RTKj4p1Vaa6PDjBLCH1AKMAuK0N4y1tOSRYdnDC35vB3Mw9OlU6bctebd
         2KNziMABLbLEYIGJg85nQqt/hgKI9d4QgqspA9b11El3xetBfiuEmVrbjpRyRnhgYpcf
         TsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrIaBUAl4Zs70Rvgh9Rg9A2Po5PtzGSRs+KQTItvpaE=;
        b=rSGPp79YRycIr7t6SL6roTOLUXgzk1M0akmm+PZ2Qn9G7fzQ6d26NbGaDqH4e0rlgF
         eMZZgcIx+l64P3imE2X47RQK8rt2+8a2fwVVKle5TFpStAaaNyJDTaMsuB9eQpOuKZ2+
         UeYXb/Jl0uQATlWxHzsljsZ5XaOGKj/3lEWk+oL3ikiWdZ8RDuO9bDHiB5D4u2Ja10vA
         jz0tckXMePhxwXQ7kbDGbgxUnl+7kpCQTwBZQBNCF2cjiyOIT2MsajUyKJAu9oU1kxRS
         DAuq0DwzzWnq+wsACYlNqV/1EtWVbnDyt6F+IlQ+p7og2OKtEPOi+73/PuNYZQ1REJLy
         hGmg==
X-Gm-Message-State: APjAAAUpcSC/JDR4didHE8G9tQzBPn4Bo4Mg3igXUmufL0+ptCPHAAuW
        9rgCRPM5on0hgnAPbwc2c044Q99NBvMJ8r3k3qApUOMY
X-Google-Smtp-Source: APXvYqzU0iN+S7UXYs1uP8WMChehRjsMrIbH3W7hJo7ZotpsfsIfMcdj3QGiw3CN0MtVD1Q6FSaHcabb11NtrnpteRQ=
X-Received: by 2002:a65:464b:: with SMTP id k11mr15727142pgr.263.1571069020713;
 Mon, 14 Oct 2019 09:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190911182049.77853-1-natechancellor@gmail.com> <20191014025101.18567-1-natechancellor@gmail.com>
In-Reply-To: <20191014025101.18567-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Oct 2019 09:03:29 -0700
Message-ID: <CAKwvOdm+xxo=Qm7N8CznSExFNL=GxoJ0Da4Td2D0zUYH4mOLvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] LLVM/Clang fixes for pseries_defconfig
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 7:51 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi all,
>
> This series includes a set of fixes for LLVM/Clang when building
> pseries_defconfig. These have been floating around as standalone
> patches so I decided to gather them up as a series so it was easier
> to review/apply them.
>
> This has been broken for a bit now, it would be nice to get these
> reviewed and applied. Please let me know if I need to do anything
> to move these along.

+1, we've been carrying these out of tree for some time now, with this
series merged, we can get back to 0 out of tree patches.

>
> Previous versions:
>
> https://lore.kernel.org/lkml/20190911182049.77853-1-natechancellor@gmail.com/
>
> Cheers,
> Nathan
>
>


-- 
Thanks,
~Nick Desaulniers
