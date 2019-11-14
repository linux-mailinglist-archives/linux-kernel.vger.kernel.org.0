Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D272FC255
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfKNJJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:09:29 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:34023 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfKNJHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:48 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxZ3TnGz9sPV; Thu, 14 Nov 2019 20:07:46 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bbbd7f112c7b0af32f7b3c725b2c41e93cf181f6
In-Reply-To: <20190828060737.32531-1-thuth@redhat.com>
To:     Thomas Huth <thuth@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc: Replace GPL boilerplate with SPDX identifiers
Message-Id: <47DFxZ3TnGz9sPV@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:46 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 06:07:37 UTC, Thomas Huth wrote:
> The FSF does not reside in "675 Mass Ave, Cambridge" anymore...
> let's simply use proper SPDX identifiers instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bbbd7f112c7b0af32f7b3c725b2c41e93cf181f6

cheers
