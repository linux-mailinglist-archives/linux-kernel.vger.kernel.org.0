Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 396C614C58A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgA2FRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:17:43 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgA2FRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:39 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDx5BY5z9sRl; Wed, 29 Jan 2020 16:17:37 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e26ad936dd89d79f66c2b567f700e0c2a7103070
In-Reply-To: <37517da8310f4457f28921a4edb88fb21d27b62a.1578989531.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ptdump: fix W+X verification call in mark_rodata_ro()
Message-Id: <486sDx5BY5z9sRl@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:37 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-14 at 08:13:08 UTC, Christophe Leroy wrote:
> ptdump_check_wx() also have to be called when pages are mapped
> by blocks.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e26ad936dd89d79f66c2b567f700e0c2a7103070

cheers
