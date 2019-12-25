Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047DD12A5D0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 04:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLYDYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 22:24:31 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46797 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLYDYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 22:24:30 -0500
Received: by mail-io1-f65.google.com with SMTP id t26so20521809ioi.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 19:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUAxQSRBnLaLxVug1L0lFtz8w6DTvcYtj+Zp52pVaHU=;
        b=fEfSZPwdBlEy9JhGU1wOVx9YvWDC26anUffx/qIIoGS9NgwbSXp0qgTu6envie+SOB
         eBpUTxtF1/FY/Q5S1uzlwMsmtX1gw1bBOFLMVFVL3/tBHgGS+i4xjrmsWTKgIwAnfmp/
         UcLRROdahZ447jqpTx/YJOTKP6xBtiHTnRJPisRpIADdLhhhQZPEShRPXEorAHtMoPgj
         irc8+ZM+T9QKaq6mi6OgKydw8NrivGCHli7HVmnAmJpvKwKOeTZlMB1W2hBVSTgJy1co
         gNglpAMFbFX0aq+luFDHQDf/7hNB2P0ws0GwdcaacgXxZS8l37wAP7LHZq9L/L0J5G5q
         N4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUAxQSRBnLaLxVug1L0lFtz8w6DTvcYtj+Zp52pVaHU=;
        b=SDH+qqQ2BzkfHJWTAzY3r4hjtAeaRQFLW99hFRI6k3JWc93dZ27ooQFat3yMtwJMtj
         vPqZsxvxOE/5K3jMqQqBO8snYc4/n68emwpK31mgoi3iXJoIKUHsmkQ9VvYW1KW+VGm5
         QLSqDLuJ7W6dyb9v2r4gEnTyxx/TrI/x5H7yr4BE0EN4yzx67YHkjQK0RyM+j15OOskk
         aDWvWN645rTwi2amDo1aLROuaKIZCrldAaEnKsoIVl9L2VMB2Ob61VZrj+ZtXWLP4FhV
         MTtj172Jd4pMONuD10RGfRaTpFNraaofAq0FYvLdHNPgi044aE8PJ3JVEKB5A/P/+Xzf
         N23Q==
X-Gm-Message-State: APjAAAW1rBcf/I7ADr5Rb/28uJE1JVuLHXaLelsBSuwgSZG7CRf4cdQv
        Z4hU6FYnP674oNZOaKkmDEg6+R2cqM2VVWcC9AM=
X-Google-Smtp-Source: APXvYqxgIRLM6rPqrpD6PEc+/SFCgf+ePKbksISde0uqfWO1OQgRqUUHQRMdt/dKxnRG/Oh5OabpOzU+wXCfocDKSQ0=
X-Received: by 2002:a5d:9e15:: with SMTP id h21mr26833842ioh.132.1577244269985;
 Tue, 24 Dec 2019 19:24:29 -0800 (PST)
MIME-Version: 1.0
References: <1574694943-7883-1-git-send-email-yingjie_bai@126.com>
 <87pngglmxg.fsf@mpe.ellerman.id.au> <CAFAt38F-YQUVNXEnLut0tMivYUy_OTK7G4wAHfddcmncsEpREQ@mail.gmail.com>
 <9e680f3798f1a771cba4b41f7a5d7fda7f534522.camel@buserror.net>
In-Reply-To: <9e680f3798f1a771cba4b41f7a5d7fda7f534522.camel@buserror.net>
From:   Yingjie Bai <byj.tea@gmail.com>
Date:   Wed, 25 Dec 2019 11:24:18 +0800
Message-ID: <CAFAt38FnH376ioDuvyNJW=iOxbcooRRsEeVEfDudRoV4gG98SQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc85xx: also write addr_h to spin table for
 64bit boot entry
To:     Scott Wood <oss@buserror.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, yingjie_bai@126.com,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

__pa() returns 64bit in my setup.

in arch/powerpc/include/asm/page.h

#if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + VIRT_PHYS_OFFSET))
#define __pa(x) ((unsigned long)(x) - VIRT_PHYS_OFFSET)
#else
#ifdef CONFIG_PPC64
...



/* See Description below for VIRT_PHYS_OFFSET */
#if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
#ifdef CONFIG_RELOCATABLE
#define VIRT_PHYS_OFFSET virt_phys_offset
#else
#define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
#endif
#endif

and VIRT_PHYS_OFFSET is a variable, virt_phys_offset, which is long long
in arch/powerpc/mm/init_32.c
#ifdef CONFIG_RELOCATABLE
/* Used in __va()/__pa() */
long long virt_phys_offset;
EXPORT_SYMBOL(virt_phys_offset);
#endif


my config has
CONFIG_RELOCATABLE=y
CONFIG_BOOKE=y
CONFIG_FSL_BOOKE=y
CONFIG_PPC_FSL_BOOK3E=y
CONFIG_PPC_BOOK3E_MMU=y
CONFIG_FSL_SOC_BOOKE=y
CONFIG_FSL_CORENET_RCPM=y
CONFIG_CORENET_GENERIC=y
CONFIG_VDSO32=y
CONFIG_PPC32=y
CONFIG_32BIT=y
CONFIG_ARCH_HAS_ILOG2_U32=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_PPC64 is not set
CONFIG_PTE_64BIT=y
CONFIG_PHYS_64BIT=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_XZ_DEC_IA64=y
CONFIG_GENERIC_ATOMIC64=y
# CONFIG_ATOMIC64_SELFTEST is not set
CONFIG_PRINT_STACK_DEPTH=64


Here is my .config taken from a customized kernel, version 4.9
#
# Automatically generated file; DO NOT EDIT.
# Linux/powerpc 4.9.79 Kernel Configuration
#
# CONFIG_PPC64 is not set

#
# Processor support
#
# CONFIG_PPC_BOOK3S_32 is not set
CONFIG_PPC_85xx=y
# CONFIG_PPC_8xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_E200 is not set
CONFIG_E500=y
CONFIG_PPC_E500MC=y
CONFIG_PPC_FPU=y
CONFIG_FSL_EMB_PERFMON=y
CONFIG_FSL_EMB_PERF_EVENT=y
CONFIG_FSL_EMB_PERF_EVENT_E500=y
CONFIG_BOOKE=y
CONFIG_FSL_BOOKE=y
CONFIG_PPC_FSL_BOOK3E=y
CONFIG_PTE_64BIT=y
CONFIG_PHYS_64BIT=y
CONFIG_PPC_MMU_NOHASH=y
CONFIG_PPC_BOOK3E_MMU=y
# CONFIG_PPC_MM_SLICES is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=4
CONFIG_PPC_DOORBELL=y
CONFIG_VDSO32=y
CONFIG_CPU_BIG_ENDIAN=y
CONFIG_PPC32=y
CONFIG_32BIT=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_MMU=y
# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
# CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set
CONFIG_NR_IRQS=512
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_LOCKBREAK=y
CONFIG_ARCH_HAS_ILOG2_U32=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK=y
CONFIG_PPC=y
# CONFIG_GENERIC_CSUM is not set
CONFIG_EARLY_PRINTK=y
CONFIG_PANIC_TIMEOUT=180
CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_PPC_UDBG_16550=y
CONFIG_GENERIC_TBSYNC=y
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
# CONFIG_EPAPR_BOOT is not set
CONFIG_DEFAULT_UIMAGE=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
# CONFIG_PPC_DCR_NATIVE is not set
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_PPC_ADV_DEBUG_REGS=y
CONFIG_PPC_ADV_DEBUG_IACS=2
CONFIG_PPC_ADV_DEBUG_DACS=2
CONFIG_PPC_ADV_DEBUG_DVCS=0
CONFIG_PPC_ADV_DEBUG_DAC_RANGE=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y

#
# Platform support
#
# CONFIG_PPC_CELL is not set
# CONFIG_PPC_CELL_NATIVE is not set
# CONFIG_PQ2ADS is not set
CONFIG_FSL_SOC_BOOKE=y
# CONFIG_BSC9131_RDB is not set
# CONFIG_C293_PCIE is not set
# CONFIG_BSC9132_QDS is not set
# CONFIG_MPC8540_ADS is not set
# CONFIG_MPC8560_ADS is not set
# CONFIG_MPC85xx_CDS is not set
# CONFIG_MPC85xx_MDS is not set
# CONFIG_MPC8536_DS is not set
# CONFIG_MPC85xx_DS is not set
# CONFIG_MPC85xx_RDB is not set
# CONFIG_P1010_RDB is not set
# CONFIG_P1022_DS is not set
# CONFIG_P1022_RDK is not set
# CONFIG_P1023_RDB is not set
# CONFIG_TWR_P102x is not set
# CONFIG_SOCRATES is not set
# CONFIG_KSI8560 is not set
# CONFIG_XES_MPC85xx is not set
# CONFIG_STX_GP3 is not set
# CONFIG_TQM8540 is not set
# CONFIG_TQM8541 is not set
# CONFIG_TQM8548 is not set
# CONFIG_TQM8555 is not set
# CONFIG_TQM8560 is not set
# CONFIG_SBC8548 is not set
# CONFIG_PPA8548 is not set
# CONFIG_GE_IMP3A is not set
# CONFIG_SGY_CTS1000 is not set
# CONFIG_MVME2500 is not set
# CONFIG_PPC_QEMU_E500 is not set
CONFIG_CORENET_GENERIC=y
# CONFIG_KVM_GUEST is not set
CONFIG_EPAPR_PARAVIRT=y
CONFIG_PPC_SMP_MUXED_IPI=y
# CONFIG_IPIC is not set
CONFIG_MPIC=y
# CONFIG_MPIC_TIMER is not set
CONFIG_PPC_EPAPR_HV_PIC=y
# CONFIG_MPIC_WEIRD is not set
CONFIG_MPIC_MSGR=y
# CONFIG_PPC_I8259 is not set
# CONFIG_PPC_RTAS is not set
# CONFIG_MMIO_NVRAM is not set
# CONFIG_MPIC_U3_HT_IRQS is not set
# CONFIG_PPC_MPC106 is not set
# CONFIG_PPC_970_NAP is not set
# CONFIG_PPC_P7_NAP is not set



On Wed, Dec 25, 2019 at 9:25 AM Scott Wood <oss@buserror.net> wrote:
>
> On Tue, 2019-12-24 at 09:35 +0800, Yingjie Bai wrote:
> > Hi Michael,
> > Thanks for pointing out the issue. My mistake...
> > This patch should indeed make sense only when
> > CONFIG_PHYS_64BIT=y
> >
> > I could not find corenet32_smp_defconfig, but I guess in your config,
> > CONFIG_PHYS_64BIT=n ?
> > I will update the patch later today
>
> corenet32_smp_defconfig is a makefile rule that pulls in multiple config
> fragments.  It has CONFIG_PHYS_64BIT=y, but __pa() returns an unsigned long
> regardless (which obviously needs to be fixed if DDR starting beyond 4G is to
> be supported).
>
> What 32-bit config are you using where this actually builds?
>
> -Scott
>
>
