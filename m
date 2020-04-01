Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1818E19A78F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 10:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbgDAIkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 04:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731753AbgDAIkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:40:07 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B00B72073B;
        Wed,  1 Apr 2020 08:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585730407;
        bh=IettRpxQKHjbXxTrJwRzoDBrplyvOcANa1c7iBza1LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E69v0NqTT9HWVarFu0fAspnLLE/OtAiEou5LXE6Zd7So6v8F2L8g9FULYIgtbf6jW
         K8cbv5z/zLe5OtGAuyGLe1eU+o6+05Osz5F+0iTcfWF4+n+CdcSmk1sHUHOFQ7/8qt
         Vzvf7Ar8TBxQSX75nnYaGyMOpM0VLuK4vUrjzgpk=
Date:   Wed, 1 Apr 2020 09:40:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kcsan: Move kcsan_{disable,enable}_current() to
 kcsan-checks.h
Message-ID: <20200401084002.GB16446@willie-the-truck>
References: <20200331193233.15180-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331193233.15180-1-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:32:32PM +0200, Marco Elver wrote:
> Both affect access checks, and should therefore be in kcsan-checks.h.
> This is in preparation to use these in compiler.h.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/kcsan-checks.h | 16 ++++++++++++++++
>  include/linux/kcsan.h        | 16 ----------------
>  2 files changed, 16 insertions(+), 16 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
