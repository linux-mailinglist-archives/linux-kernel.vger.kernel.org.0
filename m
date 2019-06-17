Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE448B46
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 20:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfFQSDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 14:03:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:50407 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfFQSDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:03:49 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5HI3QhV012161;
        Mon, 17 Jun 2019 13:03:26 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x5HI3PGf012160;
        Mon, 17 Jun 2019 13:03:25 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 17 Jun 2019 13:03:25 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: fix suspend/resume when IBATs 4-7 are used
Message-ID: <20190617180325.GB7313@gate.crashing.org>
References: <4291e0dd36aafff58bec429ac5355d10206c72d6.1560751738.git.christophe.leroy@c-s.fr> <87y32040h0.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y32040h0.fsf@igel.home>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 06:53:47PM +0200, Andreas Schwab wrote:
>   AS      arch/powerpc/kernel/swsusp_32.o
> arch/powerpc/kernel/swsusp_32.S: Assembler messages:
> arch/powerpc/kernel/swsusp_32.S:109: Error: invalid bat number
> arch/powerpc/kernel/swsusp_32.S:111: Error: invalid bat number
(etc.)

It needs to be compiled for some specific machine, like -m750cl for
example, not just -many.  It probably should keep using mtspr, instead.


Segher
