Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67EF94E597
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 12:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfFUKKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 06:10:45 -0400
Received: from foss.arm.com ([217.140.110.172]:57004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfFUKKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:10:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B7B6142F;
        Fri, 21 Jun 2019 03:10:44 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29C863F718;
        Fri, 21 Jun 2019 03:10:43 -0700 (PDT)
Subject: Re: [PATCH V2 2/4] csky: Add new asid lib code from arm
To:     guoren@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc:     linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Arnd Bergmann <arnd@arnd.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <1561109999-4322-1-git-send-email-guoren@kernel.org>
 <1561109999-4322-3-git-send-email-guoren@kernel.org>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <2c6acec4-07b7-b214-9eeb-964dc3a0d632@arm.com>
Date:   Fri, 21 Jun 2019 11:10:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1561109999-4322-3-git-send-email-guoren@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/06/2019 10:39, guoren@kernel.org wrote:
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arnd.de>
> Cc: Julien Grall <julien.grall@arm.com>
> ---
>   arch/arm64/lib/asid.c        |   9 ++-

This change should be in a separate e-mail with the Arm64 maintainers in CC.

But you seem to have a copy of the allocator in csky now. So why do you need to 
modify arm64/lib/asid.c here?

Cheers,

-- 
Julien Grall
