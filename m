Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E679014457A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 20:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAUTzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 14:55:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:58169 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgAUTzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:55:33 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 00LJt2oG006385;
        Tue, 21 Jan 2020 13:55:02 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 00LJt16T006382;
        Tue, 21 Jan 2020 13:55:01 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 21 Jan 2020 13:55:01 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ruscur@russell.cc,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: GCC bug ? Re: [PATCH v2 10/10] powerpc/32s: Implement Kernel Userspace Access Protection
Message-ID: <20200121195501.GJ3191@gate.crashing.org>
References: <cover.1552292207.git.christophe.leroy@c-s.fr> <a2847248a92cb1641b1740fa121c5a30593ae662.1552292207.git.christophe.leroy@c-s.fr> <87ftqfu7j1.fsf@concordia.ellerman.id.au> <a008a182-f1db-073c-7d38-27bfd1fd8676@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a008a182-f1db-073c-7d38-27bfd1fd8676@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 05:22:32PM +0000, Christophe Leroy wrote:
> g1() should return 3, not 5.

What makes you say that?

"A return of 0 does not indicate that the
 value is _not_ a constant, but merely that GCC cannot prove it is a
 constant with the specified value of the '-O' option."

(And the rules it uses for this are *not* the same as C "constant
expressions" or C "integer constant expression" or C "arithmetic
constant expression" or anything like that -- which should be already
obvious from that it changes with different -Ox).

You can use builtin_constant_p to have the compiler do something better
if the compiler feels like it, but not anything more.  Often people
want stronger guarantees, but when they see how much less often it then
returns "true", they do not want that either.


Segher
