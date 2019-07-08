Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB566618BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 03:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfGHBTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 21:19:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55603 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbfGHBTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:31 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hnfp1QQwz9sNj; Mon,  8 Jul 2019 11:19:30 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7f9c929a7ff203eae60b4225bb6824c3eb31796c
In-Reply-To: <298f344bdb21ab566271f5d18c6782ed20f072b7.1556865423.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] powerpc: Move PPC_HA() PPC_HI() and PPC_LO() to ppc-opcode.h
Message-Id: <45hnfp1QQwz9sNj@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:30 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-03 at 06:40:15 UTC, Christophe Leroy wrote:
> PPC_HA() PPC_HI() and PPC_LO() macros are nice macros. Move them
> from module64.c to ppc-opcode.h in order to use them in other places.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7f9c929a7ff203eae60b4225bb6824c3eb31796c

cheers
