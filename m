Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695BB3C906
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 12:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbfFKKcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 06:32:42 -0400
Received: from foss.arm.com ([217.140.110.172]:58278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387423AbfFKKcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:32:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D599337;
        Tue, 11 Jun 2019 03:32:41 -0700 (PDT)
Received: from [10.1.29.141] (e121487-lin.cambridge.arm.com [10.1.29.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21DD73F557;
        Tue, 11 Jun 2019 03:34:21 -0700 (PDT)
Subject: Re: [PATCH 17/17] riscv: add nommu support
To:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190610221621.10938-1-hch@lst.de>
 <20190610221621.10938-18-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <cbf88fe0-94a6-b559-2b64-c725f236b683@arm.com>
Date:   Tue, 11 Jun 2019 11:32:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610221621.10938-18-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 11:16 PM, Christoph Hellwig wrote:
> Most of the patch is just stubbing out code not needed without page
> tables, but there is an interesting detail in the signals implementation:
> 
>  - The normal RISC-V syscall ABI only implements rt_sigreturn as VDSO
>    entry point, but the ELF VDSO is not supported for nommu Linux.
>    We instead copy the code to call the syscall onto the stack.

On ARM we perform I/D cache synchronization after stack manipulation.

OTOH, ARM port of uClibc provides SA_RESTORER with intention to avoid
manipulation with stack and cache maintenance operations (yet kernel
still performs such manipulation, IIUC, for backward compatibility)

Cheers
Vladimir
