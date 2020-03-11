Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E581181AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 15:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgCKOSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 10:18:52 -0400
Received: from foss.arm.com ([217.140.110.172]:50274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbgCKOSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:18:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EBC931B;
        Wed, 11 Mar 2020 07:18:51 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4A993F67D;
        Wed, 11 Mar 2020 07:18:50 -0700 (PDT)
Date:   Wed, 11 Mar 2020 14:18:48 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/2] mm: disable KCSAN for kmemleak
Message-ID: <20200311141848.GG3216816@arrakis.emea.arm.com>
References: <1583263716-25150-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583263716-25150-1-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 02:28:35PM -0500, Qian Cai wrote:
> Kmemleak could scan task stacks while plain writes happens to those
> stack variables which could results in data races. For example, in
> sys_rt_sigaction and do_sigaction(), it could have plain writes in
> a 32-byte size. Since the kmemleak does not care about the actual values
> of a non-pointer and all do_sigaction() call sites only copy to stack
> variables, just disable KCSAN for kmemleak to avoid annotating anything
> outside Kmemleak just because Kmemleak scans everything.
> 
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
