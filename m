Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C4FB7760
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389342AbfISK0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 06:26:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46269 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389326AbfISK0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:26:04 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46YtKj1yP9z9sQw; Thu, 19 Sep 2019 20:26:00 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6ccb4ac2bf8a35c694ead92f8ac5530a16e8f2c8
In-Reply-To: <156821713818.1985334.14123187368108582810.stgit@bahia.lan>
To:     Greg Kurz <groug@kaod.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2] powerpc/xive: Fix bogus error code returned by OPAL
Message-Id: <46YtKj1yP9z9sQw@ozlabs.org>
Date:   Thu, 19 Sep 2019 20:26:00 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-11 at 15:52:18 UTC, Greg Kurz wrote:
> There's a bug in skiboot that causes the OPAL_XIVE_ALLOCATE_IRQ call
> to return the 32-bit value 0xffffffff when OPAL has run out of IRQs.
> Unfortunatelty, OPAL return values are signed 64-bit entities and
> errors are supposed to be negative. If that happens, the linux code
> confusingly treats 0xffffffff as a valid IRQ number and panics at some
> point.
> 
> A fix was recently merged in skiboot:
> 
> e97391ae2bb5 ("xive: fix return value of opal_xive_allocate_irq()")
> 
> but we need a workaround anyway to support older skiboots already
> in the field.
> 
> Internally convert 0xffffffff to OPAL_RESOURCE which is the usual error
> returned upon resource exhaustion.
> 
> Cc: stable@vger.kernel.org # v4.12+
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6ccb4ac2bf8a35c694ead92f8ac5530a16e8f2c8

cheers
