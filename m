Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FF96F6F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 03:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfGVBht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 21:37:49 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36599 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfGVBht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 21:37:49 -0400
Received: by mail-ua1-f66.google.com with SMTP id v20so14697687uao.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 18:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YkkaXfp503K6bLavwX+qLvL6w0rpc7OLS8RSOtuP+M=;
        b=cPo2tFvmLuL6fLvqjzIrpG5LQd6ZWvV9aljHPmVYV9oIi91hq7SbO+hBg0Ef1tnZv/
         y8Kpw/wqFcD4YVj4iq6eINMCPzxoCoeL556+nFs/cIezGZvZ26tghKRDHxKgo2v3m1P6
         a3xfjEZCDBscay3d0wlHtY7gFCrahakcsuViTLI4gk2ISuSIXrCpN/fstZxpNPyaKp8p
         HwfNUYROO68VNeFQ6QD8mC0YCspXYUWalaES/UqK7EPG5+Z8uh2drVV287yRExzoBTzG
         X7GeixClBJda7OLDJWQQCK6lN3ZwIHtmTkBmnb8GWsbxRDOHRrKqV8FWLZQmEBR4pXmO
         Ox5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YkkaXfp503K6bLavwX+qLvL6w0rpc7OLS8RSOtuP+M=;
        b=cFRXz0jVksUu2dvVcm5sH7i7y7WBivna7O7/yNE/HwCKPObhver8p07xfuAeKaKPr/
         jmXSAraZAhxESAe4VjMRpm5+BhHnklPby0xl+MCjqv9DolsXGD8k9ZcKWfzkJeqWuirb
         V3gJgpuKevXJj8zewBQmpwN5JL5/XZAOVMoqWnZYoNwd2ZhL1c0+Cwjs5AuTGB+n/df8
         l6Yr3hzBQENhS42P5YAbGXJbcT2hRFbeMPAYiyqtt/C6tSx5HUuGcp1Kx/fHM2HURE6h
         mecNZHJd9YPvrY8tEN9ReIrQ3m/gUy7ZZdsg87Nz21i7Ej97jU1+4j48tg6ndpQAvPlT
         J9UQ==
X-Gm-Message-State: APjAAAXaA7Fm5Cqa/gXKmYLwmM0Xs0S982Afl+s1Wzla57d+GrIoPRWG
        lRRrDIMZlwy7u5xQ+DMfRkhe6LTAtvRGX57/7j0=
X-Google-Smtp-Source: APXvYqxLgColy907bv+RwBJRyVN1Bx58/q3rCSAwiU5gvj3bLTrGLzMLnM+/DiRXaLqljPpql6cWCfolPagxy7+VP3s=
X-Received: by 2002:ab0:70b1:: with SMTP id q17mr15913997ual.100.1563759468363;
 Sun, 21 Jul 2019 18:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
In-Reply-To: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Mon, 22 Jul 2019 09:37:37 +0800
Message-ID: <CAC=cRTMz5S636Wfqdn3UGbzwzJ+v_M46_juSfoouRLS1H62orQ@mail.gmail.com>
Subject: Re: kernel BUG at mm/swap_state.c:170!
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mikhail,

On Wed, May 29, 2019 at 12:05 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi folks.
> I am observed kernel panic after update to git tag 5.2-rc2.
> This crash happens at memory pressing when swap being used.
>
> Unfortunately in journalctl saved only this:
>
> May 29 08:02:02 localhost.localdomain kernel: page:ffffe90958230000
> refcount:1 mapcount:1 mapping:ffff8f3ffeb36949 index:0x625002ab2
> May 29 08:02:02 localhost.localdomain kernel: anon
> May 29 08:02:02 localhost.localdomain kernel: flags:
> 0x17fffe00080034(uptodate|lru|active|swapbacked)
> May 29 08:02:02 localhost.localdomain kernel: raw: 0017fffe00080034
> ffffe90944640888 ffffe90956e208c8 ffff8f3ffeb36949
> May 29 08:02:02 localhost.localdomain kernel: raw: 0000000625002ab2
> 0000000000000000 0000000100000000 ffff8f41aeeff000
> May 29 08:02:02 localhost.localdomain kernel: page dumped because:
> VM_BUG_ON_PAGE(entry != page)
> May 29 08:02:02 localhost.localdomain kernel: page->mem_cgroup:ffff8f41aeeff000
> May 29 08:02:02 localhost.localdomain kernel: ------------[ cut here
> ]------------
> May 29 08:02:02 localhost.localdomain kernel: kernel BUG at mm/swap_state.c:170!

I am trying to reproduce this bug.  Can you give me some information
about your test case?

Best Regards,
Huang, Ying
