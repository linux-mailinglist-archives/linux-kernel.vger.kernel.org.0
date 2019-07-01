Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A88D33466
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 18:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfFCQAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 12:00:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54468 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbfFCQAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:00:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2120780D;
        Mon,  3 Jun 2019 09:00:19 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF4C83F246;
        Mon,  3 Jun 2019 09:00:17 -0700 (PDT)
Date:   Mon, 3 Jun 2019 17:00:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH] arm64/mm: Move PTE_VALID from SW defined to HW page
 table entry definitions
Message-ID: <20190603160015.GE63283@arrakis.emea.arm.com>
References: <1558411587-19042-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558411587-19042-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 09:36:27AM +0530, Anshuman Khandual wrote:
> PTE_VALID signifies that the last level page table entry is valid and it is
> MMU recognized while walking the page table. This is not a software defined
> PTE bit and should not be listed like one. Just move it to appropriate
> header file.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: James Morse <james.morse@arm.com>

Queued for 5.3. Thanks.

-- 
Catalin
