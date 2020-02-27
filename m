Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16B171F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 15:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbgB0N5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 08:57:52 -0500
Received: from foss.arm.com ([217.140.110.172]:51144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732199AbgB0N5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:57:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 210A030E;
        Thu, 27 Feb 2020 05:57:50 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5674D3F881;
        Thu, 27 Feb 2020 05:57:49 -0800 (PST)
Date:   Thu, 27 Feb 2020 13:57:47 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: fix NUMA Kconfig typos
Message-ID: <20200227135747.GF3281767@arrakis.emea.arm.com>
References: <2c69f4d8-03a1-20a6-e8ef-a4518a7c6d07@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c69f4d8-03a1-20a6-e8ef-a4518a7c6d07@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 05:51:06PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix typos in arch/arm64/Kconfig:
> 
> - spell Numa as NUMA
> - add hyphenation to Non-Uniform
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org

Queued for 5.7. Thanks.

-- 
Catalin
