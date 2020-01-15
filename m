Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE67A13B944
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 06:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgAOF5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 00:57:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:60820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgAOF5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:57:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3A15CAD45;
        Wed, 15 Jan 2020 05:57:17 +0000 (UTC)
Subject: Re: [patch 10/15] x86/vdso: Use generic VDSO clock mode storage
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
References: <20200114185237.273005683@linutronix.de>
 <20200114185947.608274960@linutronix.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <1385d686-b127-47e3-8eb2-cb79ef8f8b52@suse.com>
Date:   Wed, 15 Jan 2020 06:57:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200114185947.608274960@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.20 19:52, Thomas Gleixner wrote:
> Switch to the generic VDSO clock mode storage.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Juergen Gross <jgross@suse.com> (Xen parts)


Juergen

