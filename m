Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C0DB2AD4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 11:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfINJ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 05:29:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38694 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfINJ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 05:29:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so5103790wme.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 02:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eVxG27OwEViI7/tRumpCT1qIhZ24HjQJqCKlMI07yoQ=;
        b=ENTA527W3XJ5AowaiOH1ijV44j0QbPNTqWjLI0rty2marCKa0AygLyOXR4KQdlY/GU
         0eJYDyIyW6yDOmTrXsNdzdaZ88SWF8YGeSQacgp7cM5fmW6cwZzB/QyiK4KRlF2dsfPh
         qk6ycy57VledFYO8YsmzE0Fv79WDCwsMteB4Aa5Ynza3e0y/KmRvLGeyiPo8XXw7KW/T
         Qb22j761V87o9Yg0b3eMHATl0NEKYx+iWIxSaP21PMG91hY4HMVo915Sugc7FT1PMy0d
         v6Jw6HqXZyqRgJwgUre0632SU4ZXD3jYbsdGTtLmaygdp0/cYzVvNI3+/leLiw/6vQWs
         KD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eVxG27OwEViI7/tRumpCT1qIhZ24HjQJqCKlMI07yoQ=;
        b=a7zmbus7bPVvjKtlwfbsbn7xxW7gRpwCaPeqQrlSiPPNaeopWkIdZ+/8lOSNn2g+JR
         UBNj8g16Q1Q57Gmf6AYIU6jSUvy5H5s/4an7h/Rm6QFhv+FKX932Af/Tw0LEZw+43+uU
         gQ+1esc7YuClZOpBx/l2JK61hLdNIsttKA/8WGLhc+KLRev/q0ZyYG8JvUtzot2uAjpb
         MsbgQH3PDN7fFEklmlmAaEO/cq9O70Hxq4KUgh4yxlK3t1rjBLmRt46ZCyN8bEPef2Pr
         HywcSjGby01vjShg1l/zRt0E+UiFnRopKrPTfq1zLKShwRJmF088gAqK+6qrtVuFUJ9J
         tdGg==
X-Gm-Message-State: APjAAAVBwEjbtg06604q5cPfKFZ/GsjXzQjb9G7izLn45do8JJvwn79Q
        gu9kUHDIiICe4PPu0q2xpw==
X-Google-Smtp-Source: APXvYqyHdW6FEwTKJaeWLAR0XwwHkMFe6PPO/R7CR/ZVyIe9hLZ/R+zDZZsyFQJv0vHWChAG4PrIbw==
X-Received: by 2002:a1c:80c6:: with SMTP id b189mr7009076wmd.34.1568453358838;
        Sat, 14 Sep 2019 02:29:18 -0700 (PDT)
Received: from avx2 ([46.53.250.254])
        by smtp.gmail.com with ESMTPSA id j22sm57011896wre.45.2019.09.14.02.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2019 02:29:17 -0700 (PDT)
Date:   Sat, 14 Sep 2019 12:29:15 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     bp@alien8.de
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
        linux@rasmusvillemoes.dk, torvalds@linux-foundation.org
Subject: Re: [RFC] Improve memset
Message-ID: <20190914092915.GA17409@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Instead of calling memset:
> 
> ffffffff8100cd8d:       e8 0e 15 7a 00          callq  ffffffff817ae2a0 <__memset>
> 
> and having a JMP inside it depending on the feature supported, let's simply
> have the REP; STOSB directly in the code:
> 
> ...
> ffffffff81000442:       4c 89 d7                mov    %r10,%rdi
> ffffffff81000445:       b9 00 10 00 00          mov    $0x1000,%ecx
> 
> <---- new memset
> ffffffff8100044a:       f3 aa                   rep stos %al,%es:(%rdi)
> ffffffff8100044c:       90                      nop
> ffffffff8100044d:       90                      nop
> ffffffff8100044e:       90                      nop

You can fit entire "xor eax, eax; rep stosb" inside call instruction.

> /* clobbers used by memset_orig() and memset_rep_good() */
>                 : "rsi", "rdx", "r8", "r9", "memory");

eh... I'd just drop it. These registers screw up everything.

Time to rebase memset0().
