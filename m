Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1CE4CEE63
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 23:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfJGVYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 17:24:32 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35468 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbfJGVYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:24:31 -0400
Received: by mail-ua1-f68.google.com with SMTP id n63so4559409uan.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtdz6MVtYHywhBENAE676gRhNyUtv8gAoEkfWav5ZEE=;
        b=jda3vWTj0miv5Am77DVta9H3DhF8wa5FxKVgdI4uE3Hf3y5VolZNdaSZuMVFuSa8ND
         CCPsWw6RrkFA8ESPKSBAZTfBAIcrgIXPC/x2M830dN7PeJm3um62G+1lnr4CN2uDqd/y
         H01jkLXXB6MV8d3lkx6lhEYcl1WOMXIfZ9DPgu0ZQjGpsjeIhvZrx/VkFH0ZtdlkL7Ky
         vleIsngnbLNonANVIWsxTZr0YmPKOl5EciCZeoLHvehGpV8NkLn7Vk12Ox3bqdLHZJOe
         tNvFi+V0b0H9qkb3AesU7ku3TJxUpXizb3Cnx34xFg+AgVGURFUEaS6I55ROgfmWCA83
         2iSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtdz6MVtYHywhBENAE676gRhNyUtv8gAoEkfWav5ZEE=;
        b=EqilejyYVoG22/gp1dFd8moOQQaZOVG6FGixqz2OoxLFcJcAg6wCBsKalpmXqTOH6h
         dvisIgi9vvDLHtcSD7qeYlrU0WRhY+rAWGrhEQaGgDjRAyLZrZPTQaE6eU09i3WgZQGA
         mMYCeOaKChtO26Ei98bjn8/UQCzOXBQ0/rZMJq2F54vGq+Jp8XY9WhTKvi5X3PY22bbw
         28RiZCZ4Y/L5I26tcNxNCniXjCL/CfEf0SVLDv1oHICT2OvGbYlOI+UaFXsvsTVQncYR
         sfLQ3qrkgj+i2EYo/go07EXBwDgCNd7s25QpiBoTyS1vogLw3bpG6U80CKkkzW2K/PPu
         7vfg==
X-Gm-Message-State: APjAAAXlo0C28g0GYqxmBBSxqP8An0eJBi9wqPtQMQJxnzFqb1dPLIEN
        bVpbwPg5LTi8FBF00vSf4tknjPs57VUIpYFUxz8wIQ==
X-Google-Smtp-Source: APXvYqxpgwy0BoI9XN74BCjJ5c7Z7Gv6hOoSj196SzYRlfhhtl2bzG4e9xDKY8vt5g+W0Z3weotG80/1mMTbAVb2YBo=
X-Received: by 2002:ab0:77cc:: with SMTP id y12mr4639713uar.110.1570483469932;
 Mon, 07 Oct 2019 14:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191007201452.208067-1-samitolvanen@google.com> <CAKwvOdmaMaO-Gpv2x0CWG+CRUCNKbNWJij97Jr0LaRaZXjAiTA@mail.gmail.com>
In-Reply-To: <CAKwvOdmaMaO-Gpv2x0CWG+CRUCNKbNWJij97Jr0LaRaZXjAiTA@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 7 Oct 2019 14:24:18 -0700
Message-ID: <CABCJKufxncBPOx6==57asbMF_On=g1sZAv+w6RnqHJFSwOSeTw@mail.gmail.com>
Subject: Re: [PATCH] arm64: lse: fix LSE atomics with LLVM's integrated assembler
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 1:28 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> I tried adding `.arch armv8-a+lse` directives to all of the inline asm:
> https://github.com/ClangBuiltLinux/linux/issues/573#issuecomment-535098996

Yes, I had a similar patch earlier. I feel like using a command line
parameter here is cleaner, but I'm fine with either solution.

> One thing to be careful about is that blankets the entire kernel in
> `+lse`, allowing LSE atomics to be selected at any point.

Is that a problem? The current code allows LSE instructions with gcc
in any file that includes <asm/lse.h>, which turns out to be quite a
few places.

Sami
