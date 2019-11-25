Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3B5108C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 11:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfKYKrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 05:47:24 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:50545 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbfKYKrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:47:10 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47M3d93bTmz9sRM; Mon, 25 Nov 2019 21:47:09 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: cbcaff7d27ad5c5d2c2db113ec489be88adb815a
In-Reply-To: <a212bd36fbd6179e0929b6c727febc35132ac25c.1568665466.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, oss@buserror.net,
        galak@kernel.crashing.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] powerpc/32s: automatically allocate BAT in setbat()
Message-Id: <47M3d93bTmz9sRM@ozlabs.org>
Date:   Mon, 25 Nov 2019 21:47:09 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-16 at 20:25:39 UTC, Christophe Leroy wrote:
> If no BAT is given to setbat(), select an available BAT.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cbcaff7d27ad5c5d2c2db113ec489be88adb815a

cheers
