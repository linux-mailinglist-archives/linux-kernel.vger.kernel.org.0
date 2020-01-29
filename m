Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7CFD14C587
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgA2FRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:17:37 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:38363 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgA2FRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:31 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDn3g1Bz9sRp; Wed, 29 Jan 2020 16:17:29 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5084ff33cac0988c1b979814501dcc2e1ecbf9c0
In-Reply-To: <1577864614-5543-10-git-send-email-Julia.Lawall@inria.fr>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, kernel-janitors@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/16] powerpc/mpic: constify copied structure
Message-Id: <486sDn3g1Bz9sRp@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:29 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-01 at 07:43:27 UTC, Julia Lawall wrote:
> The mpic_ipi_chip and mpic_irq_ht_chip structures are only copied
> into other structures, so make them const.
> 
> The opportunity for this change was found using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5084ff33cac0988c1b979814501dcc2e1ecbf9c0

cheers
