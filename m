Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C91112874
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 10:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfLDJvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 04:51:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36763 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfLDJvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:51:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so7107121wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 01:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+MqMdaqYA9wxrEDifn792XFhLysGc8RSGDMrug+w3U=;
        b=Przb2Mp6fXtj52PQek5CbvK0m72zcxvl/tkEZHPbnWSa++nCWSJZZmS9++pPkRXrHG
         BmP235WX29P6BS93AZhlst2RD7hH2WoH2RVk3T/9HoyC4AgEsDCHcd1EHI0AlYUuXjJe
         dI3x/0u7OgFjrMrvJ6WcKeOUmYgR0U1yn16Yy5SlGY6ZJDeX94v6WUG23ht7i1IPjrMw
         okf5mTcha9+T7jwil9n90t9RCeixq59sYXp9pI34nZ9pevxFrWCHHd0Suk3OvMD0bdvY
         NyMXQL9g/QB8vKBbvg2D257IjR/amd+XQRUdX4R+nQbtGGP3uveM6gu9gV1MrkTo+DW+
         pA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+MqMdaqYA9wxrEDifn792XFhLysGc8RSGDMrug+w3U=;
        b=SrfzotT6rQ+GHDcTINGna8xGeqRakB9LXWuv5vgIaMLlqBojvCV4Nf9Gtwt5zzrWQk
         WvMqpl6gIqGQW3RMZQThkN8qCUSw7fENj4VL4Rqnz4YysxzQYFfNZH2FWQzIs8ULhMKx
         jnTeJw5+UPJstWm7EbqdFolZTJv3K3Y/Qlf0DEXOFtMpRGgxq8NaJe5nTq5wury620hO
         qgZ5wzEiFOSFFvVJ8YhCE5R27Mj5aINqTNA55FlMWkqUV4fYInYzJPl2c5dJM8V8ciCm
         q5vB8+ya4NERfcHE/8N/mVAzPArB9SrY7Ihv/5vt5EXchEhJTP6uNvF+NAT/OoleNkMp
         +s5Q==
X-Gm-Message-State: APjAAAVif3FqnYcdV9cMHXymiwIL3slBu3yF9jMQ/aDHli9UmUZ0vphk
        IimkabQb2P7sb8lC2UgzdXTgMELH1lI9LlhNSystwQ==
X-Google-Smtp-Source: APXvYqzLvQuJFDKa5YEtxpmabNfV3tNQmNC8LrgshglGnlL4aV86T/kP4WSpVw03YPNpB05E/92NdOuel+uj0rhMQXU=
X-Received: by 2002:a05:600c:141:: with SMTP id w1mr18577201wmm.61.1575453077074;
 Wed, 04 Dec 2019 01:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20191203201410.28045-1-msys.mizuma@gmail.com>
In-Reply-To: <20191203201410.28045-1-msys.mizuma@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Dec 2019 09:51:13 +0000
Message-ID: <CAKv+Gu-teb+3a29cZVc0cxZrXonQeO-EtPugPaQ1QFbeBYjGTw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] efi: arm64: Introduce /proc/efi/memreserve to tell
 the persistent pages
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        d.hatayama@fujitsu.com, Eric Biederman <ebiederm@xmission.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019 at 20:14, Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>
> kexec reboot sometime fails in early boot sequence on aarch64 machine.
> That is because kexec overwrites the LPI property tables and pending
> tables with the initrd.
>
> To avoid the overwrite, introduce /proc/efi/memreserve to tell the
> tables region to kexec so that kexec can avoid the memory region to
> locate initrd.
>
> kexec also needs a patch to handle /proc/efi/memreserve. I'm preparing
> the patch for kexec.
>
> Changelog
>     v2: - Change memreserve file location from sysfs to procfs.
>           memreserve may exceed the PAGE_SIZE in case efi_memreserve_root
>           has a lot of entries. So we cannot use sysfs_kf_seq_show().
>           Use seq_printf() in procfs instead.
>
> Masayoshi Mizuma (2):
>   efi: add /proc/efi directory
>   efi: arm64: Introduce /proc/efi/memreserve to tell the persistent
>     pages
>

Apologies for the tardy response.

Adding /proc/efi is really out of the question. *If* we add any
special files to expose this information, it should be under sysfs.

However, this is still only a partial solution, since it only solves
the problem for userspace based kexec, and we need something for
kexec_file_load() as well.

The fundamental issue here is that /proc/iomem apparently lacks the
entries that describe these regions as 'reserved', so we should try to
address that instead.
