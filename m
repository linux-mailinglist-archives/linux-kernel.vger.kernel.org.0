Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40161793A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 16:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgCDPgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 10:36:24 -0500
Received: from foss.arm.com ([217.140.110.172]:35880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgCDPgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:36:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2187531B;
        Wed,  4 Mar 2020 07:36:23 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B63C3F6CF;
        Wed,  4 Mar 2020 07:36:20 -0800 (PST)
Date:   Wed, 4 Mar 2020 15:36:18 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        will@kernel.org, rppt@linux.ibm.com, mark.rutland@arm.com,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        arunks@codeaurora.org, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com,
        broonie@kernel.org, valentin.schneider@arm.com,
        Robin.Murphy@arm.com, steven.price@arm.com, suzuki.poulose@arm.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH V14 0/2] arm64/mm: Enable memory hot remove
Message-ID: <20200304153618.GA2595@arrakis.emea.arm.com>
References: <1583296123-18546-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583296123-18546-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 09:58:41AM +0530, Anshuman Khandual wrote:
> Changes in V14:
> 
> - Added P4D page table support from Mike and Catalin (https://lkml.org/lkml/2020/3/2/196)

I queued v14 for 5.7. Thanks.

-- 
Catalin
