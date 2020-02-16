Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB77A1604AB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 17:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgBPQCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 11:02:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgBPQCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 11:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=cWzOpiOu7VlYjJzjka/uz4Y9eKUv0MO2UGlQ+F9pXEg=; b=LYzJjga0YcaHKF6XPZepjCtZ38
        dhiVAEks0WShzXhYlaM/A1Iz8WQgtfujRfXxn5Oob1gZsp84rhBVs0u8Bfh30DshXhtvN9TGpeHk/
        p1HFg9+cIjx/2d6+TTauS4/GBYKLXI+GaJwfyEkDLR4oJGdbo0YwWJ7c6ubEtJIijejvFEEw0/naP
        6hw3SnC1YNrQclZK1qeRbDYefSX9/NPwCjiVxZLJ6I7SBOyCvPwrMG+MF8cconRoaxt1a5ORVea6g
        kQbnTkHybVVU7Tm7qoPuJMC5O79/bgu0DQ0lZr6ITT2KQrJFgBHXZSA3YaVAo0fKxx1CUB/YpmrDL
        oTF8ffDQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3MN3-0005FL-1O; Sun, 16 Feb 2020 16:02:13 +0000
Subject: Re: x86: Fix a handful of typos
To:     Martin Molnar <martin.molnar.programming@gmail.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <0819a044-c360-44a4-f0b6-3f5bafe2d35c@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d311681b-3481-b808-71e4-258bfc01c788@infradead.org>
Date:   Sun, 16 Feb 2020 08:02:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0819a044-c360-44a4-f0b6-3f5bafe2d35c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/20 7:17 AM, Martin Molnar wrote:
> Please find a couple of typos fixed in the patch below. Let me know if I should do anything else.
> 
>      Martin Molnar
> 
> Signed-off-by: Martin Molnar <martin.molnar.programming@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/x86/kernel/irqinit.c  | 2 +-
>  arch/x86/kernel/nmi.c      | 4 ++--
>  arch/x86/kernel/reboot.c   | 2 +-
>  arch/x86/kernel/smpboot.c  | 2 +-
>  arch/x86/kernel/tsc.c      | 2 +-
>  arch/x86/kernel/tsc_sync.c | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)

Thanks.
-- 
~Randy

