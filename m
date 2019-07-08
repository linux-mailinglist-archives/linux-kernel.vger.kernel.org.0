Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE410618CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 03:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfGHBUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 21:20:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37177 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbfGHBTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:31 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hnfn6gBsz9sNf; Mon,  8 Jul 2019 11:19:29 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2200bbec12c428d7b276fb450e5755cdfe435ae5
In-Reply-To: <5c04f72569b508cd5477fa1bf15f0166d376cd3a.1555427420.git.nishadkamdar@gmail.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Joe Perches <joe@perches.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/5] powerpc: Use the correct style for SPDX License Identifier
Message-Id: <45hnfn6gBsz9sNf@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:29 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-16 at 15:28:57 UTC, Nishad Kamdar wrote:
> This patch corrects the SPDX License Identifier style
> in the powerpc Hardware Architecture related files.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2200bbec12c428d7b276fb450e5755cdfe435ae5

cheers
