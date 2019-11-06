Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A560F14CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 12:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfKFLRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 06:17:51 -0500
Received: from foss.arm.com ([217.140.110.172]:38072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfKFLRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:17:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9152A7A7;
        Wed,  6 Nov 2019 03:17:48 -0800 (PST)
Received: from arrakis.emea.arm.com (unknown [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C55D43F6C4;
        Wed,  6 Nov 2019 03:17:46 -0800 (PST)
Date:   Wed, 6 Nov 2019 11:17:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        David Hildenbrand <david@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: simplify the page end calculation in
 __create_pgd_mapping()
Message-ID: <20191106111743.GF21133@arrakis.emea.arm.com>
References: <20191103123559.8866-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103123559.8866-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 09:35:58PM +0900, Masahiro Yamada wrote:
> Calculate the page-aligned end address more simply.
> 
> The local variable, "length" is unneeded.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Queued for 5.5. Thanks.

-- 
Catalin
