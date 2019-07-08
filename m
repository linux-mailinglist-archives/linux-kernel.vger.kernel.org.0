Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA74D618CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 03:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfGHBUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 21:20:06 -0400
Received: from ozlabs.org ([203.11.71.1]:39415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbfGHBTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:42 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hng02jdlz9sNf; Mon,  8 Jul 2019 11:19:40 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 4128a89ac80d3714babde5b2811ffd058b09c229
In-Reply-To: <04852442b540e73be0a20e13f69ab8427fd102e0.1560494348.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, oss@buserror.net
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] powerpc/8xx: move CPM1 related files from sysdev/ to platforms/8xx
Message-Id: <45hng02jdlz9sNf@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-14 at 06:41:38 UTC, Christophe Leroy wrote:
> Only 8xx selects CPM1 and related CONFIG options are already
> in platforms/8xx/Kconfig
> 
> Move the related C files to platforms/8xx/.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4128a89ac80d3714babde5b2811ffd058b09c229

cheers
