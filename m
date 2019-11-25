Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7954108C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 11:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfKYKrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 05:47:35 -0500
Received: from ozlabs.org ([203.11.71.1]:54269 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbfKYKrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:47:02 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47M3d05Phdz9sR3; Mon, 25 Nov 2019 21:47:00 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 44448640dd0df98891c5ea4695d89a4972cb4c1f
In-Reply-To: <dd82934ad91aab607d0eb7e626c14e6ac0d654eb.1567068137.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, segher@kernel.crashing.org,
        npiggin@gmail.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] powerpc: permanently include 8xx registers in reg.h
Message-Id: <47M3d05Phdz9sR3@ozlabs.org>
Date:   Mon, 25 Nov 2019 21:47:00 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-29 at 08:45:12 UTC, Christophe Leroy wrote:
> Most 8xx registers have specific names, so just include
> reg_8xx.h all the time in reg.h in order to have them defined
> even when CONFIG_PPC_8xx is not selected. This will avoid
> the need for #ifdefs in C code.
> 
> Guard SPRN_ICTRL in an #ifdef CONFIG_PPC_8xx as this register
> has same name but different meaning and different spr number as
> another register in the mpc7450.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/44448640dd0df98891c5ea4695d89a4972cb4c1f

cheers
