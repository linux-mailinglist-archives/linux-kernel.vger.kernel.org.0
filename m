Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 192F31664B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 17:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfEGPK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 11:10:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:44656 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbfEGPK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:10:56 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x47FAVVb020331;
        Tue, 7 May 2019 10:10:31 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x47FAUGu020324;
        Tue, 7 May 2019 10:10:30 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 7 May 2019 10:10:30 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: slightly improve cache helpers
Message-ID: <20190507151030.GF8599@gate.crashing.org>
References: <0b460a85319fb89dab2c5d1200ac69a3e1b7c1ef.1557235807.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b460a85319fb89dab2c5d1200ac69a3e1b7c1ef.1557235807.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Tue, May 07, 2019 at 01:31:39PM +0000, Christophe Leroy wrote:
> Cache instructions (dcbz, dcbi, dcbf and dcbst) take two registers
> that are summed to obtain the target address. Using '%y0' argument
> gives GCC the opportunity to use both registers instead of only one
> with the second being forced to 0.

That's not quite right.  Sorry if I didn't explain it properly.

"m" allows all memory.  But this instruction only allows reg,reg and
0,reg addressing.  For that you need to use constraint "Z".

The output modifier "%y0" just makes [reg] (i.e. simple indirect addressing)
print as "0,reg" instead of "0(reg)" as it would by default (for just "%0").


Segher
