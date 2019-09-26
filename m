Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA990BED79
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 10:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfIZIew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 04:34:52 -0400
Received: from foss.arm.com ([217.140.110.172]:42228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfIZIev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:34:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB4811000;
        Thu, 26 Sep 2019 01:34:50 -0700 (PDT)
Received: from iMac.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEBD03F836;
        Thu, 26 Sep 2019 01:34:49 -0700 (PDT)
Date:   Thu, 26 Sep 2019 09:34:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        will@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 4/4] arm64: Remove gettimeofday.S
Message-ID: <20190926083446.GE26802@iMac.local>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926060353.54894-1-vincenzo.frascino@arm.com>
 <20190926060353.54894-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926060353.54894-5-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 07:03:53AM +0100, Vincenzo Frascino wrote:
> gettimeofday.S was originally removed with the introduction of the
> support for Unified vDSOs in arm64 and replaced with the C
> implementation.
> 
> The file seems again present in the repository due to a side effect of
> rebase.
> 
> Remove the file again.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Nitpick: don't leave a space between the Cc and the Sob lines, it all
comes as a single block.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
