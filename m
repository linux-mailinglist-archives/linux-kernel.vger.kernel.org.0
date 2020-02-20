Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18638165C67
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 12:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgBTLFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 06:05:39 -0500
Received: from foss.arm.com ([217.140.110.172]:40546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgBTLFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:05:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99BD630E;
        Thu, 20 Feb 2020 03:05:38 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4FCE3F6CF;
        Thu, 20 Feb 2020 03:05:37 -0800 (PST)
Date:   Thu, 20 Feb 2020 11:05:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] mm: kmemleak: Use address-of operator on section
 symbols
Message-ID: <20200220110535.GA103002@arrakis.emea.arm.com>
References: <20200220051551.44000-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220051551.44000-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:15:51PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> These are not true arrays, they are linker defined symbols, which are
> just addresses. Using the address of operator silences the warning and
> does not change the resulting assembly with either clang/ld.lld or
> gcc/ld (tested with diff + objdump -Dr).
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/895
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
