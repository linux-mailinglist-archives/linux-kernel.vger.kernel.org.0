Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11DD7FC21C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKNJHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:07:47 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:56805 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfKNJHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:45 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxV07nsz9sPZ; Thu, 14 Nov 2019 20:07:41 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d79fbb3a32f05a7e1cc0294b86dacdb9cc3ad7f5
In-Reply-To: <20190801225006.21952-1-chris.packham@alliedtelesis.co.nz>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@c-s.fr, malat@debian.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc: Support CMDLINE_EXTEND
Message-Id: <47DFxV07nsz9sPZ@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:41 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 22:50:06 UTC, Chris Packham wrote:
> Bring powerpc in line with other architectures that support extending or
> overriding the bootloader provided command line.
> 
> The current behaviour is most like CMDLINE_FROM_BOOTLOADER where the
> bootloader command line is preferred but the kernel config can provide a
> fallback so CMDLINE_FROM_BOOTLOADER is the default. CMDLINE_EXTEND can
> be used to append the CMDLINE from the kernel config to the one provided
> by the bootloader.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d79fbb3a32f05a7e1cc0294b86dacdb9cc3ad7f5

cheers
