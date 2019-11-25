Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6DB108C38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 11:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfKYKrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 05:47:13 -0500
Received: from ozlabs.org ([203.11.71.1]:34861 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbfKYKrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:47:07 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47M3d55yqFz9sR3; Mon, 25 Nov 2019 21:47:05 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 265c3491c4bc8d40587996d6ee2f447a7ccfb4f3
In-Reply-To: <412c7eaa6a373d8f82a3c3ee01e6a65a1a6589de.1568295907.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        hch@infradead.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] powerpc: Add support for GENERIC_EARLY_IOREMAP
Message-Id: <47M3d55yqFz9sR3@ozlabs.org>
Date:   Mon, 25 Nov 2019 21:47:05 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 13:49:43 UTC, Christophe Leroy wrote:
> Add support for GENERIC_EARLY_IOREMAP.
> 
> Let's define 16 slots of 256Kbytes each for early ioremap.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/265c3491c4bc8d40587996d6ee2f447a7ccfb4f3

cheers
