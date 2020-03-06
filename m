Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1192B17B2E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 01:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCFA1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 19:27:39 -0500
Received: from ozlabs.org ([203.11.71.1]:50507 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgCFA1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:39 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT3F1QB8z9sRY; Fri,  6 Mar 2020 11:27:36 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ba32f4b02105e57627912b42e141d65d90074c64
In-Reply-To: <6ecbda05b4119c40222dc8ec284604e1597c9bff.1580327381.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/process: Remove unneccessary #ifdef CONFIG_PPC64 in copy_thread_tls()
Message-Id: <48YT3F1QB8z9sRY@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:36 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-29 at 19:50:07 UTC, Christophe Leroy wrote:
> is_32bit_task() exists on both PPC64 and PPC32, no need of an ifdefery.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ba32f4b02105e57627912b42e141d65d90074c64

cheers
