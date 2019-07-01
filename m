Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61808F1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfD3HxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 03:53:19 -0400
Received: from mx1.yrkesakademin.fi ([85.134.45.194]:32202 "EHLO
        mx1.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3HxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:53:18 -0400
Subject: Re: perf build broken in 5.1-rc7
From:   Thomas Backlund <tmb@mageia.org>
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>
References: <560abacf-da1d-7f55-755c-2086096bdf2c@mageia.org>
Message-ID: <fff8c124-505c-91b7-ff4b-cabca894b689@mageia.org>
Date:   Tue, 30 Apr 2019 10:53:14 +0300
MIME-Version: 1.0
In-Reply-To: <560abacf-da1d-7f55-755c-2086096bdf2c@mageia.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-WatchGuard-Spam-ID: str=0001.0A0C0204.5CC7FEEC.0078,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.194
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den 30-04-2019 kl. 10:26, skrev Thomas Backlund:
> 
> Building perf in 5.1-rc5/6/7 fails:
> 
> 
> Build start:
> 
> 
>  �make -s -C tools/perf NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 
> WERROR=0 NO_LIBUNWIND=1 HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_STRLCPY=1 
> NO_BIONIC=1 NO_JVMTI=1 prefix=/usr lib=lib64 all
>  � BUILD:�� Doing 'make -j32' parallel build
>  � HOSTCC�� fixdep.o
>  � HOSTLD�� fixdep-in.o
>  � LINK���� fixdep
> Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/vmx.h' 
> differs from latest version at 'arch/x86/include/uapi/asm/vmx.h'
> diff -u tools/arch/x86/include/uapi/asm/vmx.h 
> arch/x86/include/uapi/asm/vmx.h
> 
> Auto-detecting system features:
> ...������������������������ dwarf: [ on� ]
> ...����������� dwarf_getlocations: [ on� ]
> ...������������������������ glibc: [ on� ]
> ...������������������������� gtk2: [ on� ]
> ...��������������������� libaudit: [ on� ]
> ...����������������������� libbfd: [ on� ]
> ...����������������������� libelf: [ on� ]
> ...���������������������� libnuma: [ on� ]
> ...������� numa_num_possible_cpus: [ on� ]
> ...���������������������� libperl: [ on� ]
> ...�������������������� libpython: [ on� ]
> ...��������������������� libslang: [ on� ]
> ...�������������������� libcrypto: [ on� ]
> ...�������������������� libunwind: [ on� ]
> ...����������� libdw-dwarf-unwind: [ on� ]
> ...������������������������� zlib: [ on� ]
> ...������������������������� lzma: [ on� ]
> ...�������������������� get_cpuid: [ on� ]
> ...�������������������������� bpf: [ on� ]
> ...����������������������� libaio: [ on� ]
> ...������� disassembler-four-args: [ OFF ]
> 
> Makefile.config:473: No sys/sdt.h found, no SDT events are defined, 
> please install systemtap-sdt-devel or systemtap-sdt-dev
> Makefile.config:853: No libbabeltrace found, disables 'perf data' CTF 
> format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> 
> 
> And breaks with:
> 
> 
> CC������ ui/setup.o
> util/annotate.c: In function 'symbol__disassemble_bpf':
> util/annotate.c:1767:29: error: incompatible type for argument 1 of 
> 'disassembler'
>  � disassemble = disassembler(bfdf);
>  ���������������������������� ^~~~
> In file included from util/annotate.c:1689:
> /usr/include/dis-asm.h:325:63: note: expected 'enum bfd_architecture' 
> but argument is of type 'bfd *' {aka 'struct bfd *'}
>  �extern disassembler_ftype disassembler (enum bfd_architecture arc,
>  ���������������������������������������� ~~~~~~~~~~~~~~~~~~~~~~^~~
> util/annotate.c:1767:16: error: too few arguments to function 
> 'disassembler'
>  � disassemble = disassembler(bfdf);
>  ��������������� ^~~~~~~~~~~~
> In file included from util/annotate.c:1689:
> /usr/include/dis-asm.h:325:27: note: declared here
>  �extern disassembler_ftype disassembler (enum bfd_architecture arc,
>  �������������������������� ^~~~~~~~~~~~
>  � CC������ arch/x86/util/header.o
>  � CC������ arch/x86/util/tsc.o
>  � CC������ arch/x86/util/pmu.o
> mv: cannot stat 'util/.annotate.o.tmp': No such file or directory
>  � CC������ bench/futex-requeue.o
>  � CC������ arch/x86/util/kvm-stat.o
> make[4]: *** 
> [/work/rpmbuild/BUILD/kernel-x86_64/linux-5.0/tools/build/Makefile.build:97: 
> util/annotate.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>  � CC������ util/build-id.o
> 
> 
>


And I forgot...

Reverting:
 From 6987561c9e86eace45f2dbb0c564964a63f4150a Mon Sep 17 00:00:00 2001
From: Song Liu <songliubraving@fb.com>
Date: Mon, 11 Mar 2019 22:30:48 -0700
Subject: perf annotate: Enable annotation of BPF programs

Makes it build again.

--
Thomas

