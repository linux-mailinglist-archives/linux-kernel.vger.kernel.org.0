Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 961E117B2E0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 01:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCFA1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 19:27:36 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:58811 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFA1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:35 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT390jK2z9sSM; Fri,  6 Mar 2020 11:27:33 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 05642cf7289c5562e5939d2ee8a0529d310010b8
In-Reply-To: <d2c6dc65d27e83964eb05f16a126161ab6455eea.1578388585.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: don't restore r0, r6-r8 on exception entry path after trace_hardirqs_off()
Message-Id: <48YT390jK2z9sSM@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:33 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-07 at 09:16:40 UTC, Christophe Leroy wrote:
> Since commit b86fb88855ea ("powerpc/32: implement fast entry for
> syscalls on non BOOKE") and commit 1a4b739bbb4f ("powerpc/32:
> implement fast entry for syscalls on BOOKE"), syscalls don't
> use the exception entry path anymore. It is therefore pointless
> to restore r0 and r6-r8 after calling trace_hardirqs_off().
> 
> In the meantime, drop the '2:' label which is unused and misleading.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/05642cf7289c5562e5939d2ee8a0529d310010b8

cheers
