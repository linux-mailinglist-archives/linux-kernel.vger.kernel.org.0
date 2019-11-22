Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE3D105E32
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 02:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKVB1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 20:27:02 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:46321 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKVB07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:26:59 -0500
Received: by mail-pj1-f65.google.com with SMTP id a16so2307224pjs.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 17:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TU/4Ef2jiJlWVCQ4cQLrxn75XZh8TZ+zwtkucEXiu6Y=;
        b=m2BETWVpqlllD08mHYTdBJVrgblUy6CNB+DVYcBf9k1lTWIC7q1zlf4DUt7C76yvFH
         G6g+FzKXJOEn6Vlo815oRlNBTnuOYeh6pCdoJ1hx+Svn5rOtOL1wNOb+UEMgHBUphhlH
         P8cv6J335QcanJ1JahmxBQ5wp52tqT2vEclNYvdd1JfgV6k5eQEDGUUqW3uoh8dfQHoS
         9xXdeB8VoyFb6OzA2Q8Ztk9qWRPfX+qdV3hUp7yzrKXrqPW/4+evxgguDIUq/jyml/xl
         uRx2Z/AjTUK5d/DHjDDKOSV8NRou6QR+IdZLRPjDl5zRTY1jkB6dh0gQ9Z1oePhabV1F
         e0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TU/4Ef2jiJlWVCQ4cQLrxn75XZh8TZ+zwtkucEXiu6Y=;
        b=AHTxLafqfpreU2VsAIFgv7TWWNECgxywA02fZa6riGMS5k40L7Mh9e97A9268eKkm/
         30A3ftCwgU81ISjn3dRrvenF5EPsqSNrFinOuV1KoZEam2gcx+YQe7X2UmxSmHnw/WLn
         71lvgiOZ8fEy7BqHy/eNH/hsqbiqZQ3CprSu9KMEisapqWXAZCXk07JvIMJVY7EElacK
         j07bR/Aa3pGB/OXYBDUy0YO41+L8c5dMlkziVmW5MN8+udgJnpyo9IQLFNJpoPxqHSce
         IYK1vquwxkbwiVAd81qWrzceC5AcjYZ+JTabMWpXxAi7A3c44BDxcvzV+e2dyhvl9fDL
         d5tw==
X-Gm-Message-State: APjAAAWZBVcjBWTiieQzbYCab/tNYdlqiR5ApgEHCcBCNwnr9TnDLO+o
        N0X9405PnpLPyFLKPtpFsG/LAc6mgiRTE5sKrPutvlvB
X-Google-Smtp-Source: APXvYqyEm29BCL9dYSdTsXPxmgv2TKuC1svdFqNukvJ2stRS4zyFKH8B0gohRL0YLXx0L/gX9Xmw6kRwgk7gtVPhA6k=
X-Received: by 2002:a17:90a:d818:: with SMTP id a24mr14948297pjv.40.1574386018942;
 Thu, 21 Nov 2019 17:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20191121184805.414758-1-pasha.tatashin@soleen.com> <20191121184805.414758-4-pasha.tatashin@soleen.com>
In-Reply-To: <20191121184805.414758-4-pasha.tatashin@soleen.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 21 Nov 2019 17:26:47 -0800
Message-ID: <CAMo8BfJYEh_HYGuKwKgfwVdVwg-w-AxN=+6zDuYdwB+E_dTSzA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: remove the rest of asm-uaccess.h
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        James Morse <james.morse@arm.com>, vladimir.murzin@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 10:50 AM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> The __uaccess_ttbr0_disable and __uaccess_ttbr0_enable,
> are the last two macros defined in asm-uaccess.h.
>
> Replace them with C wrappers and call C functions from
> kernel_entry and kernel_exit.
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/include/asm/asm-uaccess.h | 38 ----------------------------
>  arch/arm64/kernel/entry.S            |  6 ++---
>  arch/arm64/lib/clear_user.S          |  2 +-
>  arch/arm64/lib/copy_from_user.S      |  2 +-
>  arch/arm64/lib/copy_in_user.S        |  2 +-
>  arch/arm64/lib/copy_to_user.S        |  2 +-
>  arch/arm64/mm/cache.S                |  1 -
>  arch/arm64/mm/context.c              | 12 +++++++++
>  arch/xtensa/kernel/coprocessor.S     |  1 -
>  9 files changed, 19 insertions(+), 47 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/asm-uaccess.h

[...]

> diff --git a/arch/xtensa/kernel/coprocessor.S b/arch/xtensa/kernel/coprocessor.S
> index 80828b95a51f..6329d17e2aa0 100644
> --- a/arch/xtensa/kernel/coprocessor.S
> +++ b/arch/xtensa/kernel/coprocessor.S
> @@ -18,7 +18,6 @@
>  #include <asm/processor.h>
>  #include <asm/coprocessor.h>
>  #include <asm/thread_info.h>
> -#include <asm/asm-uaccess.h>
>  #include <asm/unistd.h>
>  #include <asm/ptrace.h>
>  #include <asm/current.h>

This is not related to arm64 or to the changes in the description,
but the change itself is OK. Whether you keep it in this patch,
or choose to split it out feel free to add

Acked-by: Max Filippov <jcmvbkbc@gmail.com> # for xtensa bits

-- 
Thanks.
-- Max
