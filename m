Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAEE147030
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 18:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgAWR7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 12:59:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41751 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:59:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so4572292ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 09:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdFWsGYP+/xokr+Jc40CYV8I3yOJTReQRwsZpMafAIU=;
        b=eYCXt9KuCjSWsxKT/LS/oRbB0oCaiHnqj4H6RJ7QasqoCu3gRsmkjJE0XL+lw9FM4Z
         Utq4fAiOjg0fs8R1CeLtZy+7kX5ZX+QDtdxpqRuAg+ACSnejnWkdBli2iyS3I+Y8xyg8
         2ry2FHh/zgNd68ry0JVzr2TgceUB6QJzCCqn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdFWsGYP+/xokr+Jc40CYV8I3yOJTReQRwsZpMafAIU=;
        b=N8TR4rYoKcFgpku8kGKb3NAHJRnRGFmMyt8RGKGXMsMRQeeqvHjPFVfJaeASBazbi8
         5OYGe4ZcvKZPUZnIRLZWSpBGWYh3iYnkhJPFCWQAIiNqpGpa1mT7b9YXUeSjYgEpjAn8
         ZyaMxhWZCFAVfO1NMhacxQWaIERQ5PRdj4c+Y34uExtL5nqY0vbBSjnlFGYdMuqcL2G4
         STjYe4w6Si2nmlvm0R3wnbTpPfSRQc7m18mwUyQhvFrVpj4D95SLYa8x1mK/jt2DJvgs
         HLLbPU8O8andw4GKW7kuwsO/g+cqeN1sehCTVXu30E5GB9oVBSSK4yUVyDivkSyOGmaU
         SpFw==
X-Gm-Message-State: APjAAAWstzEZ9rQMeUbmJ4nEgGk/XICx5Jqkekh8lDUd1YTMyoATe3Qz
        4e3t/S+qs+oGM8f/2b6U4hfxOcfzlAU=
X-Google-Smtp-Source: APXvYqx88QNgtdEmtho+vLWzDEHgNBuyw/BSk+8qsyD/zI5yKpeYZT2tTGaAkLyIi18Fnuumfj/GZw==
X-Received: by 2002:a2e:548:: with SMTP id 69mr23746742ljf.67.1579802360206;
        Thu, 23 Jan 2020 09:59:20 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id d26sm1446593lfa.44.2020.01.23.09.59.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 09:59:19 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id a13so4553566ljm.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 09:59:19 -0800 (PST)
X-Received: by 2002:a2e:9510:: with SMTP id f16mr23701334ljh.249.1579802359199;
 Thu, 23 Jan 2020 09:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org>
In-Reply-To: <20200123153341.19947-1-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 09:59:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
Message-ID: <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 7:33 AM Will Deacon <will@kernel.org> wrote:
>
> This is version two of the patches I previously posted as an RFC here:

Looks fine to me, as far as I can tell,

              Linus
