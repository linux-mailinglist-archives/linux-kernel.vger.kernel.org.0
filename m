Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8DA1284D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfECG7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:15 -0400
Received: from ozlabs.org ([203.11.71.1]:34981 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfECG7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:12 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKC2Pt1z9sP8; Fri,  3 May 2019 16:59:10 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1ba2143606a10f1c2e7308bc7abd940a6381cffd
X-Patchwork-Hint: ignore
In-Reply-To: <20190327053137.15173-2-alastair@au1.ibm.com>
To:     "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/7] ocxl: Split pci.c
Message-Id: <44wNKC2Pt1z9sP8@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:10 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-27 at 05:31:30 UTC, "Alastair D'Silva" wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> In preparation for making core code available for external drivers,
> move the core code out of pci.c and into core.c
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1ba2143606a10f1c2e7308bc7abd940a

cheers
