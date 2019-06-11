Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3BE13C820
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405190AbfFKKIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 06:08:15 -0400
Received: from foss.arm.com ([217.140.110.172]:57390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405169AbfFKKIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:08:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66884337;
        Tue, 11 Jun 2019 03:08:13 -0700 (PDT)
Received: from [10.1.29.141] (e121487-lin.cambridge.arm.com [10.1.29.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5692A3F557;
        Tue, 11 Jun 2019 03:09:54 -0700 (PDT)
Subject: Re: binfmt_flat cleanups and RISC-V support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190610212015.9157-1-hch@lst.de>
 <4f000219-4baf-b03e-9003-26482640d3de@arm.com>
 <20190611081117.GA22110@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <d41f1077-936f-ce5b-2121-5a5ade521a98@arm.com>
Date:   Tue, 11 Jun 2019 11:08:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611081117.GA22110@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/19 9:11 AM, Christoph Hellwig wrote:
> On Tue, Jun 11, 2019 at 09:05:45AM +0100, Vladimir Murzin wrote:
>> I'm wondering if you have a branch with these changes so I can give
>> it a try on ARM NOMMU platforms?
> 
> 
>     git://git.infradead.org/users/hch/riscv.git riscv-flat
> 

Thanks! I gave it a go and provided my tags for relevant patches.

Cheers
Vladimir
