Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0845A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 12:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfFNKX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 06:23:59 -0400
Received: from foss.arm.com ([217.140.110.172]:58884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfFNKX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:23:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C3953EF;
        Fri, 14 Jun 2019 03:23:58 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7F333F246;
        Fri, 14 Jun 2019 03:25:40 -0700 (PDT)
Date:   Fri, 14 Jun 2019 11:23:55 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Anisse Astier <aastier@freebox.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Rich Felker <dalias@aerifal.cx>, linux-kernel@vger.kernel.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Ricardo Salveti <ricardo@foundries.io>
Subject: Re: [PATCH] arm64/sve: <uapi/asm/ptrace.h> should not depend on
 <uapi/linux/prctl.h>
Message-ID: <20190614102355.GE10659@fuggles.cambridge.arm.com>
References: <20190613163801.21949-1-aastier@freebox.fr>
 <20190613171432.GA2790@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613171432.GA2790@e103592.cambridge.arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 06:14:44PM +0100, Dave Martin wrote:
> On Thu, Jun 13, 2019 at 06:38:01PM +0200, Anisse Astier wrote:
> >   */
> > -#define SVE_PT_VL_INHERIT		(PR_SVE_VL_INHERIT >> 16)
> > -#define SVE_PT_VL_ONEXEC		(PR_SVE_SET_VL_ONEXEC >> 16)
> > +#define SVE_PT_VL_INHERIT		(1 << 1) /* PR_SVE_VL_INHERIT */
> > +#define SVE_PT_VL_ONEXEC		(1 << 2) /* PR_SVE_SET_VL_ONEXEC */
> 
> Makes sense, but...
> 
> Since sve_context.h was already introduced to solve a closely related
> problem, I wonder whether we can provide shadow definitions there,
> similarly to way the arm64/include/uapi/asm/ptrace.h definitions are
> derived.  Although it's a slight abuse of that header, I think that
> would be my preferred approach.

Yes, that sounds better to me as well. Please send a v2!

Will
