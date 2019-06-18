Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC214A093
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 14:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfFRMQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 08:16:29 -0400
Received: from foss.arm.com ([217.140.110.172]:38082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRMQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:16:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C4DA2B;
        Tue, 18 Jun 2019 05:16:28 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8FF83F246;
        Tue, 18 Jun 2019 05:16:27 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:16:25 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Michael Forney <mforney@mforney.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/atomics: Use sed(1) instead of non-standard
 head(1) option
Message-ID: <20190618121625.GC31041@fuggles.cambridge.arm.com>
References: <20190618053306.730-1-mforney@mforney.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618053306.730-1-mforney@mforney.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 10:33:06PM -0700, Michael Forney wrote:
> POSIX says the -n option must be a positive decimal integer. Not all
> implementations of head(1) support negative numbers meaning offset from
> the end of the file.
> 
> Instead, the sed expression '$d' has the same effect of removing the
> last line of the file.
> 
> Signed-off-by: Michael Forney <mforney@mforney.org>
> ---
>  scripts/atomic/check-atomics.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
