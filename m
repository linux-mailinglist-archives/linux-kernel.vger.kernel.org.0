Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2471145529
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 14:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgAVNT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 08:19:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:38045 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbgAVNTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:19:24 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 00MDIsXk010897;
        Wed, 22 Jan 2020 07:18:54 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 00MDIsPK010895;
        Wed, 22 Jan 2020 07:18:54 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 22 Jan 2020 07:18:54 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ruscur@russell.cc,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: GCC bug ? Re: [PATCH v2 10/10] powerpc/32s: Implement Kernel Userspace Access Protection
Message-ID: <20200122131854.GK3191@gate.crashing.org>
References: <cover.1552292207.git.christophe.leroy@c-s.fr> <a2847248a92cb1641b1740fa121c5a30593ae662.1552292207.git.christophe.leroy@c-s.fr> <87ftqfu7j1.fsf@concordia.ellerman.id.au> <a008a182-f1db-073c-7d38-27bfd1fd8676@c-s.fr> <20200121195501.GJ3191@gate.crashing.org> <8501a33e-6c76-b6bd-9d8e-985313f94579@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8501a33e-6c76-b6bd-9d8e-985313f94579@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Jan 22, 2020 at 07:57:15AM +0100, Christophe Leroy wrote:
> GCC doc also says:
> 
> "if you use it in an inlined function and pass an argument of the 
> function as the argument to the built-in, GCC never returns 1 when you 
> call the inline function with a string constant"
> 
> Does GCC considers (void*)0 as a string constant ?

No, because it isn't (it's a pointer, not an array of characters).


Segher
