Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98FC1C03A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 02:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfENAzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 20:55:45 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:29180 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfENAzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 20:55:44 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x4E0tPMI015747
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 09:55:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x4E0tPMI015747
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557795326;
        bh=TZeuh+LiOJxu+d+TE5u/ckeh9PDmuMGsHPSdJGsNbFg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BAE1XB0gM1vAlPm3PzF/k5KqOoRn7UlR4DEwQUkuxOWVg4vSZe6YDhE18IrOT8IEf
         lDvy1hLrXpuYbXAQe0jWIjaFPnXyyLRsx7CKdKrnE8IlYVqUiTN7+PO4mGxip6Hr+d
         thShfEeZKk5BUBzTA0tGVJEOwBIg8osamH8zxJPxcaxvwV6LNr3sWVezuRwfPYt5nE
         50hwz9ExGliACE4bXwNvxUDYT4LeN/SY+GV64oObi5ge//bg8sJ4MLj7Z9f6WDE4XU
         7DxmN3yqxcXfoxDlvGvPZdRyhlakG6aMZCzvZ34Ild3jq/nGj7QXAWaUalq2y8WOBx
         MmH38NmHfOL4A==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id o187so3819148vkg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 17:55:25 -0700 (PDT)
X-Gm-Message-State: APjAAAXxFs0ANZJr1mUhbv9n4uym4m2ocjI0WHh5SrjCLUExAOEN97zP
        SjyNoSjrjrpkPmic1ynpaplRGbgYXaRad7U2bHA=
X-Google-Smtp-Source: APXvYqwyARb5Jo2vQhfqx0B0n0G+vUMnjtqjO/8HHjKNj273gF/DWpmy/bKsVGiY0Mdoh6C4rsJ0xJAMGDy51C9oRj0=
X-Received: by 2002:a1f:3dc9:: with SMTP id k192mr5885836vka.74.1557795324922;
 Mon, 13 May 2019 17:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAR5j1ygbq9TLqUhbJ+tkMdrtD3BgQoUWZErUrnEoWKYMw@mail.gmail.com>
 <b5e2a4d9eb49290d6dc3449c90cdf07797b1aba6.camel@perches.com>
 <CAK7LNAQxsUheo2dHn5E=4ACafcYL9zNubgiVkJkANuZkx2RgpA@mail.gmail.com>
 <a28b0616aca51aed38fd99fb85632628e6fd8d60.camel@perches.com>
 <CAK7LNAROgRBuZOVb5+NZd10+z=SaRhvJZ5eQ09pcknbdEJ+Gng@mail.gmail.com> <1b9e57cb7544f1edbef9a142663e8f71874b204d.camel@perches.com>
In-Reply-To: <1b9e57cb7544f1edbef9a142663e8f71874b204d.camel@perches.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 14 May 2019 09:54:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNATibD4_joj_-2WTxBxZCkVRWvuDv1YGq2njfr4E5CjzhA@mail.gmail.com>
Message-ID: <CAK7LNATibD4_joj_-2WTxBxZCkVRWvuDv1YGq2njfr4E5CjzhA@mail.gmail.com>
Subject: Re: [Proposal] end of file checks by checkpatch.pl
To:     Joe Perches <joe@perches.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 9:01 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2019-05-14 at 08:46 +0900, Masahiro Yamada wrote:
> > So, I think these two checks can be done for
> > all file types.
> []
> > checkpatch.pl misses to report most of them.
> > (the majority of the warning source is *.json)
>
> Perhaps the json files should be ignored as more than
> half of the .json files in the tree are missing the
> newline at EOF.


I guess they are accident.

I do not think missing newline in *.json
is syntactically significant.


If we are unsure, it is better to ask the maintainers.


> And at least some of those json files use spaces for
> indentation and not tabs.

This is different stuff.

Indentation and newline at EOF are not linked.


-- 
Best Regards
Masahiro Yamada
