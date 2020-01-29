Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC7314C59A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgA2FSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:18:22 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40783 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgA2FR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:29 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDl4nWCz9sRk; Wed, 29 Jan 2020 16:17:27 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 39bccfd164970557c5cfc60b2db029f70542549f
In-Reply-To: <22469e78230edea3dbd0c79a555d73124f6c6d93.1576916812.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, dja@axtens.net
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/17] powerpc/32: replace MTMSRD() by mtmsr
Message-Id: <486sDl4nWCz9sRk@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:27 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-12-21 at 08:32:22 UTC, Christophe Leroy wrote:
> On PPC32, MTMSRD() is simply defined as mtmsr.
> 
> Replace MTMSRD(reg) by mtmsr reg in files dedicated to PPC32,
> this makes the code less obscure.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/39bccfd164970557c5cfc60b2db029f70542549f

cheers
