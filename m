Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC70C34CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 14:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbfJAMvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 08:51:16 -0400
Received: from ms.lwn.net ([45.79.88.28]:36446 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfJAMvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:51:15 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3243B491;
        Tue,  1 Oct 2019 12:51:15 +0000 (UTC)
Date:   Tue, 1 Oct 2019 06:51:14 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jeremy Cline <jcline@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kmemleak: DEBUG_KMEMLEAK_EARLY_LOG_SIZE changed
 names
Message-ID: <20191001065114.761f92ab@lwn.net>
In-Reply-To: <20190925143209.GE7042@arrakis.emea.arm.com>
References: <20190925143114.19698-1-jcline@redhat.com>
        <20190925143209.GE7042@arrakis.emea.arm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 15:32:10 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Wed, Sep 25, 2019 at 02:31:14PM +0000, Jeremy Cline wrote:
> > Commit c5665868183f ("mm: kmemleak: use the memory pool for early
> > allocations") renamed CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE to
> > CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE. Update the documentation reference
> > to reflect that.
> > 
> > Signed-off-by: Jeremy Cline <jcline@redhat.com>  
> 
> I forgot about this. Thanks.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Applied, thanks.

jon
