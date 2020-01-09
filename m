Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61911351B8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 04:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgAIDHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 22:07:46 -0500
Received: from foss.arm.com ([217.140.110.172]:53016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgAIDHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 22:07:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F353131B;
        Wed,  8 Jan 2020 19:07:45 -0800 (PST)
Received: from [10.162.40.138] (p8cg001049571a15.blr.arm.com [10.162.40.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B53F93F534;
        Wed,  8 Jan 2020 19:07:41 -0800 (PST)
Subject: Re: [PATCH 0/1] arm/arm64: add support for folded p4d page tables
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20191230082734.28954-1-rppt@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <19fc0640-2b7e-a06f-a4c8-2736d54dd565@arm.com>
Date:   Thu, 9 Jan 2020 08:38:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191230082734.28954-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/2019 01:57 PM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,

Hello Mike,

> 
> This is a part of clean up of the page table manipulation code that aims to
> remove asm-generic/5level-fixup.h and asm-generic/pgtable-nop4d-hack.h
> 
> There is a single patch for both arm and arm64 because doing the conversion
> separately would mean breaking the shared mmu bits in virt/kvm/arm.
> 
> The patch is build tested and boot tested on qemu-system-{arm,aarch64}.

There are lots of code changes here for a single patch but as you have
mentioned shared KVM bits would have prevented splitting arm and arm64
changes into separate patches. Just curious, are you planning to respin
this patch sooner after fixing the reported build problems caused by
missing p4d_offset_kimg() and p4d_sect() definitions ?

- Anshuman
