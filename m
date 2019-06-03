Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4BD32FB8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 14:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfFCMdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 08:33:00 -0400
Received: from ozlabs.org ([203.11.71.1]:47467 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfFCMc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:32:59 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45HZG14vJpz9sP6; Mon,  3 Jun 2019 22:32:57 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: efa9ace68e487ddd29c2b4d6dd23242158f1f607
X-Patchwork-Hint: ignore
Content-Type: text/plain; charset="utf-8";
In-Reply-To: <20190526024240.GA14546@zhanggen-UX430UQ>
To:     Gen Zhang <blackgod016574@gmail.com>, benh@kernel.crashing.org,
        paulus@samba.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dlpar: Fix a missing-check bug in dlpar_parse_cc_property()
Message-Id: <45HZG14vJpz9sP6@ozlabs.org>
Date:   Mon,  3 Jun 2019 22:32:57 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-05-26 at 02:42:40 UTC, Gen Zhang wrote:
> In dlpar_parse_cc_property(), 'prop->name' is allocated by kstrdup().
> kstrdup() may return NULL, so it should be checked and handle error.
> And prop should be freed if 'prop->name' is NULL.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Acked-by: Nathan Lynch <nathanl@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/efa9ace68e487ddd29c2b4d6dd232421

cheers
