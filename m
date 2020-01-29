Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A223C14C58B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgA2FRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:17:45 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgA2FRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:40 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDz1RWgz9sSS; Wed, 29 Jan 2020 16:17:38 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 173bf44bdfc768af3c07cd0aeeb6ad8d1331b77d
In-Reply-To: <20200114110012.17351-1-laurentiu.tudor@nxp.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "timur@kernel.org" <timur@kernel.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "swood@redhat.com" <swood@redhat.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of ehv_bytechan tty driver
Message-Id: <486sDz1RWgz9sSS@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:38 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-14 at 11:00:25 UTC, Laurentiu Tudor wrote:
> Michael Ellerman made a call for volunteers from NXP to maintain
> this driver and I offered myself.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/173bf44bdfc768af3c07cd0aeeb6ad8d1331b77d

cheers
