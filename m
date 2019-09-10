Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11EA0AE4D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 09:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404455AbfIJHqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 03:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730178AbfIJHqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:46:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543572084D;
        Tue, 10 Sep 2019 07:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568101571;
        bh=qCKK+ZwRK74U3hEJqtiKQ6iZ3hduhTpM7HIjKwVnRAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJ/93vM+ibiNNsFQ20UdNU0QlCSEGDrjjQUbJ+KkjzfSHA6Sw7uz7zsxA7NhROsPX
         ybDjrsp1raImjF8GF4aAGP6SeLOPIroLeB9b8PSJnrgVKb4Q3KJCFtu51yrav9/eLc
         I90k87aOmYsFr5tqlILmZ+H6GnfXYceZi+3Q0oNA=
Date:   Tue, 10 Sep 2019 08:46:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: fix unreachable code issue with cmpxchg
Message-ID: <20190910074606.45k5m2pkztlpj4nj@willie-the-truck>
References: <20190909202153.144970-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909202153.144970-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 10:21:35PM +0200, Arnd Bergmann wrote:
> On arm64 build with clang, sometimes the __cmpxchg_mb is not inlined
> when CONFIG_OPTIMIZE_INLINING is set.

Hmm. Given that CONFIG_OPTIMIZE_INLINING has also been shown to break
assignment of local 'register' variables on GCC, perhaps we should just
disable that option for arm64 (at least) since we don't have any toolchains
that seem to like it very much! I'd certainly prefer that over playing
whack-a-mole with __always_inline.

Will
