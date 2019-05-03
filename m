Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC4E12840
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfECG7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:25 -0400
Received: from ozlabs.org ([203.11.71.1]:34865 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbfECG7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:24 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKQ4DqFz9sB8; Fri,  3 May 2019 16:59:22 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f341d89790b0b7f99ca7835e0cf7de1026ceae39
X-Patchwork-Hint: ignore
In-Reply-To: <20190423151017.14429-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] powerpc/mm: fix spelling mistake "Outisde" -> "Outside"
Message-Id: <44wNKQ4DqFz9sB8@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:22 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-23 at 15:10:17 UTC, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are several identical spelling mistakes in warning messages,
> fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f341d89790b0b7f99ca7835e0cf7de10

cheers
