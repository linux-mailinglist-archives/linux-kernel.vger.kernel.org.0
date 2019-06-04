Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A327B3474D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 14:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfFDMvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 08:51:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42666 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbfFDMvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:51:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88202A78;
        Tue,  4 Jun 2019 05:51:04 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77B853F690;
        Tue,  4 Jun 2019 05:51:03 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:51:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/mm: Simplify protection flag creation for kernel
 huge mappings
Message-ID: <20190604125100.GC6610@arrakis.emea.arm.com>
References: <1558929495-19898-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558929495-19898-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 09:28:15AM +0530, Anshuman Khandual wrote:
> Even though they have got the same value, PMD_TYPE_SECT and PUD_TYPE_SECT
> get used for kernel huge mappings. But before that first the table bit gets
> cleared using leaf level PTE_TABLE_BIT. Though functionally they are same,
> we should use page table level specific macros to be consistent as per the
> MMU specifications. Create page table level specific wrappers for kernel
> huge mapping entries and just drop mk_sect_prot() which does not have any
> other user.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>

Queued for 5.3. Thanks.

-- 
Catalin
