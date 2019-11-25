Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0482D108C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 11:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfKYKrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 05:47:24 -0500
Received: from ozlabs.org ([203.11.71.1]:51973 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbfKYKrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:47:12 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47M3dB5nx6z9sRW; Mon, 25 Nov 2019 21:47:10 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9f7bd9201521b3ad11e96887550dd3e835ba01cb
In-Reply-To: <e235973a1198195763afd3b6baffa548a83f4611.1572351221.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] powerpc/32: Split kexec low level code out of misc_32.S
Message-Id: <47M3dB5nx6z9sRW@ozlabs.org>
Date:   Mon, 25 Nov 2019 21:47:10 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-29 at 12:13:57 UTC, Christophe Leroy wrote:
> Almost half of misc_32.S is dedicated to kexec.
> That's the relocation function for kexec.
> 
> Drop it into a dedicated kexec_relocate_32.S
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9f7bd9201521b3ad11e96887550dd3e835ba01cb

cheers
