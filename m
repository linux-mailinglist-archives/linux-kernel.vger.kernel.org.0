Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83BDF15D700
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 12:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgBNL5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 06:57:16 -0500
Received: from foss.arm.com ([217.140.110.172]:60324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgBNL5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 06:57:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C3811FB;
        Fri, 14 Feb 2020 03:57:13 -0800 (PST)
Received: from [192.168.1.18] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B42843F68F;
        Fri, 14 Feb 2020 03:57:10 -0800 (PST)
Subject: Re: [patch V2 06/17] clocksource: Cleanup struct clocksource and
 documentation
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andrei Vagin <avagin@gmail.com>
References: <20200207123847.339896630@linutronix.de>
 <20200207124402.825471920@linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <eb5ae629-b153-cdf8-2b99-f65bae3dc017@arm.com>
Date:   Fri, 14 Feb 2020 11:57:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207124402.825471920@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 12:38 PM, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Reformat the struct definition, add missing member documentation.
> No functional change.
>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
[...]

-- 
Regards,
Vincenzo
