Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBD0C0244
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 11:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfI0J0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 05:26:44 -0400
Received: from foss.arm.com ([217.140.110.172]:46860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfI0J0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:26:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4128D28;
        Fri, 27 Sep 2019 02:26:43 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F6683F534;
        Fri, 27 Sep 2019 02:26:42 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:26:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        will@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v3 3/5] arm64: vdso32: Fix compilation warning
Message-ID: <20190927092639.GC20642@arrakis.emea.arm.com>
References: <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926214342.34608-4-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:43:40PM +0100, Vincenzo Frascino wrote:
> Note: This fix is meant to be temporary, a more comprehensive solution
> based on the refactoring of the generic headers will be provided with a
> future patch set. At that point it will be possible to revert this patch.

With this note, I'm fine with the patch.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
