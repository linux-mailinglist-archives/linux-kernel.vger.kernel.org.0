Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78706175F3E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 17:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCBQLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 11:11:30 -0500
Received: from david.siemens.de ([192.35.17.14]:39428 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgCBQLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:11:30 -0500
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 022GBMiU029281
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 17:11:22 +0100
Received: from [139.25.68.37] ([139.25.68.37])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 022GBM7R009884;
        Mon, 2 Mar 2020 17:11:22 +0100
To:     x86 <x86@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: x2apic_wrmsr_fence vs. Intel manual
Message-ID: <783add60-f6c7-c8c6-b369-42e5ebfbf8c9@siemens.com>
Date:   Mon, 2 Mar 2020 17:11:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

as I generated a nice bug around fence vs. x2apic icr writes, I studied 
the kernel code and the Intel manual in this regard more closely. But 
there is a discrepancy:

arch/x86/include/asm/apic.h:

/*
 * Make previous memory operations globally visible before
 * sending the IPI through x2apic wrmsr. We need a serializing instruction or
 * mfence for this.
 */
static inline void x2apic_wrmsr_fence(void)
{
        asm volatile("mfence" : : : "memory");
}

Intel SDM, 10.12.3 MSR Access in x2APIC Mode:

"A WRMSR to an APIC register may complete before all preceding stores 
are globally visible; software can prevent this by inserting a 
serializing instruction or the sequence MFENCE;LFENCE before the WRMSR."

The former dates back to ce4e240c279a, but that commit does not mention 
why lfence is not needed. Did the manual read differently back then? Or 
why are we safe? To my reading of lfence, it also has a certain 
instruction serializing effect that mfence does not have.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
