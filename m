Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646879E7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 14:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfH0MaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 08:30:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44468 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfH0MaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:30:24 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so21013718qtg.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=o/st+xfPrEf5neMYSfQiCblpDGrPvpIPRZXQLxNBf/U=;
        b=hqJA8BcRpFJMepQqy1WMAOSeJ/z436sdhHCQp1nXeoKgSFD4Q8U9eGX2zrwLtOmfJs
         FnxUbhTIMxwN74zUlTDBXhek/7zM1dZiF/0V6wVTYlJi+d8LLv5zAKJwzVc9sHe0Hs+D
         3BTRjpB2/6eoMrOifPImvPfAv1TOsei4YjgFh5Wp9x7Cp+NO1QqWEicj1KhecWwEmyKU
         n6P091ivhdkqzKV2K5L+gK98dIrQFKpUljJGmuhUoWAH5ogVtuVz8siwVKRvPbPYXK00
         mcVC4bgGhsJ0i/+yMmtbUkArSWlohcX6JUEca7kTxLV7+ddIKrQAfQgUTqwmxKqUhAh1
         e/DQ==
X-Gm-Message-State: APjAAAVqZdSU/0ACM9LnjS5VuuWVkAhXjNu7mLaB8pBipuH/yvOAbIUz
        QWJBaxhtYiv6tNkymfwIntrBkPOk8rm1oYA1FSfKahi039w=
X-Google-Smtp-Source: APXvYqxR4V2m4EzLzq7hQ6OAB3nXVssdbbBKe+dsLEETN6uhTbHHlgAbrDmgedZiWCGoXH2ZK77Ze9pwd07LNlfAHB0=
X-Received: by 2002:ac8:2955:: with SMTP id z21mr22350616qtz.204.1566909023051;
 Tue, 27 Aug 2019 05:30:23 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Aug 2019 14:30:06 +0200
Message-ID: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
Subject: objtool warning "uses BP as a scratch register" with clang-9
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded to the latest clang-9 snapshot from http://apt.llvm.org/ today.
Many problems are fixed, but I still get tons of warnings like

arch/x86/kernel/cpu/mtrr/generic.o: warning: objtool:
mtrr_type_lookup_variable uses BP as a scratch register
arch/x86/kernel/process.o: warning: objtool: get_tsc_mode()+0x21: call
without frame pointer save/setup
arch/x86/kernel/early_printk.o: warning: objtool: early_vga_write uses
BP as a scratch register
arch/x86/kernel/sysfb_simplefb.o: warning: objtool: parse_mode uses BP
as a scratch register
arch/x86/kernel/head64.o: warning: objtool: __startup_64 uses BP as a
scratch register
kernel/time/timeconv.o: warning: objtool: time64_to_tm uses BP as a
scratch register
kernel/trace/ring_buffer.o: warning: objtool:
ring_buffer_discard_commit uses BP as a scratch register
...

I created a reduced test case:

$ cat crc32.i
typedef unsigned u32;
long a, c;
u32 b, f;
u32 *d, *e;
void fn1() {
  u32 *g = &f, *h = e, *i = d;
  for (; a < c; a++)
    b = i[b >> 8 & 255] ^ h[b] ^ g[5];
}
$ clang-9 -c  crc32.i  -O2   ; objtool check  crc32.o
crc32.o: warning: objtool: fn1 uses BP as a scratch register
$ objdump -d crc32.o
0000000000000000 <fn1>:
   0: 55                    push   %rbp
   1: 53                    push   %rbx
   2: 4c 8b 05 00 00 00 00 mov    0x0(%rip),%r8        # 9 <fn1+0x9>
   9: 48 8b 05 00 00 00 00 mov    0x0(%rip),%rax        # 10 <fn1+0x10>
  10: 4c 39 c0              cmp    %r8,%rax
  13: 7e 7f                jle    94 <fn1+0x94>
  15: 48 8b 0d 00 00 00 00 mov    0x0(%rip),%rcx        # 1c <fn1+0x1c>
  1c: 48 8b 15 00 00 00 00 mov    0x0(%rip),%rdx        # 23 <fn1+0x23>
  23: 8b 1d 00 00 00 00    mov    0x0(%rip),%ebx        # 29 <fn1+0x29>
  29: 8b 35 00 00 00 00    mov    0x0(%rip),%esi        # 2f <fn1+0x2f>
  2f: 89 c7                mov    %eax,%edi
  31: 44 29 c7              sub    %r8d,%edi
  34: 40 f6 c7 01          test   $0x1,%dil
  38: 75 05                jne    3f <fn1+0x3f>
  3a: 4c 89 c7              mov    %r8,%rdi
  3d: eb 15                jmp    54 <fn1+0x54>
  3f: 0f b6 ff              movzbl %bh,%edi
  42: 8b 1c 99              mov    (%rcx,%rbx,4),%ebx
  45: 33 1c ba              xor    (%rdx,%rdi,4),%ebx
  48: 31 f3                xor    %esi,%ebx
  4a: 89 1d 00 00 00 00    mov    %ebx,0x0(%rip)        # 50 <fn1+0x50>
  50: 49 8d 78 01          lea    0x1(%r8),%rdi
  54: 49 83 c0 01          add    $0x1,%r8
  58: 4c 39 c0              cmp    %r8,%rax
  5b: 74 30                je     8d <fn1+0x8d>
  5d: 0f 1f 00              nopl   (%rax)
  60: 0f b6 ef              movzbl %bh,%ebp
  63: 89 db                mov    %ebx,%ebx
  65: 8b 1c 99              mov    (%rcx,%rbx,4),%ebx
  68: 33 1c aa              xor    (%rdx,%rbp,4),%ebx
  6b: 31 f3                xor    %esi,%ebx
  6d: 89 1d 00 00 00 00    mov    %ebx,0x0(%rip)        # 73 <fn1+0x73>
  73: 0f b6 ef              movzbl %bh,%ebp
  76: 8b 1c 99              mov    (%rcx,%rbx,4),%ebx
  79: 33 1c aa              xor    (%rdx,%rbp,4),%ebx
  7c: 31 f3                xor    %esi,%ebx
  7e: 89 1d 00 00 00 00    mov    %ebx,0x0(%rip)        # 84 <fn1+0x84>
  84: 48 83 c7 02          add    $0x2,%rdi
  88: 48 39 c7              cmp    %rax,%rdi
  8b: 7c d3                jl     60 <fn1+0x60>
  8d: 48 89 3d 00 00 00 00 mov    %rdi,0x0(%rip)        # 94 <fn1+0x94>
  94: 5b                    pop    %rbx
  95: 5d                    pop    %rbp
  96: c3                    retq

This happens with clang-9 and clang-10 at the moment, but not clang-8.

        Arnd
