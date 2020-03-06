Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B6917B2E9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 01:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCFA1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 19:27:55 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:60829 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgCFA1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:47 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT3P3xd2z9sSW; Fri,  6 Mar 2020 11:27:45 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 365ad0b60d944050d61252e123e6a8b2c3950398
In-Reply-To: <20200208140904.7521-1-christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        oss@buserror.net, galak@kernel.crashing.org,
        benh@kernel.crashing.org, paulus@samba.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc/83xx: Fix some typo in some warning message
Message-Id: <48YT3P3xd2z9sSW@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:45 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-08 at 14:09:04 UTC, Christophe JAILLET wrote:
> "couldn;t" should be "couldn't".
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/365ad0b60d944050d61252e123e6a8b2c3950398

cheers
