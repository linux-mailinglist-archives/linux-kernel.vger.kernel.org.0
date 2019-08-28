Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3557B9F92E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 06:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfH1EYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 00:24:51 -0400
Received: from ozlabs.org ([203.11.71.1]:52809 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfH1EYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 00:24:51 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46JCM551djz9sNp; Wed, 28 Aug 2019 14:24:49 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f0f8d7ae3924ed93453e30123e4aaf6f888ca555
In-Reply-To: <7b1668941ad1041d08b19167030868de5840b153.1566309262.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        hch@lst.de
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/12] powerpc: remove the ppc44x ocm.c file
Message-Id: <46JCM551djz9sNp@ozlabs.org>
Date:   Wed, 28 Aug 2019 14:24:49 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-20 at 14:07:09 UTC, Christophe Leroy wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> The on chip memory allocator is entirely unused in the kernel tree.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f0f8d7ae3924ed93453e30123e4aaf6f888ca555

cheers
