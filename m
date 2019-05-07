Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4416DB0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 00:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfEGW7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 18:59:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53748 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGW7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:59:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hO932-0004UC-H9; Tue, 07 May 2019 22:58:56 +0000
Date:   Tue, 7 May 2019 23:58:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Breno Leitao <leitao@debian.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yury Norov <ynorov@marvell.com>
Subject: Re: [PATCH] powerpc: restore current_thread_info()
Message-ID: <20190507225856.GP23075@ZenIV.linux.org.uk>
References: <20190507225121.18676-1-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507225121.18676-1-ynorov@marvell.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 03:51:21PM -0700, Yury Norov wrote:
> Commit ed1cd6deb013 ("powerpc: Activate CONFIG_THREAD_INFO_IN_TASK")
> removes the function current_thread_info(). It's wrong because the
> function is used in non-arch code and is part of API.

In include/linux/thread_info.h:

#ifdef CONFIG_THREAD_INFO_IN_TASK
/*
 * For CONFIG_THREAD_INFO_IN_TASK kernels we need <asm/current.h> for the
 * definition of current, but for !CONFIG_THREAD_INFO_IN_TASK kernels,
 * including <asm/current.h> can cause a circular dependency on some platforms.
 */
#include <asm/current.h>
#define current_thread_info() ((struct thread_info *)current)
#endif

