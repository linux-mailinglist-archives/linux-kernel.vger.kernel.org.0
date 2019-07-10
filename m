Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE56C618CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 03:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfGHBUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 21:20:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbfGHBTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:42 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hng06LbNz9sP0; Mon,  8 Jul 2019 11:19:40 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fbded57c962e7c42c932e1a46c8d801441726662
In-Reply-To: <1b4946c9e580b51b6ca2ddc5963d66406c013c2d.1560507284.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] powerpc/boot: don't force gzipped uImage
Message-Id: <45hng06LbNz9sP0@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-14 at 10:16:23 UTC, Christophe Leroy wrote:
> This patch modifies the generation of uImage by handing over
> the selected compression type instead of forcing gzip
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fbded57c962e7c42c932e1a46c8d801441726662

cheers
