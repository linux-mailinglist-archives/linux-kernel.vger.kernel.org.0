Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3FC14C582
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgA2FR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:17:26 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:50881 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgA2FR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:26 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDh2bzQz9sRp; Wed, 29 Jan 2020 16:17:24 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 25dd118f4b2773490df12b9d190c1956cf3250c3
In-Reply-To: <20191120134115.14918-1-krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] macintosh: Fix Kconfig indentation
Message-Id: <486sDh2bzQz9sRp@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:24 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-20 at 13:41:15 UTC, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/25dd118f4b2773490df12b9d190c1956cf3250c3

cheers
