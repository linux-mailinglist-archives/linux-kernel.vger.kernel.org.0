Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C89181689
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 12:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgCKLH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 07:07:28 -0400
Received: from foss.arm.com ([217.140.110.172]:48178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgCKLH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:07:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6183B1FB;
        Wed, 11 Mar 2020 04:07:27 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8621E3F6CF;
        Wed, 11 Mar 2020 04:07:26 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:07:24 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: entry-ftrace.S: Fix missing argument for
 CONFIG_FUNCTION_GRAPH_TRACER=y
Message-ID: <20200311110724.GC3216816@arrakis.emea.arm.com>
References: <1583894213-7633-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583894213-7633-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 11:36:53AM +0900, Kunihiko Hayashi wrote:
> Missing argument of another SYM_INNER_LABEL() breaks build for
> CONFIG_FUNCTION_GRAPH_TRACER=y.
> 
> Fixes: e2d591d29d44 ("arm64: entry-ftrace.S: Convert to modern annotations for assembly functions")
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Applied. Thanks.

-- 
Catalin
