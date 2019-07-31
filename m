Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A537C4AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 16:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfGaOSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 10:18:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40270 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbfGaOSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:18:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so49338946qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pZwBqSPI7kZUNMhvkQqn/Q+HROtavtkt4ZCkBXHBYb4=;
        b=Sf9uTf9U8YmEXpmM6gWDwEQ8rqZH3N1L/uy+9YnCDmoGM7ReRfVqecS0r5FnF0ypFx
         bwAvHqTnT5WZuK9mOt6zQAxQB59A8FkZkY9eemVyVT173IKW/c5hkT3wQSfG+nb9yJXK
         DvbdPZr3RVMfCXuDqYLwuybkysUA+LiJAS0E2+xvs0F77xYU4+xBVSRIWIZAVWIIMTHL
         V/JQDdjf1lNtJl2qwYJlV4CxRChCCDNMi1OFwOPX1UV8h4cA3QppQygz4JhKLQZzOiWZ
         cQyoGtzL03MvqHMxssG/tF0HPQ0VTN067K/2CW0B0hoCO0Vz6+lZwMf1pRBcxBbsc9Nb
         Lfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pZwBqSPI7kZUNMhvkQqn/Q+HROtavtkt4ZCkBXHBYb4=;
        b=Xc7z9VAX/GOM9QYyCEzQGVWj+fUwKwGADRpQOVB/bx1fjzA1wDpLP4/tdd0zYObkYQ
         mJoh533gQ70/NoqMq+bN9VHVQGvImXTdMuHlo2gw80puln3yzaNfdOLnJta+2FlASK+L
         anSs1cit/pDntwObqBHhQy/pEsji1MptBBCeM6CJxxPluyRz/Dbe/p2pDUF5gqA/bOUV
         di//QsqFzqECKOVARA0+LLwS3wKD/RmostnGpgS64lirit3w5NQnW0fn85JNtT0aIp3O
         rD8dRC4Ak2XeiP8xAUe26jgbZUchXa3PdDEKMgOwH6KlSuk0/zg8l7cUMxaHGNGxtELA
         My1w==
X-Gm-Message-State: APjAAAVz0pFWXO13Qcqc/eztPYzq7rKQWl/Ke+eS6eUCZL1txO+Wk1mT
        Cg8PFowp1be5camz3ap/CaoRjwhRUX3JMcFPR2vIzJ8I
X-Google-Smtp-Source: APXvYqz5MfJrrU5qvsZqdm06PLaV+jCGIsG8HvCM0w3S1lWbzKbbYha0wV+Y/U//PqDHeKbbWrGoXKPttCJd0LoPWcs=
X-Received: by 2002:ae9:e217:: with SMTP id c23mr38710557qkc.227.1564582727093;
 Wed, 31 Jul 2019 07:18:47 -0700 (PDT)
MIME-Version: 1.0
From:   Mark Vegans <ihavenomoneybuthope@gmail.com>
Date:   Wed, 31 Jul 2019 16:18:35 +0200
Message-ID: <CAGdkbuwC8dTTUXdq9TkdH02BkTLmxWob71r0kvxvoubAuRr+2Q@mail.gmail.com>
Subject: cannot build with no-inline-functions
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi *,
I'm analyzing the linux kernel via phasar static analyzer framework,
it basically takes as input an LLVM IR file.
For debugging reasons, I would like to compile the kernel without
inlined functions. I'm compiling the kernel by clang, so I tried to
specify the following compiler flags:

```
-fno-inline-functions
-O1
```

Those were specified via KCFLAGS keyword in the root Makefile, I
generated the compile_commands.json file as well where I can see that
those flags above were used for the building process.

Unfortunately it did not work as I wanted, in the resulting LLVM IR I
still see inlined functions.
Is it possible to avoid inlined functions for the whole kernel via a
compiler flag? or any other suggestions?

thanks,
cheers
