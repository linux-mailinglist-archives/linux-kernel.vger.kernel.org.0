Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC08E18850E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 14:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgCQNOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 09:14:39 -0400
Received: from ozlabs.org ([203.11.71.1]:59375 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgCQNOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:14:39 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48hYY83BzFz9sPR; Wed, 18 Mar 2020 00:14:36 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9451c79bc39e610882bdd12370f01af5004a3c4f
In-Reply-To: <20190920153951.25762-1-ilie.halip@gmail.com>
To:     Ilie Halip <ilie.halip@gmail.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ilie Halip <ilie.halip@gmail.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Paul Mackerras <paulus@samba.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pmac/smp: avoid unused-variable warnings
Message-Id: <48hYY83BzFz9sPR@ozlabs.org>
Date:   Wed, 18 Mar 2020 00:14:36 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-20 at 15:39:51 UTC, Ilie Halip wrote:
> When building with ppc64_defconfig, the compiler reports
> that these 2 variables are not used:
>     warning: unused variable 'core99_l2_cache' [-Wunused-variable]
>     warning: unused variable 'core99_l3_cache' [-Wunused-variable]
> 
> They are only used when CONFIG_PPC64 is not defined. Move
> them into a section which does the same macro check.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9451c79bc39e610882bdd12370f01af5004a3c4f

cheers
