Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72CC0F0D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 02:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfI1Asb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 20:48:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfI1Asb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 20:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kTYZ3z+xc2tDSZhwDjvXx1dXpdH2rNEG/lGjHo+wCdQ=; b=Aq3xguF+enqAVnlPAZo1eGFGw
        728UYXw/ow5TQwRHiXB4xDP9yS2NJNp+3ayZXiAm4lHItKLDnjiBs+B4v8b3PG4AVv79LFZdt7Jty
        Gvw8FhpKZweF7AkhmDOO3CknKjh+txwI9r6AMlRsoYPio5pCs8a5qCZNvr17gr+eFGLM/s4208Xfi
        fhvNDiEZ1zTvk0f70dAu7nE90/5Zjj4tsfYndHdnMUfHIy3J8TfBZDe0kJ589b1ECWnMKjQQDhsW8
        GWUxlhuGe9U74AzxtsLdhm2wgrDvuahGw4yXGEFmixme1U6NC7iiJSywLTe9OmobnI35CChXHr9zB
        Ija4Kdxsw==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iE0uU-0003bu-R6; Sat, 28 Sep 2019 00:48:30 +0000
Subject: Re: x86/purgatory: undefined symbol __stack_chk_fail
To:     Andreas Smas <andreas@lonelycoder.com>,
        linux-kernel@vger.kernel.org
References: <CAObFT-SqdcM2Xo7P3FqgwTABao5uoWrb+A3bXy9vKt5rBffSwA@mail.gmail.com>
Cc:     X86 ML <x86@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6c46ae4d-6837-d1a3-dbe0-03a9efcb862f@infradead.org>
Date:   Fri, 27 Sep 2019 17:48:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAObFT-SqdcM2Xo7P3FqgwTABao5uoWrb+A3bXy9vKt5rBffSwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/19 8:50 AM, Andreas Smas wrote:
> Hi,
> 
> For me, kernels built including this commit
> b059f801a937 (x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS)
> 
> results in kexec() failing to load the kernel:
> 
> kexec: Undefined symbol: __stack_chk_fail
> kexec-bzImage64: Loading purgatory failed
> 
> Can be seen:
> 
> $ readelf -a arch/x86/purgatory/purgatory.ro | grep UND
>      0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
>     51: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __stack_chk_fail
> 
> Using: gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1)
> 
> Adding -ffreestanding or -fno-stack-protector to ccflags-y in
> arch/x86/purgatory/Makefile
> fixes the problem. Not sure which would be preferred.
> 

Hi,
Do you have a kernel .config file that causes this?
I can't seem to reproduce it.

Thanks.
-- 
~Randy
