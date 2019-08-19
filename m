Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C86B92653
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfHSORJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 10:17:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:52027 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfHSORJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:17:09 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7JEGjfs021854;
        Mon, 19 Aug 2019 09:16:45 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x7JEGjuS021851;
        Mon, 19 Aug 2019 09:16:45 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 19 Aug 2019 09:16:45 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/3] powerpc: rewrite LOAD_REG_IMMEDIATE() as an intelligent macro
Message-ID: <20190819141645.GI31406@gate.crashing.org>
References: <be2b971c89b1af30d680cedd14e99a83138ef40a.1566223054.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2b971c89b1af30d680cedd14e99a83138ef40a.1566223054.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Mon, Aug 19, 2019 at 01:58:10PM +0000, Christophe Leroy wrote:
> +.macro __LOAD_REG_IMMEDIATE r, x
> +	.if (\x) >= 0x80000000 || (\x) < -0x80000000
> +		__LOAD_REG_IMMEDIATE_32 \r, (\x) >> 32
> +		sldi	\r, \r, 32
> +		.if (\x) & 0xffff0000 != 0
> +			oris \r, \r, (\x)@__AS_ATHIGH
> +		.endif
> +		.if (\x) & 0xffff != 0
> +			oris \r, \r, (\x)@l
> +		.endif
> +	.else
> +		__LOAD_REG_IMMEDIATE_32 \r, \x
> +	.endif
> +.endm

How did you test this?  That last "oris" should be "ori"?

Rest looks good :-)


Segher
