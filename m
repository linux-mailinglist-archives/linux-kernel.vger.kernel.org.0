Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5768934978
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfFDNxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 09:53:32 -0400
Received: from foss.arm.com ([217.140.101.70]:44576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfFDNxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:53:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB0F2A78;
        Tue,  4 Jun 2019 06:53:30 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8845D3F73F;
        Tue,  4 Jun 2019 06:53:29 -0700 (PDT)
Date:   Tue, 4 Jun 2019 14:53:27 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2] arm64/mm: Change BUG_ON() to VM_BUG_ON() in
 [pmd|pud]_set_huge()
Message-ID: <20190604135326.GG6610@arrakis.emea.arm.com>
References: <1558940609-30872-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558940609-30872-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 12:33:29PM +0530, Anshuman Khandual wrote:
> There are no callers for the functions which will pass unaligned physical
> addresses. Hence just change these BUG_ON() checks into VM_BUG_ON() which
> gets compiled out unless CONFIG_VM_DEBUG is enabled.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Queued for 5.3. Thanks.

-- 
Catalin
