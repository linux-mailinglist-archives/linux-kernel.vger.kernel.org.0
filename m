Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D220BF5EF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 17:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfIZPb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 11:31:27 -0400
Received: from foss.arm.com ([217.140.110.172]:52992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbfIZPb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:31:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3252928;
        Thu, 26 Sep 2019 08:31:27 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EAF33F534;
        Thu, 26 Sep 2019 08:31:26 -0700 (PDT)
Date:   Thu, 26 Sep 2019 16:31:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        will@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 0/4] arm64: vdso32: Address various issues
Message-ID: <20190926153123.GK9689@arrakis.emea.arm.com>
References: <20190926133805.52348-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926133805.52348-1-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 02:38:01PM +0100, Vincenzo Frascino wrote:
> this patch series is meant to address the various compilation issues you
> reported about arm64 vdso32. (This time for real I hope ;))
> 
> Please let me know if there is still something missing.

Apart from the diff I posted and some nitpicks, the series looks fine to
me. If you post an update, I'll ack it (and a tested-by).

In addition to this series I'd still prefer to have my Kconfig option to
disable the compat vDSO if something else fails in the future (at least
until we complete the headers clean-up). But I'm fine with a default y
and removing EXPERT.

Thanks for the quick turnaround.

-- 
Catalin
