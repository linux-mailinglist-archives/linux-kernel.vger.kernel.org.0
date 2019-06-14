Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE93D46215
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 17:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfFNPHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 11:07:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38429 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNPHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:07:09 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbnn8-0000iH-6U; Fri, 14 Jun 2019 17:06:58 +0200
Date:   Fri, 14 Jun 2019 17:06:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: Re: [PATCH v2 0/3] Add support for Zhaoxin Processors
In-Reply-To: <54fb8565afbe4351adc0e4541463776c@zhaoxin.com>
Message-ID: <alpine.DEB.2.21.1906141705400.1722@nanos.tec.linutronix.de>
References: <54fb8565afbe4351adc0e4541463776c@zhaoxin.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

On Tue, 28 May 2019, Tony W Wang-oc wrote:

> As a new x86 CPU Vendor, Shanghai Zhaoxin Semiconductor Co., Ltd.
>  ("Zhaoxin") provide high performance general-purpose x86 processors.
> 
> CPU Vendor ID "Shanghai" belongs to Zhaoxin.
> 
> To enable the supports of Linux kernel to Zhaoxin's CPUs, add a new vendor
> type (X86_VENDOR_ZHAOXIN, with value of 10) in
> arch/x86/include/asm/processor.h.
> 
> To enable the support of Linux kernel's specific configuration to
> Zhaoxin's CPUs, add a new file arch/x86/kernel/cpu/zhaoxin.c.
> 
> This patch series have been applied and tested successfully on Zhaoxin's
> Soc silicon. Also tested on other processors, it works fine and makes no
> harm to the existing codes.
> 
> v1->v2:
>  - Rebased on 5.2.0-rc2 and tested against it.
>  - remove GPL "boilerplate" text in the patch.
>  - adjust signed-off-by: line match From: line.
>  - run patch series through checkpatch.pl.
> 
> v1:
>  - Rebased on 5.2.0-rc1 and tested against it.
>  - Split the patch set to small series of patches.
>  - Rework patch descriptions.
> 
> TonyWWang (3):
>  x86/cpu: Create Zhaoxin processors architecture support file
>  ACPI, x86: add Zhaoxin processors support for NONSTOP TSC
>  x86/acpi/cstate: add Zhaoxin processors support for cache flush policy
>  in C3

I only got 0/3 and 1/3 of Version 2. Please always send the complete set.

Thanks,

	tglx
