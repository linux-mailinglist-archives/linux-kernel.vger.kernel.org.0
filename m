Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35C5AF6E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2019 10:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfF3Iha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jun 2019 04:37:30 -0400
Received: from ozlabs.org ([203.11.71.1]:40831 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfF3Iha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 04:37:30 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45c3lr3cZBz9sN6; Sun, 30 Jun 2019 18:37:28 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0b1be03f25bb4c92de6408da4de9361f4cb50ae3
X-Patchwork-Hint: ignore
In-Reply-To: <20190617090713.10532-1-geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Geoff Levand <geoff@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] ps3: Use [] to denote a flexible array member
Message-Id: <45c3lr3cZBz9sN6@ozlabs.org>
Date:   Sun, 30 Jun 2019 18:37:28 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-17 at 09:07:13 UTC, Geert Uytterhoeven wrote:
> Flexible array members should be denoted using [] instead of [0], else
> gcc will not warn when they are no longer at the end of the structure.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0b1be03f25bb4c92de6408da4de9361f4cb50ae3

cheers
