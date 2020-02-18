Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A244D1635D7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 23:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBRWJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 17:09:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgBRWJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:09:00 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C93042465A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 22:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582063740;
        bh=qRWAvYsavB34O2TeDdY9WjdGCAyZQckEaNKMa6i36QU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=omJwXp9X+6kFpO2wu8Ta98kyv8SsEjfk1yB+iz1Mv1YxN7oEOnhubO6bTgs9dGYmR
         CpvI9pLLKkevN+guJ7qUfQc36yWglipOIEhDyMO48rVZCnWoqBrcdyNLbSOntYoNqU
         f+3Wk1LmhjuzHxzg+B9YARQZKgyuwa4yxZM+WVUw=
Received: by mail-wr1-f41.google.com with SMTP id y11so25830297wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 14:08:59 -0800 (PST)
X-Gm-Message-State: APjAAAW+V0in+hwXuAA8OdAoWIxuCLegFHF5zPWQAgsKA4BIDFu+pver
        etF8aFFXEO4Akijx4PZOOtdVsQ2ByJMlWZHwUuoqgQ==
X-Google-Smtp-Source: APXvYqy4xcsEXxuc8l5KaIyC3sMnwa0xIIKe/DtpIs+M0XyRRLjwaSyX+69z4jn/QHiiuPUZjm6SsE+BIyDqeRLCpYk=
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr31636023wrr.208.1582063738210;
 Tue, 18 Feb 2020 14:08:58 -0800 (PST)
MIME-Version: 1.0
References: <20200216182334.8121-1-ardb@kernel.org> <CAKv+Gu-4N6B0LPL1fn5C2EAh9y3ECZ=mSi92p0AyJf67mJoWmw@mail.gmail.com>
 <20200218194625.GA25459@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200218194625.GA25459@agluck-desk2.amr.corp.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 18 Feb 2020 23:08:47 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-P05VJDXpFr_CqA7WVrnac_nWeGT36D4oDEPAHM5cDrw@mail.gmail.com>
Message-ID: <CAKv+Gu-P05VJDXpFr_CqA7WVrnac_nWeGT36D4oDEPAHM5cDrw@mail.gmail.com>
Subject: Re: [PATCH 00/18] efi: clean up contents of struct efi
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 at 20:46, Luck, Tony <tony.luck@intel.com> wrote:
>
> On Sun, Feb 16, 2020 at 07:31:58PM +0100, Ard Biesheuvel wrote:
> > (+ Tony and Fenghua)
> >
> > Apologies to the IA64 maintainers for forgetting to cc you.
>
> No worries.
> >
> > The whole series can be found at
> > https://lore.kernel.org/linux-efi/20200216182334.8121-1-ardb@kernel.org/
> >
> > Please let me know if you need me to resend with the missing cc's added.
>
> Thanks to get-lore-mbox.py I don't. It picked up all the pieces.
>
> It all builds and boots with no issues.
>
> Looks like a nice cleanup.
>
> Tested-by: Tony Luck <tony.luck@intel.com> # arch/ia64
>

Thanks Tony.
