Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFCF38755
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfFGJs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 05:48:57 -0400
Received: from foss.arm.com ([217.140.110.172]:36822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfFGJs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:48:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 200E13EF;
        Fri,  7 Jun 2019 02:41:24 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2D6D3F96A;
        Fri,  7 Jun 2019 02:43:02 -0700 (PDT)
Date:   Fri, 7 Jun 2019 10:41:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Odin Ugedal <odin@ugedal.com>
Cc:     odin@uged.al, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Yu Zhao <yuzhao@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: Fix comment after #endif
Message-ID: <20190607094119.GB16801@arrakis.emea.arm.com>
References: <20190606234912.18746-1-odin@ugedal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606234912.18746-1-odin@ugedal.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 01:49:10AM +0200, Odin Ugedal wrote:
> The config value used in the if was changed in
> b433dce056d3814dc4b33e5a8a533d6401ffcfb0, but the comment on the
> corresponding end was not changed.
> 
> Signed-off-by: Odin Ugedal <odin@ugedal.com>

Queued for 5.3. Thanks.

-- 
Catalin
