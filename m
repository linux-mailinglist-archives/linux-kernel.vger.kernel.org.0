Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D38E6109777
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 02:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKZBNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 20:13:22 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:33821 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfKZBNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 20:13:22 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47MQrc6TCxz9sPV; Tue, 26 Nov 2019 12:13:20 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f2bb86937d86ebcb0e52f95b6d19aba1d850e601
In-Reply-To: <41c99bc06394a6bc2888631cb98a3ed2ae281ddb.1568295907.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        hch@infradead.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] powerpc/fixmap: don't clear fixmap area in paging_init()
Message-Id: <47MQrc6TCxz9sPV@ozlabs.org>
Date:   Tue, 26 Nov 2019 12:13:20 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 13:49:41 UTC, Christophe Leroy wrote:
> fixmap is intended to map things permanently like the IMMR region on
> FSL SOC (8xx, 83xx, ...), so don't clear it when initialising paging()
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f2bb86937d86ebcb0e52f95b6d19aba1d850e601

cheers
