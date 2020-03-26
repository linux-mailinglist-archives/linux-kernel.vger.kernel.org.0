Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E804193E99
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 13:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgCZMGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 08:06:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59599 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbgCZMGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:06:49 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48p3cl2Frdz9sSs; Thu, 26 Mar 2020 23:06:46 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b4f00d5b2098320a0d4c4a6d31099bc0c9a85b02
In-Reply-To: <20200312064256.18735-1-afzal.mohd.ma@gmail.com>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Scott Wood <oss@buserror.net>, Paul Mackerras <paulus@samba.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: Re: [PATCH v4] powerpc: Replace setup_irq() by request_irq()
Message-Id: <48p3cl2Frdz9sSs@ozlabs.org>
Date:   Thu, 26 Mar 2020 23:06:46 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-12 at 06:42:55 UTC, afzal mohammed wrote:
> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b4f00d5b2098320a0d4c4a6d31099bc0c9a85b02

cheers
