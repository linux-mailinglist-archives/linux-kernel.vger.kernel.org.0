Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F7C164472
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 13:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBSMkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 07:40:09 -0500
Received: from ozlabs.org ([203.11.71.1]:40673 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbgBSMkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:40:08 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48My3q1XP9z9sSv; Wed, 19 Feb 2020 23:40:06 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9eb425b2e04e0e3006adffea5bf5f227a896f128
In-Reply-To: <a99fc0ad65b87a1ba51cfa3e0e9034ee294c3e07.1582034961.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/entry: Fix a #if which should be a #ifdef in entry_32.S
Message-Id: <48My3q1XP9z9sSv@ozlabs.org>
Date:   Wed, 19 Feb 2020 23:40:06 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-18 at 14:09:29 UTC, Christophe Leroy wrote:
> Fixes: 12c3f1fd87bf ("powerpc/32s: get rid of CPU_FTR_601 feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/9eb425b2e04e0e3006adffea5bf5f227a896f128

cheers
